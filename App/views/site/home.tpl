

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
                <img src="/assets/imgs/cur.jpg" class="d-block w-100" alt="Evento 1">
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
                {% foreach $depoimentos as $index => $item %}
                    <div class="carousel-item {{ $index == 0 ? 'active' : ''}}">

                        <div class="d-flex flex-column align-items-center text-center">
                        
                            <img src="{{ $item['foto'] }}" alt="{{ $item['nome'] }}" class="rounded-circle mb-3">
                            <p class="text">"{{ $item['depoimento'] }}"</p>
                            <h5 class="author fw-bold">{{ $item['nome'] }} </h5> 
                            <small> {{ $item['profissao'] }}</small>
                        

                        </div>
                    </div>
                {% endforeach; %}

                

                
                

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