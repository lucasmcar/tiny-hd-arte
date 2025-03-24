<!-- Hero Banner -->
<header class="hero hda-hero">
    <div class="hero-overlay"></div>
    <div class="hero-content text-center text-white">
        <h1 class="fw-bold display-1">Transformando ideias em grandes produções</h1>
        <p class="lead mb-4">Eventos, cultura e arte com qualidade e inovação.</p>
        <a href="#destaques" class="btn btn-hda btn-lg">Ver Destaques</a>
    </div>
</header>

<!-- Seção Destaques -->
<section id="destaques" class="hda-section">
    <div class="container-fluid">
        <h2 class="hda-title text-center mb-4">Destaques</h2>
        <div id="carouselDestaques" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="carousel-card">
                        <img src="/assets/imgs/cur.jpg" alt="Evento 1">
                        <div class="card-overlay">
                            <p>Circuito Urbano Restinga</p>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="carousel-card">
                        <img src="evento2.jpg" alt="Evento 2">
                        <div class="card-overlay">
                            <p>Evento Cultural 2</p>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="carousel-card">
                        <img src="evento3.jpg" alt="Evento 3">
                        <div class="card-overlay">
                            <p>Evento Cultural 3</p>
                        </div>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselDestaques" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselDestaques" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
</section>

<!-- Seção Quem Somos -->
<section class="hda-section bg-light">
    <div class="container">
        <h2 class="hda-title">Quem Somos</h2>
        <div class="hda-carousel">
            <div class="hda-card">
                <i class="bi bi-people card-icon"></i>
                <p>Somos uma equipe especializada em produção cultural e eventos, oferecendo soluções criativas e estratégicas.</p>
                <a href="/sobre" class="btn btn-hda">Saiba Mais</a>
            </div>
        </div>
    </div>
</section>

<!-- Seção Serviços -->
<section class="hda-section">
    <div class="container">
        <h2 class="hda-title">Nossos Serviços</h2>
        <p>Oferecemos consultoria, planejamento, produção executiva e muito mais para o seu evento.</p>
        <a href="/servicos" class="btn btn-hda">Ver Serviços</a>
    </div>
</section>

<!-- Seção Equipe -->
<section class="hda-section bg-light">
    <div class="container">
        <h2 class="hda-title">Conheça Nossa Equipe</h2>
        <div class="hda-carousel">
            <div class="hda-card">
                <i class="bi bi-person-lines-fill card-icon"></i>
                <p>Profissionais qualificados para garantir o sucesso do seu projeto.</p>
                <a href="/equipe" class="btn btn-hda">Ver Equipe</a>
            </div>
        </div>
    </div>
</section>
<!-- Seção Depoimentos -->
<!-- Seção Depoimentos -->
<section id="depoimentos" class="hda-section bg-dark text-white">
    <div class="container">
        <h2 class="hda-title text-center mb-4">O que nossos clientes dizem</h2>
        <div id="carouselDepoimentos" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                {% foreach $depoimentos as $index => $item %}
                    <div class="carousel-item {{ $index == 0 ? 'active' : '' }}">
                        <div class="depoimentos-card">
                            <img src="{{ $item['foto'] }}" alt="{{ $item['nome'] }}">
                            <div class="depoimentos-overlay text-center">
                                <p>"{{ $item['depoimento'] }}"</p>
                                <h5>{{ $item['nome'] }}</h5>
                                <small>{{ $item['profissao'] }}</small>
                            </div>
                        </div>
                    </div>
                {% endforeach; %}
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselDepoimentos" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselDepoimentos" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        <div class="text-center mt-4">
            <a href="/depoimentos/todos" class="btn btn-hda btn-lg">Ver todos os depoimentos</a>
        </div>
    </div>
</section>

<!-- Seção Consultoria -->
<section class="hda-section">
    <div class="container text-center">
        <h2 class="hda-title mb-4">Consultoria e Impulsionamento</h2>
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
                    <div class="card-footer text-center">
                        <div class="social-icons">
                            <a href="https://instagram.com/hej.lucasmcar" target="_blank"><i class="fab fa-instagram"></i></a>
                            <a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a>
                            <a href="https://linkedin.com/in/lucas-m-carvalho" target="_blank"><i class="fab fa-linkedin-in"></i></a>
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
        <a href="/contato" class="btn btn-hda mt-4">Entre em contato</a>
    </div>
</section>

<!-- Seção Artigos Recentes -->
<section id="artigos" class="hda-section bg-dark text-white">
    <div class="container">
        <h2 class="hda-title text-center mb-4">Artigos Recentes</h2>
        <div id="carouselArtigos" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                {% foreach $artigos as $index => $item %}
                    <div class="carousel-item {{ $index == 0 ? 'active' : '' }}">
                        <a href="/artigo/{{ $item['created_at'] }}/{{ $item['slug'] }}" class="article-card">
                            <div class="article-overlay">
                                <h5>{{ $item['title'] }}</h5>
                                <small>{{ $item['created_at'] }}</small>
                            </div>
                        </a>
                    </div>
                {% endforeach; %}
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselArtigos" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselArtigos" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        <div class="text-center mt-4">
            <a href="/artigos/todos" class="btn btn-hda btn-lg">Ver Todos os Artigos</a>
        </div>
    </div>
</section>

<!-- Seção Contato -->
<section class="hda-section bg-light">
    <div class="container">
        <h2 class="hda-title">Entre em Contato</h2>
        <div class="hda-carousel">
            <div class="hda-card">
                <i class="bi bi-envelope-fill card-icon"></i>
                <p>Tem um projeto? Fale conosco e descubra como podemos ajudar.</p>
                <a href="/contato" class="btn btn-hda">Fale Conosco</a>
            </div>
        </div>
    </div>
</section>