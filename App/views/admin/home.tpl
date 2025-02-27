<style>
        body {
            background-color: #141414;
            color: #fff;
            overflow-x: hidden;
        }

        .rounded-circle {
            width: 64px;
            height: 64px;
        }
        .sidebar {
            height: 100vh;
            width: 70px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #000;
            transition: width 0.3s;
        }
        .sidebar:hover {
            width: 250px;
        }
        .sidebar ul {
            padding: 0;
            list-style: none;
        }
        .sidebar ul li {
            padding: 15px;
            text-align: center;
        }
        .sidebar ul li a {
            color: #fff;
            text-decoration: none;
            display: block;
        }
        .sidebar ul li a:hover {
            color: #e50914;
        }
        .sidebar ul li i {
            font-size: 1.5rem;
            transition: transform 0.3s;
        }
        .sidebar:hover ul li i {
            transform: rotate(-360deg);
        }
        .sidebar ul li span {
            display: none;
        }
        .sidebar:hover ul li span {
            display: inline-block;
            margin-left: 10px;
        }
        .top-navbar {
            height: 60px;
            background-color: #141414;
            width: calc(100% - 70px);
            position: fixed;
            top: 0;
            left: 70px;
            z-index: 10;
            transition: left 0.3s;
        }
        .sidebar:hover ~ .top-navbar {
            left: 250px;
            width: calc(100% - 250px);
        }
        .top-navbar .profile {
            float: right;
            margin-right: 20px;
        }
        .content {
            margin-left: 70px;
            padding: 80px 20px;
            transition: margin-left 0.3s;
        }
        .sidebar:hover ~ .content {
            margin-left: 250px;
        }
        .carousel-container {
            overflow-x: auto;
            white-space: nowrap;
        }
        .carousel-item {
            display: inline-block;
            width: 250px;
            margin-right: 15px;
            background-color: #222;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s;
        }
        .carousel-item:hover {
            transform: scale(1.05);
        }
        .carousel-item img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        .carousel-item h5 {
            padding: 10px;
        }
    </style>

     <div class="sidebar">
        <ul>
            <li>
                <a href="#">
                    <i class="bi bi-house-door"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="bi bi-file-earmark-text"></i>
                    <span>Blog</span>
                </a>
            </li>
            <li>
                <a href="#"  class="nav-link" data-page="todos/depoimentos">
                    <i class="bi bi-chat-dots"></i>
                    <span>Depoimentos</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="bi bi-gear"></i>
                    <span>Configurações</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="bi bi-people"></i>
                    <span>Parceiros</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-link" data-page="todos/servicos">
                    <i class="bi bi-briefcase"></i>
                    <span>Serviços</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- Top Navbar -->
    <div class="top-navbar">
        <h4 class="text-white p-3">Painel Administrativo</h4>
        <div class="profile">
            <img src="/assets/imgs/michelle.jpg" alt="Perfil" class="rounded-circle">
        </div>
    </div>

    <!-- Main Content -->
    <div class="content" id="main-content">
        <h2>Blog</h2>
        <div class="carousel-container">
            <div class="carousel-item">
                <img src="https://via.placeholder.com/250x150" alt="Imagem">
                <h5>Post 1</h5>
            </div>
            <div class="carousel-item">
                <img src="https://via.placeholder.com/250x150" alt="Imagem">
                <h5>Post 2</h5>
            </div>
            <div class="carousel-item">
                <img src="https://via.placeholder.com/250x150" alt="Imagem">
                <h5>Post 3</h5>
            </div>
            <div class="carousel-item">
                <img src="https://via.placeholder.com/250x150" alt="Imagem">
                <h5>Post 4</h5>
            </div>
        </div>
        
        <div id="conteudo-dinamico"></div>

 