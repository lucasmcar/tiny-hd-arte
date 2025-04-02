document.addEventListener("DOMContentLoaded", function () {
    const navBar = document.querySelector(".top-navbar");
    if (window.location.pathname === "/admin/login") {
        navBar.style.display = "none";
    }

    if (performance.navigation.type === performance.navigation.TYPE_RELOAD) {
        console.log('Página recarregada via refresh. Redirecionando para /admin/home...');
        window.location.href = '/admin/home';
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

    function closeSidebar() {
        if (sidebar.classList.contains('active')) {
            sidebar.classList.remove('active');
            mainContent.classList.remove('shifted');
            console.log('Sidebar fechado');
        }
    }

    function initializeSidebar() {
        if (toggleButton) {
            toggleButton.removeEventListener('click', toggleSidebar);
            toggleButton.addEventListener('click', toggleSidebar);
        }
    }

    function initializeNavLinks() {
        document.querySelectorAll('.nav-link').forEach(link => {
            link.removeEventListener('click', handleNavClick);
            link.addEventListener('click', handleNavClick);
        });
    }

    function handleNavClick(event) {
        event.preventDefault();
        const page = event.currentTarget.getAttribute('data-page');
        console.log('Carregando página:', page);
        loadPage(`/admin/${page}`);
        closeSidebar();
    }

    function loadStyle(src) {
        if (!document.querySelector(`link[href="${src}"]`)) {
            const link = document.createElement('link');
            link.rel = 'stylesheet';
            link.href = src;
            link.onload = () => console.log(`Estilo carregado: ${src}`);
            link.onerror = () => console.error(`Erro ao carregar estilo: ${src}`);
            link.dataset.dynamic = 'true';
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
                console.log(`Script carregado: ${src}`);
                callback();
            };
            script.onerror = () => console.error(`Erro ao carregar script: ${src}`);
            script.dataset.dynamic = 'true';
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
            console.log(`Estilo removido: ${link.href}`);
        });
    }

    function removeDynamicScripts() {
        document.querySelectorAll('script[data-dynamic="true"]').forEach(script => {
            script.remove();
            console.log(`Script removido: ${script.src}`);
        });
    }

    function loadPage(url) {
        document.getElementById('loading').style.display = 'block';
        fetch(url, { headers: { "X-Requested-With": "XMLHttpRequest" } })
            .then(response => {
                console.log('Resposta da página:', response.status);
                return response.text();
            })
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');
                const mainContentNew = doc.querySelector('main');
                if (mainContentNew) {
                    mainContent.innerHTML = mainContentNew.innerHTML;
                    console.log('Conteúdo carregado no main-content');

                    

                    initializeSidebar();
                    initializeNavLinks();
                    closeSidebar(); // Fecha o sidebar após carregar a página

                    const newStyles = Array.from(doc.querySelectorAll('link[rel="stylesheet"]'))
                        .map(link => link.getAttribute('href'));
                    const newScripts = Array.from(doc.querySelectorAll('script[src]'))
                        .map(script => script.getAttribute('src'));

                    removeDynamicStyles();
                    removeDynamicScripts();

                    newStyles.forEach(src => loadStyle(src));
                    newScripts.forEach(src => loadScript(src, () => {}));

                    activeStyles = newStyles;
                    activeScripts = newScripts;

                    // Forçar animação no dashboard e fechar o sidebar
                    if (url === '/admin/home') {
                        closeSidebar(); // Garante que o sidebar esteja fechado
                        animateCounters();
                    }
                }
                document.getElementById('loading').style.display = 'none';
            })
            .catch(error => {
                console.error('Erro ao carregar a página:', error);
                document.getElementById('loading').style.display = 'none';
            });
    }

    function animateCounters() {
        const metrics = document.querySelectorAll('.metric');
        if (metrics.length === 0) {
            console.warn('Nenhum elemento .metric encontrado no DOM.');
            return;
        }

        metrics.forEach(metric => {
            const endValue = parseInt(metric.getAttribute('data-value'), 10);
            metric.textContent = '0';
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
    closeSidebar(); // Fecha o sidebar no carregamento inicial

    // Animação inicial no dashboard
    if (window.location.pathname === '/admin/home') {
        closeSidebar(); // Garante que o sidebar esteja fechado
        animateCounters();
    }

    let isAnimating = false;
    const observer = new MutationObserver((mutations) => {
        mutations.forEach(() => {
            if (document.querySelector('.dashboard-grid') && !isAnimating) {
                isAnimating = true;
                closeSidebar(); // Fecha o sidebar durante a animação
                animateCounters();
                setTimeout(() => { isAnimating = false; }, 2500);
            }
        });
    });
    observer.observe(mainContent, { childList: true, subtree: true });
});