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
      
    });
  }

  function removeDynamicScripts() {
    document
      .querySelectorAll('script[data-dynamic="true"]')
      .forEach((script) => {
        script.remove();
       
      });
  }

  function loadPage(url) {
    document.getElementById("loading").style.display = "block";
    fetch(url, { headers: { "X-Requested-With": "XMLHttpRequest" } })
      .then((response) => {
        
        return response.text();
      })
      .then((html) => {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, "text/html");
        const mainContentNew = doc.querySelector("main");
        if (mainContentNew) {
          mainContent.innerHTML = mainContentNew.innerHTML;
          

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


  const searchInput = document.getElementById('searchInput');
    const searchResults = document.getElementById('searchResults');
    const searchContainer = document.querySelector('.search-container'); // Corrigido aqui

    // Função para buscar resultados
    async function fetchResults(query) {
        try {
            const response = await fetch(`/procurar?q=${encodeURIComponent(query)}`, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json'
                }
            });
            if (!response.ok) throw new Error('Erro na busca');
            const data = await response.json();
            displayResults(data);
        } catch (error) {
            console.error('Erro ao buscar resultados:', error);
            searchResults.innerHTML = '<a href="#">Erro ao carregar resultados</a>';
        }
    }

    // Função para exibir resultados como links
    function displayResults(results) {
        searchResults.innerHTML = ''; // Limpa resultados anteriores
        if (results.length === 0) {
            searchResults.style.display = 'none';
            return;
        }

        results.forEach(result => {
            const link = document.createElement('a');
            link.href = result.url; // URL específica do resultado
            link.textContent = result.title; // Título do resultado
            searchResults.appendChild(link);
        });
        searchResults.style.display = 'block';
    }

    // Evento de digitação com debounce
    let timeout;
    searchInput.addEventListener('input', function () {
        clearTimeout(timeout);
        const query = this.value.trim();
        if (query.length < 2) { // Mínimo de 2 caracteres
            searchResults.style.display = 'none';
            return;
        }

        timeout = setTimeout(() => fetchResults(query), 300); // Debounce de 300ms
    });

    // Esconder resultados ao clicar fora
    document.addEventListener('click', function (e) {
        if (!searchContainer.contains(e.target)) {
            searchResults.style.display = 'none';
        }
    });
});
