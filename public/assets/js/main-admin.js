document.addEventListener("DOMContentLoaded", function () {
  const navBar = document.querySelector(".top-navbar");
  if (window.location.pathname === "/admin/login") {
    navBar.style.display = "none";
  }

  const sidebar = document.getElementById("sidebar");
  const mainContent = document.getElementById("main-content");
  const toggleButton = document.getElementById("toggle-sidebar");

  // Arrays para rastrear recursos dinâmicos
  let activeStyles = [];
  let activeScripts = [];

  function toggleSidebar() {
    const sidebar = document.getElementById("sidebar");
    const mainContent = document.getElementById("main-content");
    if (sidebar && mainContent) {
      sidebar.classList.toggle("active");
      mainContent.classList.toggle("shifted");
      console.log(sidebar.classList.contains("active") ? "Sidebar aberto" : "Sidebar fechado");
    } else {
      console.error("Elementos do sidebar não encontrados durante toggle:", { sidebar, mainContent });
    }
  }

  function closeSidebar() {
    const sidebar = document.getElementById("sidebar");
    const mainContent = document.getElementById("main-content");
    if (sidebar && mainContent && sidebar.classList.contains("active")) {
      sidebar.classList.remove("active");
      mainContent.classList.remove("shifted");
      console.log("Sidebar fechado");
    }
  }

  function initializeSidebar() {
    const toggleButton = document.getElementById("toggle-sidebar");
    const sidebar = document.getElementById("sidebar");
    const mainContent = document.getElementById("main-content");

    if (toggleButton && sidebar && mainContent) {
      toggleButton.removeEventListener("click", toggleSidebar);
      toggleButton.addEventListener("click", toggleSidebar);
      console.log("Eventos do sidebar reconfigurados com sucesso");
    } else {
      console.warn("Elementos do sidebar não encontrados. Tentando novamente em 100ms...", {
        toggleButton,
        sidebar,
        mainContent,
      });
      setTimeout(initializeSidebar, 100);
    }
  }

  function initializeNavLinks() {
    // Links da navbar (.nav-link)
    document.querySelectorAll(".nav-link").forEach((link) => {
      link.removeEventListener("click", handleNavClick);
      link.addEventListener("click", handleNavClick);
    });

    // Remove qualquer listener anterior para evitar duplicatas
    document.removeEventListener("click", handleDynamicLinkClick);
    // Usa delegação de eventos para capturar cliques em elementos com data-url
    document.addEventListener("click", handleDynamicLinkClick);
  }

  function handleNavClick(event) {
    event.preventDefault();
    const page = event.currentTarget.getAttribute("data-page");
    console.log("Carregando página:", page);
    loadPage(`/admin/${page}`);
    closeSidebar();
  }

  function handleDynamicLinkClick(event) {
    const target = event.target.closest("[data-url]");
    if (target) {
      event.preventDefault();
      const url = target.getAttribute("data-url");
      console.log("Clique detectado em elemento com data-url:", url);
      loadPage(url);
      closeSidebar();
    }
  }

  function loadStyle(src) {
    if (!document.querySelector(`link[href="${src}"]`)) {
      const link = document.createElement("link");
      link.rel = "stylesheet";
      link.href = src;
      link.onload = () => console.log(`Estilo carregado: ${src}`);
      link.onerror = () => console.error(`Erro ao carregar estilo: ${src}`);
      link.dataset.dynamic = "true";
      document.head.appendChild(link);
      return link;
    }
    return document.querySelector(`link[href="${src}"]`);
  }

  let scriptQueue = [];
  let isLoadingScript = false;

  function loadScript(src, callback) {
    scriptQueue.push({ src, callback });

    function processQueue() {
      if (isLoadingScript || scriptQueue.length === 0) {
        return;
      }

      isLoadingScript = true;
      const { src, callback } = scriptQueue.shift();

      if (!document.querySelector(`script[src="${src}"]`)) {
        console.log(`Iniciando carregamento do script: ${src}`);
        const script = document.createElement("script");
        script.src = src;
        script.onload = () => {
          console.log(`Script carregado com sucesso: ${src}`);
          callback();
          isLoadingScript = false;
          processQueue();
        };
        script.onerror = () => {
          console.error(`Erro ao carregar script: ${src}`);
          isLoadingScript = false;
          processQueue();
        };
        script.dataset.dynamic = "true";
        document.body.appendChild(script);
      } else {
        console.log(`Script já carregado anteriormente: ${src}`);
        callback();
        isLoadingScript = false;
        processQueue();
      }
    }

    processQueue();
  }

  function removeDynamicStyles() {
    document.querySelectorAll('link[data-dynamic="true"]').forEach((link) => {
      link.remove();
      console.log(`Estilo removido: ${link.href}`);
    });
  }

  function removeDynamicScripts() {
    document.querySelectorAll('script[data-dynamic="true"]').forEach((script) => {
      script.remove();
      console.log(`Script removido: ${script.src}`);
    });
  }

  function loadPage(url) {
    document.getElementById("loading").style.display = "block";
    fetch(url, { headers: { "X-Requested-With": "XMLHttpRequest" } })
      .then((response) => {
        console.log("Resposta da página:", response.status);
        return response.text();
      })
      .then((html) => {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, "text/html");
        const mainContentNew = doc.querySelector("main");
        if (mainContentNew) {
          mainContent.innerHTML = mainContentNew.innerHTML;
          console.log("Conteúdo carregado no main-content");

          // Reconfigura o sidebar e os links de navegação
          initializeSidebar();
          initializeNavLinks();
          closeSidebar();

          const newStyles = Array.from(doc.querySelectorAll('link[rel="stylesheet"]')).map((link) =>
            link.getAttribute("href")
          );
          const newScripts = Array.from(doc.querySelectorAll('script[src]')).map((script) =>
            script.getAttribute("src")
          );

          removeDynamicStyles();
          removeDynamicScripts();

          newStyles.forEach((src) => loadStyle(src));

          const initializeTinyMCEAfterLoad = () => {
            if (newScripts.includes("http://localhost:8000/assets/js/tiny-init.js")) {
              console.log("Scripts carregados. Inicializando TinyMCE manualmente...");
              if (typeof window.initializeTinyMCEOnDynamicLoad === "function") {
                window.initializeTinyMCEOnDynamicLoad();
              } else {
                console.warn(
                  "Função initializeTinyMCEOnDynamicLoad ainda não disponível. Tentando novamente em 100ms..."
                );
                setTimeout(initializeTinyMCEAfterLoad, 100);
              }
            }
          };

          newScripts.forEach((src) => loadScript(src, initializeTinyMCEAfterLoad));

          activeStyles = newStyles;
          activeScripts = newScripts;

          if (url === "/admin/home") {
            closeSidebar();
            animateCounters();
          }
        }
        document.getElementById("loading").style.display = "none";
      })
      .catch((error) => {
        console.error("Erro ao carregar a página:", error);
        document.getElementById("loading").style.display = "none";
      });
  }

  function animateCounters() {
    const metrics = document.querySelectorAll(".metric");
    if (metrics.length === 0) {
      console.warn("Nenhum elemento .metric encontrado no DOM.");
      return;
    }

    metrics.forEach((metric) => {
      const endValue = parseInt(metric.getAttribute("data-value"), 10);
      metric.textContent = "0";
      let startValue = 0;
      const duration = 300;
      const stepTime = Math.abs(Math.floor(duration / (endValue || 1)));

      if (metric.counter) {
        clearInterval(metric.counter);
      }

      metric.counter = setInterval(() => {
        startValue += 1;
        metric.textContent = startValue;
        if (startValue >= endValue) {
          metric.textContent = endValue;
          clearInterval(metric.counter);
        }
      }, stepTime);
    });
  }

  // Inicializar eventos no carregamento inicial
  initializeSidebar();
  initializeNavLinks();
  closeSidebar();

  if (window.location.pathname === "/admin/home") {
    closeSidebar();
    animateCounters();
  }

  let isAnimating = false;
  const observer = new MutationObserver((mutations) => {
    mutations.forEach(() => {
      if (document.querySelector(".dashboard-grid") && !isAnimating) {
        isAnimating = true;
        closeSidebar();
        animateCounters();
        setTimeout(() => {
          isAnimating = false;
        }, 2500);
      }
    });
  });
  observer.observe(mainContent, { childList: true, subtree: true });
});