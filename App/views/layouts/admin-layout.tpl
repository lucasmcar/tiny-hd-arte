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
        z-index: 1000;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
    }

    .sidebar {
        position: fixed;
        top: 60px;
        left: -250px;
        width: 250px;
        height: calc(100% - 60px);
        background: #222;
        padding: 20px;
        box-shadow: 2px 0 10px rgba(0, 0, 0, 0.5);
        z-index: 999;
        transition: left 0.3s ease;
        overflow: auto;
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

    .sidebar.active {
        left: 0;
    }

    .sidebar ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .sidebar li {
        margin-bottom: 10px;
        position: relative;
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

    .sidebar .dropdown-menu {
        display: none;
        position: absolute;
        left: 0;
        top: 100%;
        background: #333;
        border: none;
        border-radius: 5px;
        padding: 0;
        width: 100%;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
        z-index: 1001;
    }

    .sidebar li:hover > .dropdown-menu {
        display: block;
    }

    .sidebar .dropdown-item {
        color: #e0e0e0;
        padding: 10px 20px;
        font-size: 0.9rem;
        transition: background 0.3s ease, color 0.3s ease;
    }

    .sidebar .dropdown-item:hover {
        background: #444;
        color: #e50914;
    }

    .sidebar .dropdown-toggle::after {
        margin-left: auto;
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

    #toggle-sidebar {
        background: none;
        border: none;
        color: #e50914;
        font-size: 1.5rem;
        margin-right: 20px;
        cursor: pointer;
    }

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

    /* Estilo do Contador Regressivo */
    .session-timer {
        position: fixed;
        top: 70px;
        right: 20px;
        background: #222;
        color: #e0e0e0;
        padding: 8px 15px;
        border-radius: 5px;
        font-size: 0.9rem;
        font-weight: 500;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
        z-index: 998;
    }

    /* Estilo do Modal ao Estilo Netflix */
    .modal-content {
        background: #222;
        color: #e0e0e0;
        border: none;
        border-radius: 8px;
    }

    .modal-header {
        border-bottom: 1px solid #333;
    }

    .modal-title {
        font-weight: 600;
        color: #fff;
    }

    .modal-body {
        font-size: 1rem;
        color: #e0e0e0;
    }

    .modal-footer {
        border-top: 1px solid #333;
    }

    .btn-netflix {
        background: #e50914;
        color: #fff;
        border: none;
        padding: 8px 20px;
        font-weight: 600;
        border-radius: 5px;
        transition: background 0.3s ease;
    }

    .btn-netflix:hover {
        background: #ff4d4d;
    }

    .btn-secondary-netflix {
        background: #333;
        color: #e0e0e0;
        border: none;
        padding: 8px 20px;
        font-weight: 600;
        border-radius: 5px;
        transition: background 0.3s ease;
    }

    .btn-secondary-netflix:hover {
        background: #444;
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
        .sidebar .dropdown-menu {
            position: static;
            width: 100%;
            box-shadow: none;
        }
        .session-timer {
            top: 60px;
            right: 10px;
            font-size: 0.8rem;
            padding: 5px 10px;
        }
    }

    /* Scrollbar do menu */
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


    </style>
</head>
<body>
    <div class="top-navbar">
        <div style="display: flex; align-items: center;">
            <button id="toggle-sidebar"><i class="bi bi-list"></i></button>
            <h4 class="text-white p-3">Painel Administrativo</h4>
        </div>
        <div class="profile">
            <img src="{{ $_SESSION['foto'] ? $_SESSION['foto'] : '/assets/imgs/default.jpg' }}" alt="Perfil" class="rounded-circle">
        </div>
    </div>

   <div class="sidebar" id="sidebar">
    <div style="text-align: center; padding: 20px 0;">
        <img src="/assets/imgs/logo.png" alt="HD Arte" style="max-width: 150px;">
    </div>
    <ul>
        <li><a href="/admin/home" class="nav-link" data-page="home"><i class="bi bi-house-door"></i><span>Dashboard</span></a></li>
        <li>
            <a href="#" class="nav-link accordion-toggle">
                <i class="bi bi-briefcase"></i><span>Consultoria</span>
                <i class="bi bi-chevron-down accordion-icon"></i>
            </a>
            <ul class="accordion-menu">
                <li><a href="#" class="nav-link" data-page="consultoria"><i class="bi bi-person-plus-fill"></i>Cadastro</a></li>
                <li><a href="#" class="nav-link" data-page="consultoria/lista"><i class="bi bi-list"></i>Registros</a></li>
            </ul>
        </li>

        <!-- Gestão de Projetos -->
        <li>
            <a href="#" class="nav-link accordion-toggle">
                <i class="bi bi-tools"></i><span>Gestão de Projetos</span>
                <i class="bi bi-chevron-down accordion-icon"></i>
            </a>
            <ul class="accordion-menu">
                <li><a href="#" class="nav-link" data-page="projetos-culturais"><i class="bi bi-clipboard-data"></i>Cadastro</a></li>
                <li><a href="#" class="nav-link" data-page="projetos-culturais/listaProjetos"><i class="bi bi-list"></i>Registros</a></li>
            </ul>
        </li>

        <!-- Eventos Culturais -->
        <li>
            <a href="#" class="nav-link accordion-toggle">
                <i class="bi bi-tools"></i><span>Eventos Culturais</span>
                <i class="bi bi-chevron-down accordion-icon"></i>
            </a>
            <ul class="accordion-menu">
                <li><a href="#" class="nav-link" data-page="eventos-culturais"><i class="bi bi-clipboard-data"></i>Cadastro</a></li>
                <li><a href="#" class="nav-link" data-page="eventos-culturais/listaEventos"><i class="bi bi-list"></i>Registros</a></li>
            </ul>
        </li>

        <!-- Agenciamento de Artistas -->
        <li>
            <a href="#" class="nav-link accordion-toggle">
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
            <a href="#" class="nav-link accordion-toggle">
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
            <a href="#" class="nav-link accordion-toggle">
                <i class="bi bi-file-earmark-text"></i><span>Blog</span>
                <i class="bi bi-chevron-down accordion-icon"></i>
            </a>
            <ul class="accordion-menu">
                <li><a href="#" class="nav-link" data-page="novo/blog"><i class="bi bi-pencil"></i>Novo Artigo</a></li>
                <li><a href="#" class="nav-link" data-page="posts"><i class="bi bi-file-earmark-text"></i>Posts</a></li>
            </ul>
        </li>

        <li>
            <a href="#" class="nav-link accordion-toggle">
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
            <a href="#" class="nav-link accordion-toggle">
                <i class="bi bi-chat-dots"></i><span>Depoimentos</span>
                <i class="bi bi-chevron-down accordion-icon"></i>
            </a>
            <ul class="accordion-menu">
                <li><a href="#" class="nav-link" data-page="depoimentos/gerenciar"><i class="bi bi-tools"></i>Gerenciar</a></li>
                <li><a href="#" class="nav-link" data-page="todos/depoimentos"><i class="bi bi-chat-dots"></i>Depoimentos</a></li>
            </ul>
        </li>

        <li>
            <a href="#" class="nav-link accordion-toggle">
                <i class="bi bi-people"></i><span>Parceiros</span>
                <i class="bi bi-chevron-down accordion-icon"></i>
            </a>
            <ul class="accordion-menu">
                <li><a href="#" class="nav-link" data-page="gerenciar/parceiros"><i class="bi bi-tools"></i>Gerenciar</a></li>
                <li><a href="#" class="nav-link" data-page="parceiros/todos"><i class="bi bi-people"></i>Lista de Parceiros</a></li>
            </ul>
        </li>

        <li><a href="#" class="nav-link" data-page="todos/servicos"><i class="bi bi-briefcase"></i><span>Serviços</span></a></li>
        <li><a href="/admin/logout" class="nav-link"><i class="bi bi-box-arrow-right"></i><span>Sair</span></a></li>
    </ul>
</div>

    <div id="loading"><i class="fas fa-spinner"></i></div>

    <!-- Contador Regressivo -->
    <div class="session-timer" id="session-timer">
        Sessão expira em: <span id="timer">00:00:00</span>
    </div>

    <!-- Modal de Aviso -->
    <div class="modal fade" id="session-expiry-modal" tabindex="-1" aria-labelledby="sessionExpiryModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="sessionExpiryModalLabel">Sessão Expirando</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
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

    <main class="main-content" id="main-content">
        {{ $content }}
    </main>

    @js('https://code.jquery.com/jquery-3.6.0.min.js')
    @js('https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js')
    {{ $scripts }}

    <!-- Script Inline para Passar o Tempo de Expiração -->
    <script>
        // Obtém o tempo de expiração do token da sessão (em segundos)
        const tokenExpiry = {{ isset($_SESSION['jwt_exp']) ? $_SESSION['jwt_exp'] : 0 }};
        const isLoggedIn =  {{ isset($_SESSION['jwt']) ? 'true' : 'false' }};
    </script>

    <!-- Script para o Contador Regressivo -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {

            if (window.location.pathname === '/admin/login') {
            // Esconde o elemento do contador, se existir
            const sessionTimer = document.getElementById('session-timer');
            if (sessionTimer) {
                sessionTimer.style.display = 'none';
            }
            return; // Não executa o contador na página de login
        }

        // Só executa o contador se o usuário estiver logado
        if (!isLoggedIn || tokenExpiry === 0) {
            // Esconde o elemento do contador se o usuário não estiver logado
            const sessionTimer = document.getElementById('session-timer');
            if (sessionTimer) {
                sessionTimer.style.display = 'none';
            }
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
        let isLoggingOut = false; // Controle para evitar múltiplos redirecionamentos
        let modalTimerInterval; 

        if (timeLeft <= 0) {
            // Se o tempo já tiver expirado, faz logout imediatamente
            sessionTimer.style.display = 'none';
            return;
        }

        function formatTime(seconds) {
            const hours = Math.floor(seconds / 3600);
            const minutes = Math.floor((seconds % 3600) / 60);
            const secs = seconds % 60;
            return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
        }


        function logout() {
            if (isLoggingOut) {
                return; // Evita múltiplas chamadas ao logout
            }
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
                    // Limpa o token no frontend
                    localStorage.removeItem('jwt');
                    sessionStorage.removeItem('jwt');
                    // Redireciona para a página de login
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

        const timerInterval = setInterval(function () {
            timeLeft--;

            timerElement.textContent = formatTime(timeLeft);

            if (timeLeft === 300) {
                sessionExpiryModal.show();
                let modalTimeLeft = 300;
                const modalTimerInterval = setInterval(function () {
                    modalTimeLeft--;
                    modalTimerElement.textContent = formatTime(modalTimeLeft);
                    if (modalTimeLeft <= 0) {
                        clearInterval(modalTimerInterval);
                    }
                }, 1000);
            }

            if (timeLeft <= 0) {
                clearInterval(timerInterval);
                window.location.href = '/admin/login';
            }
        }, 1000);

        timerElement.textContent = formatTime(timeLeft);
    });
    </script>
</body>
</html>