<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    @css(https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css)
    @css(https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css)
    @css(https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css)
    @css(/assets/css/main-admin.css)
    @css(https://fonts.googleapis.com/icon?family=Material+Icons)
    @css(https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0)
    {{ $styles }}
    <title>{{ $title }}</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Montserrat', sans-serif;
            background: #141414;
            color: #fff;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .top-navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background: #222;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            height: 60px;
            z-index: 1100;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
        }

        .top-navbar h4 {
            margin: 0;
            font-weight: 600;
            color: #fff;
        }

        .top-navbar .profile img {
            width: 40px;
            height: 40px;
            border: 2px solid #e50914;
            transition: transform 0.3s ease;
        }

        .top-navbar .profile img:hover {
            transform: scale(1.1);
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 60px;
            left: -250px; /* Escondido por padrão */
            width: 250px;
            height: calc(100% - 60px);
            background: #222;
            padding: 20px;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.5);
            z-index: 1000;
            transition: left 0.3s ease;
        }

        .sidebar.active {
            left: 0; /* Visível */
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar li {
            margin-bottom: 10px;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #e0e0e0;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 500;
            border-radius: 5px;
            transition: background 0.3s ease, color 0.3s ease;
        }

        .sidebar a:hover,
        .sidebar a.nav-link:hover {
            background: #333;
            color: #e50914;
        }

        .sidebar a i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-top: 60px;
            margin-left: 0; /* Sem deslocamento por padrão */
            padding: 40px 20px;
            min-height: calc(100vh - 60px);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            transition: margin-left 0.3s ease;
        }

        .main-content.shifted {
            margin-left: 250px; /* Deslocado quando sidebar está ativo */
        }

        /* Botão de toggle */
        #toggle-sidebar {
            background: none;
            border: none;
            color: #e50914;
            font-size: 1.5rem;
            margin-right: 20px;
            cursor: pointer;
        }

        /* Spinner */
        #loading {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1200;
            color: #e50914;
        }

        #loading .fa-spinner {
            font-size: 2.5rem;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
                left: -200px;
            }
            .sidebar.active {
                left: 0;
            }
            .main-content.shifted {
                margin-left: 200px;
            }
            .main-content {
                padding: 20px 10px;
            }
        }
    </style>
</head>
<body>
    <div class="top-navbar">
        <div style="display: flex; align-items: center;">
            <button id="toggle-sidebar"><i class="bi bi-list"></i></button>
            <h4 class="text-white p-3">Painel Administrativo</h4>
        </div>
        <div class="profile">
            <img src="/assets/imgs/michelle.jpg" alt="Perfil" class="rounded-circle">
        </div>
    </div>

    <div class="sidebar" id="sidebar">
        <div style="text-align: center; padding: 20px 0;">
            <img src="/assets/imgs/logo.png" alt="HD Arte" style="max-width: 150px;">
        </div>
        <ul>
            <li><a href="#" class="nav-link" data-page="dashboard"><i class="bi bi-house-door"></i><span>Dashboard</span></a></li>
            <li><a href="#" class="nav-link" data-page="posts"><i class="bi bi-file-earmark-text"></i><span>Blog</span></a></li>
            <li><a href="#" class="nav-link" data-page="novo/blog"><i class="bi bi-pencil"></i><span>Novo Artigo</span></a></li>
            <li><a href="#" class="nav-link" data-page="todos/depoimentos"><i class="bi bi-chat-dots"></i><span>Depoimentos</span></a></li>
            <li><a href="#" class="nav-link" data-page="configuracoes"><i class="bi bi-gear"></i><span>Configurações</span></a></li>
            <li><a href="#" class="nav-link" data-page="parceiros"><i class="bi bi-people"></i><span>Parceiros</span></a></li>
            <li><a href="#" class="nav-link" data-page="todos/servicos"><i class="bi bi-briefcase"></i><span>Serviços</span></a></li>
            <li><a href="/admin/logout"><i class="bi bi-box-arrow-right"></i><span>Sair</span></a></li>
        </ul>
    </div>

    <div id="loading"><i class="fas fa-spinner"></i></div>

    <main class="main-content" id="main-content">
        {{ $content }}
    </main>

    @js('https://code.jquery.com/jquery-3.6.0.min.js')
    @js('https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js')
    {{ $scripts }}

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Seleção dos elementos
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('main-content');
            const toggleButton = document.getElementById('toggle-sidebar');

            // Função para alternar o sidebar
            function toggleSidebar() {
                sidebar.classList.toggle('active');
                mainContent.classList.toggle('shifted');
            }

            // 1 - Toggle do sidebar pelo botão
            if (toggleButton) {
                toggleButton.addEventListener('click', function () {
                    toggleSidebar();
                });
            } else {
                console.error('Botão #toggle-sidebar não encontrado!');
            }

            // 2 - Fechar sidebar ao clicar em um link e carregar página
            document.querySelectorAll('.nav-link').forEach(link => {
                link.addEventListener('click', function (event) {
                    event.preventDefault();
                    const page = this.getAttribute('data-page');
                    loadPage(`/admin/${page}`);
                    // Fechar sidebar se estiver aberto
                    if (sidebar.classList.contains('active')) {
                        toggleSidebar();
                    }
                });
            });

            // 3 - Função para carregar páginas dinamicamente
            function loadPage(url) {
                document.getElementById('loading').style.display = 'block';
                fetch(url, { headers: { "X-Requested-With": "XMLHttpRequest" } })
                    .then(response => response.text())
                    .then(html => {
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(html, 'text/html');
                        const mainContentNew = doc.querySelector('main');
                        if (mainContentNew) {
                            mainContent.innerHTML = mainContentNew.innerHTML;
                        }
                        document.getElementById('loading').style.display = 'none';
                    })
                    .catch(error => {
                        console.error('Erro ao carregar a página:', error);
                        document.getElementById('loading').style.display = 'none';
                    });
            }
        });
    </script>
</body>
</html>