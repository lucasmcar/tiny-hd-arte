document.addEventListener("DOMContentLoaded", function () {
  const navBar = document.querySelector(".top-navbar");
  if (window.location.pathname == "/admin/login") {
    navBar.style.display = "none";
  }
  const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('main-content');
            const toggleButton = document.getElementById('toggle-sidebar');

            // Arrays para rastrear recursos dinâmicos
            let activeStyles = [];
            let activeScripts = [];

            function toggleSidebar() {
                sidebar.classList.toggle('active');
                mainContent.classList.toggle('shifted');
            }

            if (toggleButton) {
                toggleButton.addEventListener('click', toggleSidebar);
            }

            document.querySelectorAll('.nav-link').forEach(link => {
                link.addEventListener('click', function (event) {
                    event.preventDefault();
                    const page = this.getAttribute('data-page');
                    loadPage(`/admin/${page}`);
                    if (sidebar.classList.contains('active')) {
                        toggleSidebar();
                    }
                });
            });

            function loadStyle(src) {
                if (!document.querySelector(`link[href="${src}"]`)) {
                    const link = document.createElement('link');
                    link.rel = 'stylesheet';
                    link.href = src;
                    
                    link.onerror = () => console.error(`Erro ao carregar estilo: ${src}`);
                    link.dataset.dynamic = 'true'; // Marcar como dinâmico
                    document.head.appendChild(link);
                    return link;
                }
                return document.querySelector(`link[href="${src}"]`);
            }

            function loadScript(src, callback) {
                if (!document.querySelector(`script[src="${src}"]`)) {
                    const script = document.createElement('script');
                    script.src = src;
                    script.onload = () => {
                        
                        callback();
                    };
                    script.onerror = () => console.error(`Erro ao carregar script: ${src}`);
                    script.dataset.dynamic = 'true'; // Marcar como dinâmico
                    document.body.appendChild(script);
                    return script;
                } else {
                    callback();
                }
                return document.querySelector(`script[src="${src}"]`);
            }

            function removeDynamicStyles() {
                document.querySelectorAll('link[data-dynamic="true"]').forEach(link => {
                    link.remove();
                   
                });
            }

            function removeDynamicScripts() {
                document.querySelectorAll('script[data-dynamic="true"]').forEach(script => {
                    script.remove();
                    
                });
            }

            function loadPage(url) {
                document.getElementById('loading').style.display = 'block';
                fetch(url, { headers: { "X-Requested-With": "XMLHttpRequest" } })
                    .then(response => {
                        
                        return response.text();
                    })
                    .then(html => {
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(html, 'text/html');
                        const mainContentNew = doc.querySelector('main');
                        if (mainContentNew) {
                            mainContent.innerHTML = mainContentNew.innerHTML;
                            

                            // Extrair novos estilos e scripts
                            const newStyles = Array.from(doc.querySelectorAll('link[rel="stylesheet"]'))
                                .map(link => link.getAttribute('href'));
                            const newScripts = Array.from(doc.querySelectorAll('script[src]'))
                                .map(script => script.getAttribute('src'));

                            // Remover todos os recursos dinâmicos antigos
                            removeDynamicStyles();
                            removeDynamicScripts();

                            // Carregar novos estilos
                            newStyles.forEach(src => {
                                loadStyle(src);
                            });

                            // Carregar novos scripts
                            newScripts.forEach(src => {
                                loadScript(src, () => {
                                    // A inicialização é responsabilidade do próprio script
                                });
                            });

                            // Atualizar os recursos ativos
                            activeStyles = newStyles;
                            activeScripts = newScripts;
                        }
                        document.getElementById('loading').style.display = 'none';
                    })
                    .catch(error => {
                        console.error('Erro ao carregar a página:', error);
                        document.getElementById('loading').style.display = 'none';
                    });
            }
});
