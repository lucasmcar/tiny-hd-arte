<style>
/* Hero Banner */
.hero {
    position: relative;
    background: url('/assets/imgs/logo.png') no-repeat center center/cover;
    height: 80vh;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
}

.hero-overlay {
    position: absolute;
    top: 0; left: 0; width: 100%; height: 100%;
    background: rgba(0, 0, 0, 0.5);
}

.hero-content {
    position: relative;
    z-index: 2;
}

/* Seções */
section {
    padding: 60px 0;
}

/* Navbar fixa */
.navbar {
    background: rgba(0, 0, 0, 0.9);
}

#depoimentos .carousel-item {
    padding: 20px;
    min-height: 250px;
}

#depoimentos img {
    width: 100px;
    height: 100px;
    object-fit: cover;
    border: 3px solid #fff;
}


.social-icons a {
            color: white;
            font-size: 20px;
            margin-left: 15px;
            transition: 0.3s;
        }

        .social-icons a:hover {
            color: #0d6efd; /* Cor azul do Bootstrap */
        }
.card-footer{
    background-color: #222;
}
</style>

<!-- Hero Banner -->
<header class="hero">
    <div class="hero-overlay"></div>
    <div class="hero-content text-center text-white">
        <h1 class="fw-bold">Transformando ideias em grandes produções</h1>
        <p class="lead">Eventos, cultura e arte com qualidade e inovação.</p>
        <a href="#destaques" class="btn btn-primary btn-lg mt-3">Ver Destaques</a>
    </div>
</header>

<!-- Destaques - Carrossel de Eventos -->
<section id="destaques" class="container my-5">
    <h2 class="text-center mb-4">Destaques</h2>
    <div id="carouselDestaques" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="evento1.jpg" class="d-block w-100" alt="Evento 1">
            </div>
            <div class="carousel-item">
                <img src="evento2.jpg" class="d-block w-100" alt="Evento 2">
            </div>
            <div class="carousel-item">
                <img src="evento3.jpg" class="d-block w-100" alt="Evento 3">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselDestaques" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselDestaques" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
</section>

<!-- Seções -->
<!-- Seção Quem Somos -->
<section class="section bg-light">
    <div class="container">
        <h2>Quem Somos</h2>
        <p>Somos uma equipe especializada em produção cultural e eventos, oferecendo soluções criativas e estratégicas.</p>
        <a href="/sobre" class="btn btn-primary btn-custom">Saiba Mais</a>
    </div>
</section>

<!-- Seção Serviços -->
<section class="section">
    <div class="container">
        <h2>Nossos Serviços</h2>
        <p>Oferecemos consultoria, planejamento, produção executiva e muito mais para o seu evento.</p>
        <a href="/servicos" class="btn btn-primary btn-custom">Ver Serviços</a>
    </div>
</section>

<!-- Seção Equipe -->
<section class="section bg-light">
    <div class="container">
        <h2>Conheça Nossa Equipe</h2>
        <p>Profissionais qualificados para garantir o sucesso do seu projeto.</p>
        <a href="/equipe" class="btn btn-primary btn-custom">Ver Equipe</a>
    </div>
</section>

<section id="depoimentos" class="py-5 bg-dark text-white">
    <div class="container">
        <h2 class="text-center mb-4">O que nossos clientes dizem</h2>
        
        <div id="carouselDepoimentos" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">

                <!-- Depoimento 1 -->
                <div class="carousel-item active">
                    <div class="d-flex flex-column align-items-center text-center">
                        <img src="https://source.unsplash.com/150x150/?person" class="rounded-circle mb-3" alt="Cliente 1">
                        <p class="lead">"A equipe foi extremamente profissional e eficiente. Recomendo muito!"</p>
                        <h5 class="mt-2">Lucas Carvalho</h5>
                        <small>Consultor de Marketing</small>
                    </div>
                </div>

                <!-- Depoimento 2 -->
                <div class="carousel-item">
                    <div class="d-flex flex-column align-items-center text-center">
                        <img src="https://source.unsplash.com/150x150/?woman" class="rounded-circle mb-3" alt="Cliente 2">
                        <p class="lead">"Trabalho impecável! Meu projeto ganhou vida com essa equipe incrível."</p>
                        <h5 class="mt-2">Carla Castro</h5>
                        <small>Assessora de Imprensa</small>
                    </div>
                </div>

                <!-- Depoimento 3 -->
                <div class="carousel-item">
                    <div class="d-flex flex-column align-items-center text-center">
                        <img src="https://source.unsplash.com/150x150/?man" class="rounded-circle mb-3" alt="Cliente 3">
                        <p class="lead">"Profissionais comprometidos e altamente qualificados. Superaram minhas expectativas!"</p>
                        <h5 class="mt-2">Eduardo Raupp</h5>
                        <small>Especialista em Projetos</small>
                    </div>
                </div>

            </div>

            <!-- Controles do carrossel -->
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselDepoimentos" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselDepoimentos" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>

        </div>
        <div class="text-center mt-4">
            <a href="/depoimentos/todos" class="btn btn-primary btn-lg">Ver todos os depoimentos</a>
        </div>
    </div>
</section>

<!-- Seção Consultoria -->
<section class="section">
    <div class="container text-center">
        <h2 class="mb-4">Consultoria e Impulsionamento</h2>
        <p class="lead">
            Oferecemos consultoria especializada para otimizar sua presença digital, aumentar o engajamento 
            e impulsionar suas redes sociais. Nossa abordagem inclui análise de mercado, estratégias de conteúdo 
            e campanhas direcionadas para o crescimento da sua marca.
        </p>

        <div class="row justify-content-center mt-4">
            <!-- Lucas Carvalho -->
            <div class="col-md-5 mb-4">
                <div class="card h-100">
                    <img src="imagens/lucas.jpg" class="card-img-top" alt="Lucas Carvalho">
                    <div class="card-body">
                        <h5 class="card-title">Lucas Carvalho</h5>
                        <p class="card-text">
                            Especialista em consultoria digital e impulsionamento de negócios online. 
                            Atua na criação de estratégias para aumentar a visibilidade e conversão das marcas.
                        </p>
                    </div>
                    <div class="card-footer text-center ">
                        <div class="social-icons">
                            <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                            <a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Thais Krug -->
            <div class="col-md-5 mb-4">
                <div class="card h-100">
                    <img src="imagens/thais.jpg" class="card-img-top" alt="Thais Krug">
                    <div class="card-body">
                        <h5 class="card-title">Thais Krug</h5>
                        <p class="card-text">
                            Especialista em gestão de mídias sociais, ajudando marcas a criar conteúdos 
                            envolventes e estratégias eficazes para engajamento e crescimento no Instagram e outras redes.
                        </p>
                    </div>
                    <div class="card-footer text-center">
                        <div class="social-icons">
                            <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                            <a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <a href="/contato" class="btn btn-primary mt-4">Entre em contato</a>
    </div>
</section>

<!-- Seção Contato -->
<section class="section bg-light">
    <div class="container">
        <h2>Entre em Contato</h2>
        <p>Tem um projeto? Fale conosco e descubra como podemos ajudar.</p>
        <a href="/contato" class="btn btn-primary btn-custom">Fale Conosco</a>
    </div>
</section>