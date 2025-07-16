<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    @css(https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css)
    @css(https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css)
    @css(https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css)
    @css(/assets/css/main-admin.css)
    @css(https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap)
    {{ $styles }}
    <title>{{ $title }}</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #141414 0%, #000 100%);
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
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.7);
        }

        .top-navbar .brand {
            display: flex;
            align-items: center;
        }

        #toggle-sidebar {
            background: none;
            border: none;
            color: #e50914;
            font-size: 1.8rem;
            margin-right: 15px;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        #toggle-sidebar:hover {
            transform: rotate(90deg);
        }

        .top-navbar .brand h4 {
            margin: 0;
            font-weight: 600;
            color: #e0e0e0;
            font-size: 1.2rem;
        }

        .top-navbar .profile {
            display: flex;
            align-items: center;
        }

        .top-navbar .profile img {
            width: 40px;
            height: 40px;
            border: 2px solid #e50914;
            border-radius: 50%;
            transition: transform 0.3s ease;
        }

        .top-navbar .profile img:hover {
            transform: scale(1.15);
        }

        .sidebar {
            position: fixed;
            top: 60px;
            left: -250px;
            width: 250px;
            height: calc(100% - 60px);
            background: #222;
            padding: 20px;
            box-shadow: 2px 0 15px rgba(0, 0, 0, 0.6);
            z-index: 1000;
            transition: left 0.3s ease;
            overflow-y: auto;
        }

        .sidebar.active {
            left: 0;
        }

        .sidebar .logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .sidebar .logo img {
            max-width: 150px;
            transition: transform 0.3s ease;
        }

        .sidebar .logo img:hover {
            transform: scale(1.05);
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

        .accordion-toggle {
            position: relative;
            justify-content: space-between;
        }

        .accordion-icon {
            transition: transform 0.3s ease;
        }

        .accordion-toggle.active .accordion-icon {
            transform: rotate(180deg);
        }

        .accordion-menu {
            max-height: 0;
            padding-left: 20px;
            background: #2a2a2a;
            border-radius: 5px;
            margin-top: 5px;
            overflow: hidden;
            transition: max-height 0.3s ease, padding 0.3s ease;
        }

        .accordion-menu.active {
            padding: 10px 0;
            max-height: 300px; /* Altura máxima ajustada */
        }

        .accordion-menu li {
            margin-bottom: 5px;
        }

        .accordion-menu a {
            padding: 10px 15px;
            font-size: 0.9rem;
        }

        .accordion-menu a:hover {
            background: #444;
            color: #e50914;
        }

        .main-content {
            flex: 1;
            margin-top: 60px;
            margin-left: 0;
            padding: 40px 20px;
            min-height: calc(100vh - 60px);
            transition: margin-left 0.3s ease;
        }

        .main-content.shifted {
            margin-left: 250px;
        }

        #loading {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1200;
            color: #e50914;
            background: rgba(0, 0, 0, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.7);
        }

        #loading .fa-spinner {
            font-size: 2.5rem;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .session-timer {
            position: fixed;
            top: 70px;
            right: 20px;
            background: #222;
            color: #e0e0e0;
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 0.9rem;
            font-weight: 500;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
            z-index: 1000;
            transition: opacity 0.3s ease;
        }

        .session-timer.hidden {
            opacity: 0;
            pointer-events: none;
        }

        #session-expiry-modal .modal-content {
            background: #222;
            color: #e0e0e0;
            border: none;
            border-radius: 10px;
        }

        #session-expiry-modal .modal-header {
            border-bottom: 1px solid #333;
        }

        #session-expiry-modal .modal-title {
            font-weight: 600;
            color: #fff;
        }

        #session-expiry-modal .modal-body {
            font-size: 1rem;
            color: #e0e0e0;
        }

        #session-expiry-modal .modal-footer {
            border-top: 1px solid #333;
        }

        .btn-netflix {
            background: #e50914;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-weight: 600;
            border-radius: 5px;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn-netflix:hover {
            background: #ff4d4d;
            transform: translateY(-2px);
        }

        .btn-secondary-netflix {
            background: #333;
            color: #e0e0e0;
            border: none;
            padding: 10px 20px;
            font-weight: 600;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        .btn-secondary-netflix:hover {
            background: #444;
            transform: translateY(-2px);
        }

        /* Scrollbar do sidebar */
        .sidebar::-webkit-scrollbar {
            width: 6px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: #141414;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: #e42424;
            border-radius: 6px;
        }

        .sidebar::-webkit-scrollbar-thumb:hover {
            background: #dd6a6a;
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
            .session-timer {
                top: 60px;
                right: 10px;
                font-size: 0.8rem;
                padding: 5px 10px;
            }
            #loading {
                padding: 15px;
            }
        }

        @media (max-width: 480px) {
            .top-navbar {
                padding: 0 10px;
            }
            .top-navbar .brand h4 {
                font-size: 1rem;
            }
            .sidebar .logo img {
                max-width: 120px;
            }
            .main-content {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    @csrf
    <div class="top-navbar" role="banner">
        <div class="brand">
            <button id="toggle-sidebar" aria-label="Alternar menu lateral" aria-expanded="false">
                <i class="bi bi-list"></i>
            </button>
            <h4>Painel Administrativo</h4>
        </div>
        <div class="profile" role="img" aria-label="Foto de perfil">
            <img src="{{ $_SESSION['foto'] ? $_SESSION['foto'] : '/assets/imgs/default.jpg' }}" alt="Foto de perfil do usuário">
        </div>
    </div>

    <div class="sidebar" id="sidebar" aria-label="Menu Lateral">
        <div class="logo">
            <img src="/assets/imgs/logo.png" alt="Logo HD Arte">
        </div>
        <ul>
            <li><a href="/admin/home" class="nav-link" data-page="home" aria-current="page"><i class="bi bi-house-door"></i><span>Dashboard</span></a></li>
            <li>
                <a href="#" class="nav-link accordion-toggle" aria-expanded="false">
                    <i class="bi bi-briefcase"></i><span>Consultoria</span>
                    <i class="bi bi-chevron-down accordion-icon"></i>
                </a>
                <ul class="accordion-menu">
                    <li><a href="#" class="nav-link" data-page="consultoria"><i class="bi bi-person-plus-fill"></i>Cadastro</a></li>
                    <li><a href="#" class="nav-link" data-page="consultoria/lista"><i class="bi bi-list"></i>Registros</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="nav-link accordion-toggle" aria-expanded="false">
                    <i class="bi bi-tools"></i><span>Gestão de Projetos</span>
                    <i class="bi bi-chevron-down accordion-icon"></i>
                </a>
                <ul class="accordion-menu">
                    <li><a href="#" class="nav-link" data-page="projetos-culturais"><i class="bi bi-clipboard-data"></i>Cadastro</a></li>
                    <li><a href="#" class="nav-link" data-page="projetos-culturais/listaProjetos"><i class="bi bi-list"></i>Registros</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="nav-link accordion-toggle" aria-expanded="false">
                    <i class="bi bi-calendar-event"></i><span>Eventos Culturais</span>
                    <i class="bi bi-chevron-down accordion-icon"></i>
                </a>
                <ul class="accordion-menu">
                    <li><a href="#" class="nav-link" data-page="eventos-culturais"><i class="bi bi-clipboard-data"></i>Cadastro</a></li>
                    <li><a href="#" class="nav-link" data-page="eventos-culturais/listaEventos"><i class="bi bi-list"></i>Registros</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="nav-link accordion-toggle" aria-expanded="false">
                    <i class="bi bi-person"></i><span>Agenciamento</span>
                    <i class="bi bi-chevron-down accordion-icon"></i>
                </a>
                <ul class="accordion-menu">
                    <li><a href="#" class="nav-link" data-page="agenciamento-artistas"><i class="bi bi-person-plus-fill"></i>Cadastro</a></li>
                    <li><a href="#" class="nav-link" data-page="agenciamento-artistas/listaContratos"><i class="bi bi-file-earmark-text"></i>Contratos</a></li>
                    <li><a href="#" class="nav-link" data-page="agenciamento-artistas/listaAgenda"><i class="bi bi-calendar-event"></i>Agenda</a></li>
                    <li><a href="#" class="nav-link" data-page="agenciamento-artistas/listaArtistas"><i class="bi bi-person-lines-fill"></i>Artistas</a></li>
                    <li><a href="#" class="nav-link" data-page="agenciamento-artistas/listaHistorico"><i class="bi bi-clock-history"></i>Histórico</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="nav-link accordion-toggle" aria-expanded="false">
                    <i class="bi bi-calendar-event"></i><span>Eventos</span>
                    <i class="bi bi-chevron-down accordion-icon"></i>
                </a>
                <ul class="accordion-menu">
                    <li><a href="#" class="nav-link" data-page="evento"><i class="bi bi-tools"></i>Gerenciar</a></li>
                    <li><a href="#" class="nav-link" data-page="editais"><i class="bi bi-file-earmark-pdf-fill"></i>Editais</a></li>
                    <li><a href="#" class="nav-link" data-page="evento/participantes"><i class="bi bi-people-fill"></i>Participantes</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="nav-link accordion-toggle" aria-expanded="false">
                    <i class="bi bi-file-earmark-text"></i><span>Blog</span>
                    <i class="bi bi-chevron-down accordion-icon"></i>
                </a>
                <ul class="accordion-menu">
                    <li><a href="#" class="nav-link" data-page="novo/blog"><i class="bi bi-pencil"></i>Novo Artigo</a></li>
                    <li><a href="#" class="nav-link" data-page="posts"><i class="bi bi-file-earmark-text"></i>Posts</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="nav-link accordion-toggle" aria-expanded="false">
                    <i class="bi bi-gear"></i><span>Configurações</span>
                    <i class="bi bi-chevron-down accordion-icon"></i>
                </a>
                <ul class="accordion-menu">
                    <li><a href="#" class="nav-link" data-page="perfil"><i class="bi bi-person"></i>Perfil</a></li>
                    <li><a href="#" class="nav-link" data-page="configuracoes/site"><i class="bi bi-globe"></i>Site</a></li>
                    <li><a href="#" class="nav-link" data-page="configuracoes/log"><i class="bi bi-card-list"></i>Logs</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="nav-link accordion-toggle" aria-expanded="false">
                    <i class="bi bi-chat-dots"></i><span>Depoimentos</span>
                    <i class="bi bi-chevron-down accordion-icon"></i>
                </a>
                <ul class="accordion-menu">
                    <li><a href="#" class="nav-link" data-page="depoimentos/gerenciar"><i class="bi bi-tools"></i>Gerenciar</a></li>
                    <li><a href="#" class="nav-link" data-page="todos/depoimentos"><i class="bi bi-chat-dots"></i>Depoimentos</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="nav-link accordion-toggle" aria-expanded="false">
                    <i class="bi bi-people"></i><span>Parceiros</span>
                    <i class="bi bi-chevron-down accordion-icon"></i>
                </a>
                <ul class="accordion-menu">
                    <li><a href="#" class="nav-link" data-page="gerenciar/parceiros"><i class="bi bi-tools"></i>Gerenciar</a></li>
                    <li><a href="#" class="nav-link" data-page="parceiros/todos"><i class="bi bi-people"></i>Lista de Parceiros</a></li>
                </ul>
            </li>
            <li><a href="/admin/logout" class="nav-link" aria-label="Sair da conta"><i class="bi bi-box-arrow-right"></i><span>Sair</span></a></li>
        </ul>
    </div>

    <div id="loading" aria-live="polite" aria-label="Carregando">
        <i class="fas fa-spinner"></i>
    </div>

    <div class="session-timer" id="session-timer" aria-live="polite" aria-label="Tempo restante da sessão">
        Sessão expira em: <span id="timer">00:00:00</span>
    </div>

    <div class="modal fade" id="session-expiry-modal" tabindex="-1" aria-labelledby="sessionExpiryModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="sessionExpiryModalLabel">Sessão Expirando</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Fechar"></button>
                </div>
                <div class="modal-body">
                    Sua sessão está prestes a expirar em <span id="modal-timer">5:00</span>. Você será deslogado automaticamente quando o tempo acabar.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary-netflix" data-bs-dismiss="modal">Continuar</button>
                    <button type="button" class="btn btn-netflix" onclick="window.location.href='/admin/logout'">Sair Agora</button>
                </div>
            </div>
        </div>
    </div>

    <main class="main-content" id="main-content" role="main">
        {{ $content }}
    </main>

    @js('https://code.jquery.com/jquery-3.6.0.min.js')
    @js('https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js')
    {{ $scripts }}

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            if (window.location.pathname === '/admin/login') {
                const sessionTimer = document.getElementById('session-timer');
                if (sessionTimer) sessionTimer.classList.add('hidden');
                return;
            }

            if (!isLoggedIn || tokenExpiry === 0) {
                const sessionTimer = document.getElementById('session-timer');
                if (sessionTimer) sessionTimer.classList.add('hidden');
                return;
            }

            const timerElement = document.getElementById('timer');
            const modalTimerElement = document.getElementById('modal-timer');
            const sessionExpiryModal = new bootstrap.Modal(document.getElementById('session-expiry-modal'), {
                backdrop: 'static',
                keyboard: false
            });

            const now = Math.floor(Date.now() / 1000);
            let timeLeft = tokenExpiry - now;
            let isLoggingOut = false;
            let modalTimerInterval;

            function formatTime(seconds) {
                const hours = Math.floor(seconds / 3600);
                const minutes = Math.floor((seconds % 3600) / 60);
                const secs = seconds % 60;
                return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
            }

            function logout() {
                if (isLoggingOut) return;
                isLoggingOut = true;
                fetch('/admin/logout', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': document.querySelector('input[name="_csrf_token"]')?.value
                    }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        localStorage.removeItem('jwt');
                        sessionStorage.removeItem('jwt');
                        window.location.href = '/admin/login?loggedOut=true';
                    } else {
                        console.error('Erro ao fazer logout:', data.message);
                        window.location.href = '/admin/login?loggedOut=true';
                    }
                })
                .catch(error => {
                    console.error('Erro ao fazer logout:', error);
                    window.location.href = '/admin/login?loggedOut=true';
                });
            }

            const timerInterval = setInterval(() => {
                timeLeft--;
                timerElement.textContent = formatTime(timeLeft);

                if (timeLeft === 300) {
                    sessionExpiryModal.show();
                    let modalTimeLeft = 300;
                    modalTimerInterval = setInterval(() => {
                        modalTimeLeft--;
                        modalTimerElement.textContent = formatTime(modalTimeLeft);
                        if (modalTimeLeft <= 0) clearInterval(modalTimerInterval);
                    }, 1000);
                }

                if (timeLeft <= 0) {
                    clearInterval(timerInterval);
                    logout();
                }
            }, 1000);

            timerElement.textContent = formatTime(timeLeft);

            // Toggle Sidebar
            const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.getElementById('toggle-sidebar');
            const mainContent = document.getElementById('main-content');

            toggleBtn.addEventListener('click', () => {
                sidebar.classList.toggle('active');
                mainContent.classList.toggle('shifted');
                toggleBtn.setAttribute('aria-expanded', sidebar.classList.contains('active'));
            });

            // Accordion Menu
            document.querySelectorAll('.accordion-toggle').forEach(item => {
                item.addEventListener('click', (e) => {
                    e.preventDefault();
                    const menu = item.nextElementSibling;
                    const isActive = menu.classList.contains('active');
                    document.querySelectorAll('.accordion-menu').forEach(m => m.classList.remove('active'));
                    document.querySelectorAll('.accordion-toggle').forEach(t => t.classList.remove('active'));
                    if (!isActive) {
                        item.classList.add('active');
                        menu.classList.add('active');
                    }
                    item.setAttribute('aria-expanded', !isActive);
                });
            });
        });
    </script>
</body>
</html>