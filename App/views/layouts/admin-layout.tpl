<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">    @css(https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css)

    @css(/assets/css/main-admin.min.css)
    @css(/assets/css/admin-layout.min.css)
    @css(https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap)
    {{ $styles }}
    <title>{{ $title }}</title>
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

    <button id="fab-menu-toggle" class="fab-menu" aria-label="Abrir menu">
        <i class="bi bi-list" id="fab-icon"></i>
    </button>

    <!-- Menu lateral que aparece ao clicar no FAB -->
    <nav id="fab-sidebar" class="fab-sidebar" aria-hidden="true">
        <div class="fab-sidebar-content">
            <div class="logo text-center my-3">
                <img src="/assets/imgs/logo.png" alt="Logo HD Arte" style="max-width: 140px;">
            </div>
            <ul id="fab-menu-items" class="list-unstyled px-2"></ul>
        </div>
    </nav>

    <div id="loading" aria-live="polite" aria-label="Carregando">
        <i class="fas fa-spinner"></i>
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    
    {{ $scripts }}
</body>
</html>