<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Consultoria especializada em editais culturais, produção executiva e captação de recursos para projetos artísticos. Ajude sua produtora cultural a alcançar sucesso com estratégias eficazes de financiamento e gestão.">
    <meta name="keywords" content="consultoria, editais culturais, produção executiva, captação de recursos, projetos artísticos, produtora cultural, financiamento, gestão">
    <!-- Compiled and minified CSS -->
    @css(https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css)
    @css(https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css)
    @css(https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css)
    @css(/assets/css/main.css)
    @css(https://fonts.googleapis.com/icon?family=Material+Icons)
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
  
    <title>{{ $title }}</title>
    <style>
    .main-content {
    flex: 1;
}

/* Estiliza o footer */
.footer {
    background-color: #222;
    color: white;
    text-align: center;
    padding: 20px;
    width: 100%;
}
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/site/"><img src="/assets/imgs/logo.png" alt="logo da Hd Arte"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="/site/sobre">Quem Somos</a></li>
                <li class="nav-item"><a class="nav-link" href="/site/servicos">Serviços</a></li>
                <li class="nav-item"><a class="nav-link" href="/site/equipe">Equipe</a></li>
                <li class="nav-item"><a class="nav-link" href="/site/consultoria">Consultoria</a></li>
                <li class="nav-item"><a class="nav-link" href="/site/contato">Contato</a></li>
            </ul>
            <div class="divider"></div>
            <div class="social-icons">
                <a href="https://www.instagram.com/seuperfil" target="_blank"><i class="fab fa-instagram"></i></a>
                <a href="https://www.facebook.com/seupagina" target="_blank"><i class="fab fa-facebook-f"></i></a>
                <a href="https://www.linkedin.com/in/seuperfil" target="_blank"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>
    </div>
</nav>   
    <main class="main-content">
        {{ $content }}
    </main>
    <!-- Rodapé -->

    <footer class="footer mt-3 py-3 bg-dark text-white">
    <div class="container">
        <div class="row">
            <!-- Coluna 1: Links do Menu -->
            <div class="col-md-4">
                <h5>Menu</h5>
                <ul class="list-unstyled">
                    <li><a href="/" class="text-white">Home</a></li>
                    <li><a href="/sobre" class="text-white">Quem Somos</a></li>
                    <li><a href="/servicos" class="text-white">Serviços</a></li>
                    <li><a href="/consultoria" class="text-white">Consultoria</a></li>
                    <li><a href="/contato" class="text-white">Contato</a></li>
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
                <h5>&copy; {% year %} HD Arte Produções</h5>
                <p>Todos os direitos reservados.</p>
            </div>
        </div>
    </div>
</footer>

    @js( 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js' )
</body>
</html>