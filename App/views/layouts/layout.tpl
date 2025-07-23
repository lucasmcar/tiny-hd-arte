<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/x-icon" href="/assets/imgs/favicon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Consultoria especializada em editais culturais, produção executiva e captação de recursos para projetos artísticos. Ajude sua produtora cultural a alcançar sucesso com estratégias eficazes de financiamento e gestão.">
    <meta name="keywords" content="consultoria, editais culturais, produção executiva, captação de recursos, projetos artísticos, produtora cultural, financiamento, gestão, hd arte, gestao">
    <!-- Compiled and minified CSS -->
    @css(https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css)
    @css(https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css)
    @css(https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css)
    @css(/assets/css/main.css)
    @css(https://fonts.googleapis.com/icon?family=Material+Icons)
    <link rel="preconnect"  href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
    <link rel="stylesheet"  href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
    {{ $styles }}

    <title>{{ $title }}</title>
    <style>
        body {
            background: #141414; /* Fundo escuro hda */
            color: #fff;
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding-top: 80px; /* Espaço para navbar fixo */
            scrollbar-width: thin; /* Firefox */
            scrollbar-color: #333 #141414; /* Firefox: thumb e track */
        }

        /* WebKit Scrollbar */
        body::-webkit-scrollbar {
            width: 8px;
        }

        body::-webkit-scrollbar-track {
            background: #141414;
        }

        body::-webkit-scrollbar-thumb {
            background: #333;
            border-radius: 4px;
        }

        body::-webkit-scrollbar-thumb:hover {
            background: #555;
        }

        /* Navbar */
        .navbar {
            background-color: #141414; /* Fundo escuro hda */
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5); /* Sombra sutil */
        }

        .navbar-brand img {
            max-height: 40px; /* Ajuste conforme o tamanho da sua logo */
        }

        .navbar-nav .nav-link {
            color: #fff;
            font-size: 1rem;
            font-weight: 500;
            padding: 10px 15px;
            transition: color 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            color: #e50914; /* Vermelho hda no hover */
        }

        /* Campo de Pesquisa */
        .search-form {
            position: relative;
            max-width: 250px;
            margin-left: 20px;
        }

        .search-input {
            background: #333; /* Cinza escuro */
            color: #fff;
            border: 2px solid transparent;
            padding: 8px 35px 8px 15px; /* Espaço para o ícone */
            font-size: 0.9rem;
            border-radius: 5px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            width: 100%;
        }

        .search-input:focus {
            border-color: #e50914; /* Vermelho hda ao focar */
            box-shadow: 0 0 5px rgba(229, 9, 20, 0.5);
            outline: none;
        }

        .search-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #fff;
            cursor: pointer;
            font-size: 1rem;
            pointer-events: none; /* Não interfere no clique */
        }

        .search-container {
        position: relative;
        max-width: 250px;
        margin-left: 20px;
    }

    .search-form {
        position: relative;
    }

    .search-input {
        background: #333;
        color: #fff;
        border: 2px solid transparent;
        padding: 8px 35px 8px 15px;
        font-size: 0.9rem;
        border-radius: 5px;
        transition: border-color 0.3s ease, box-shadow 0.3s ease;
        width: 100%;
    }

    .search-input:focus {
        border-color: #e50914;
        box-shadow: 0 0 5px rgba(229, 9, 20, 0.5);
        outline: none;
    }

    .search-icon {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        color: #fff;
        font-size: 1rem;
        pointer-events: none;
    }

    /* Resultados da Busca */
    .search-results {
        position: absolute;
        top: 100%;
        left: 0;
        width: 100%;
        background: #222; /* Cinza escuro hda */
        border-radius: 5px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
        max-height: 300px;
        overflow-y: auto;
        z-index: 1000;
        display: none; /* Escondido por padrão */
    }

    .search-results a {
        display: block;
        padding: 10px 15px;
        color: #e0e0e0; /* Cinza claro */
        text-decoration: none;
        font-size: 0.9rem;
        transition: background-color 0.3s ease, color 0.3s ease;
    }

    .search-results a:hover {
        background-color: #333;
        color: #e50914; /* Vermelho hda no hover */
    }

    .search-results:empty {
        display: none; /* Esconde se não houver resultados */
    }

    /* Scrollbar dos Resultados */
    .search-results::-webkit-scrollbar {
        width: 6px;
    }

    .search-results::-webkit-scrollbar-track {
        background: #141414;
    }

    .search-results::-webkit-scrollbar-thumb {
        background: #333;
        border-radius: 3px;
    }

    .search-results::-webkit-scrollbar-thumb:hover {
        background: #555;
    }

        /* Ícones Sociais no Navbar */
        .social-icons {
            display: flex;
            align-items: center;
            margin-left: 20px;
        }

        .social-icons a {
            color: #fff;
            font-size: 1.2rem;
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        .social-icons a:hover {
            color: #e50914; /* Vermelho hda no hover */
        }

        /* Divider */
        .divider {
            height: 30px;
            width: 1px;
            background: #333;
            margin: 0 15px;
        }

        /* Main Content */
        .main-content {
            flex: 1;
        }

        /* Footer */
        .footer {
            background-color: #222; /* Cinza escuro */
            color: #fff;
            text-align: center;
            padding: 20px 0;
            width: 100%;
        }

        .footer h5 {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .footer a {
            color: #fff;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: #e50914; /* Vermelho hda no hover */
        }

        .footer .list-unstyled li {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="/"><img src="/assets/imgs/logo.png" alt="Logo da HD Arte"></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="/sobre">Quem Somos</a></li>
                    <li class="nav-item"><a class="nav-link" href="/servicos">Serviços</a></li>
                    <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="projectsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Projetos
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="projectsDropdown">
                        <li><a class="dropdown-item" href="/projetos">Cases</a></li>
                        <li><a class="dropdown-item" href="/projetos/status/em-captacao">Em Captação</a></li>
                        <li><a class="dropdown-item" href="/projetos/status/ocorridos">Ocorridos</a></li>
                        <li><a class="dropdown-item" href="/projetos/status/aprovados">Projetos Aprovados</a></li>
                        <li><a class="dropdown-item" href="/projetos/status/em-andamento">Projetos em Andamento</a></li>
                    </ul>
                </li>
                    <li class="nav-item"><a class="nav-link" href="/equipe">Equipe</a></li>
                    <li class="nav-item"><a class="nav-link" href="/consultoria">Consultoria</a></li>
                    <li class="nav-item"><a class="nav-link" href="/contato">Contato</a></li>
                </ul>
                <div class="divider"></div>
                <!-- Campo de Pesquisa com Contêiner de Resultados -->
                <div class="search-container">
                    <form class="search-form" action="procurar" method="GET">
                        <input type="text" class="search-input" name="q" placeholder="Pesquisar..." id="searchInput">
                        <i class="bi bi-search search-icon"></i>
                    </form>
                    <div class="search-results" id="searchResults"></div>
                </div>
                <!-- Ícones Sociais -->
                <div class="social-icons">
                    <a href="https://www.instagram.com/seuperfil" target="_blank"><i class="fab fa-instagram"></i></a>
                    <a href="https://www.facebook.com/seupagina" target="_blank"><i class="fab fa-facebook-f"></i></a>
                    <a href="https://www.linkedin.com/in/seuperfil" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        {{ $content }}
    </main>

    <!-- Footer -->
    <footer class="footer mt-3 py-3 bg-dark text-white">
        <div class="container">
            <div class="row">
                <!-- Coluna 1: Links do Menu -->
                <div class="col-md-4">
                    <h5>Menu</h5>
                    <ul class="list-unstyled">
                        <li><a href="/">Home</a></li>
                        <li><a href="/sobre">Quem Somos</a></li>
                        <li><a href="/servicos">Serviços</a></li>
                        <li><a href="/projetos">Serviços</a></li>
                        <li><a href="/consultoria">Consultoria</a></li>
                        <li><a href="/contato">Contato</a></li>
                    </ul>
                </div>
                <!-- Coluna 2: Redes Sociais -->
                <div class="col-md-4 text-center mb-3">
                    <h5>Redes Sociais</h5>
                    <a href="https://facebook.com" class="text-white me-3"><i class="fab fa-facebook fa-2x"></i></a>
                    <a href="https://instagram.com" class="text-white me-3"><i class="fab fa-instagram fa-2x"></i></a>
                    <a href="https://linkedin.com" class="text-white"><i class="fab fa-linkedin fa-2x"></i></a>
                </div>
                <!-- Coluna 3: Copyright -->
                <div class="col-md-4 text-center">
                    <h5>© {% year %} HD Arte Produções</h5>
                    <p>Todos os direitos reservados.</p>
                </div>
            </div>
        </div>
    </footer>
    <div vw class="enabled">
    <div vw-access-button class="active"></div>
    <div vw-plugin-wrapper>
      <div class="vw-plugin-top-wrapper"></div>
    </div>
  </div>
    
    <!-- Bootstrap JS -->
    @js('https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.min.js')
    @js('/assets/js/main.min.js')
    @js('/assets/js/fetch.min.js')
    @js('https://vlibras.gov.br/app/vlibras-plugin.js')
    <script>
        new window.VLibras.Widget('https://vlibras.gov.br/app');
    </script>

    {{ $scripts }}
<script>
document.addEventListener('DOMContentLoaded', function () {
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
</script>
</body>
</html>