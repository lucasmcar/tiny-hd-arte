document.addEventListener("DOMContentLoaded", function () {

  function loadStyle(src) {
    if (!document.querySelector(`link[href="${src}"]`)) {
      const link = document.createElement("link");
      link.rel = "stylesheet";
      link.href = src;
      link.onload = () => console.log(`Estilo carregado: ${src}`);
      link.onerror = () => console.error(`Erro ao carregar estilo: ${src}`);
      link.dataset.dynamic = "true"; // Marcar como dinâmico
      document.head.appendChild(link);
      return link;
    }
    return document.querySelector(`link[href="${src}"]`);
  }

  function loadScript(src, callback) {
    if (!document.querySelector(`script[src="${src}"]`)) {
      const script = document.createElement("script");
      script.src = src;
      script.onload = () => {
        console.log(`Script carregado: ${src}`);
        callback();
      };
      script.onerror = () => console.error(`Erro ao carregar script: ${src}`);
      script.dataset.dynamic = "true"; // Marcar como dinâmico
      document.body.appendChild(script);
      return script;
    } else {
      callback();
    }
    return document.querySelector(`script[src="${src}"]`);
  }

  function removeDynamicStyles() {
    document.querySelectorAll('link[data-dynamic="true"]').forEach((link) => {
      link.remove();
      console.log(`Estilo removido: ${link.href}`);
    });
  }

  function removeDynamicScripts() {
    document
      .querySelectorAll('script[data-dynamic="true"]')
      .forEach((script) => {
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

          // Extrair novos estilos e scripts
          const newStyles = Array.from(
            doc.querySelectorAll('link[rel="stylesheet"]')
          ).map((link) => link.getAttribute("href"));
          const newScripts = Array.from(
            doc.querySelectorAll("script[src]")
          ).map((script) => script.getAttribute("src"));

          // Remover todos os recursos dinâmicos antigos
          removeDynamicStyles();
          removeDynamicScripts();

          // Carregar novos estilos
          newStyles.forEach((src) => {
            loadStyle(src);
          });

          // Carregar novos scripts
          newScripts.forEach((src) => {
            loadScript(src, () => {
              // A inicialização é responsabilidade do próprio script
            });
          });

          // Atualizar os recursos ativos
          activeStyles = newStyles;
          activeScripts = newScripts;
        }
        document.getElementById("loading").style.display = "none";
      })
      .catch((error) => {
        console.error("Erro ao carregar a página:", error);
        document.getElementById("loading").style.display = "none";
      });
  }
});
