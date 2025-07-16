<section class="container hda-section">
    <h1 class="hda-title">{{ $project['title'] }}</h1>
    <div class="article-meta">
        <p>Por <span class="author">{{ $project['author'] }}</span> | Publicado em <time datetime="{{ $project['post_date'] }}">{{ date('d/m/Y', strtotime($project['post_date'])) }}</time></p>
    </div>

    <!-- Seção de Descrição do Projeto, Imagem Adicional e Patrocinadores -->
    <div class="row">
        <div class="col-md-8">
            <img src="{{ $project['image'] }}" alt="{{ htmlspecialchars($project['title']) }}" class="img-fluid img-destaque rounded mb-4">
            <p class="hda-text">{{ htmlspecialchars($project['description']) }}</p>
            <p class="hda-text">{{ htmlspecialchars($project['details']) }}</p>
            <div class="article-content">
                <p>{{ nl2br($project['content']) }}</p>
            </div>
        </div>
        <div class="col-md-4">
            <img src="{{ $project['extra_image'] }}" alt="Imagem adicional de {{ htmlspecialchars($project['title']) }}" class="img-fluid extra-image rounded mb-4">
            <a href="/" class="btn btn-hda">Voltar à Home</a>

            <!-- Área de Patrocinadores com Carrossel -->
            <div class="sponsors-section mt-4">
                <h3 class="sponsors-title">Patrocinadores</h3>
                {% if !empty($project['sponsors']) %}
                    <div id="sponsorsCarousel" class="carousel slide" data-bs-ride="carousel">
                        <!-- Indicadores (bolinhas) -->
                        <div class="carousel-indicators">
                            {% foreach $project['sponsors'] as $index => $sponsor %}
                                <button type="button" data-bs-target="#sponsorsCarousel" data-bs-slide-to="{{ $index }}" class="{{ $index == 0 ? 'active' : '' }}" aria-label="Slide {{ $index + 1 }}"></button>
                            {% endforeach; %}
                        </div>

                        <!-- Itens do Carrossel -->
                        <div class="carousel-inner">
                            {% foreach $project['sponsors'] as $index => $sponsor %}
                                <div class="carousel-item {{ $index == 0 ? 'active' : '' }}">
                                    <div class="sponsor-item text-center">
                                        <img src="{{ $sponsor['logo'] }}" alt="{{ $sponsor['name'] }}" class="sponsor-logo img-fluid rounded">
                                        <p class="sponsor-name">{{ $sponsor['name'] }}</p>
                                    </div>
                                </div>
                            {% endforeach; %}
                        </div>

                        <!-- Controles (setas) -->
                        <button class="carousel-control-prev" type="button" data-bs-target="#sponsorsCarousel" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Anterior</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#sponsorsCarousel" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Próximo</span>
                        </button>
                    </div>
                {% else %}
                    <p class="hda-text">Nenhum patrocinador disponível para este projeto.</p>
                {% endif; %}
            </div>
        </div>
    </div>
</section>

<!-- Seção de Atrações Confirmadas (seção inteira) -->
{% if !empty($project['attractions']) %}
    <section class="container attractions-section py-5">
        <h3 class="sponsors-title text-center mb-4">Grafiteiros(as) confirmados(as)</h3>

        <!-- Div para a Imagem em Destaque -->
        <div class="highlight-image-container text-center">
            <img id="highlight-image" src="{{ $project['attractions'][0]['image'] }}" alt="Atração em Destaque" class="highlight-img img-fluid">
        </div>
        <div class="text-center">
            <button id="highlight-button" class="btn btn-hda mt-3" data-bs-toggle="modal" data-bs-target="#attractionModal">Saiba Mais</button>
        </div>

        <!-- Carrossel de Atrações -->
        <div id="attractionsCarousel" class="carousel slide attractions-carousel mt-4" data-bs-ride="carousel">
            <div class="carousel-inner">
                {% foreach $project['attractions'] as $index => $attraction %}
                    <div class="carousel-item {{ $index === 0 ? 'active' : '' }}" data-title="{{ htmlspecialchars($attraction['title']) }}" data-description="{{ htmlspecialchars($attraction['description']) }}">
                        <img src="{{ $attraction['image'] }}" class="d-block attraction-img img-fluid mx-auto" alt="{{ htmlspecialchars($attraction['title']) }}">
                    </div>
                {% endforeach; %}
            </div>
            <!-- Controles do Carrossel -->
            <button class="carousel-control-prev" type="button" data-bs-target="#attractionsCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Anterior</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#attractionsCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Próximo</span>
            </button>
        </div>

        <!-- Modal de Informações -->
        <div class="modal fade" id="attractionModal" tabindex="-1" aria-labelledby="attractionModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalAttractionTitle">{{ htmlspecialchars($project['attractions'][0]['title']) }}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p id="modalAttractionDescription">{{ htmlspecialchars($project['attractions'][0]['description']) }}</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
{% endif; %}

<!-- Seção de Shows (em formato grid) -->
{% if !empty($project['shows']) %}
    <section class="container shows-section py-5">
        <h3 class="section-title text-center mb-4">Shows</h3>
        <div class="project-grid">
            {% foreach $project['shows'] as $index => $show %}
                <div class="project-card">
                    {% if isset($show['video']) %}
                        <video class="project-media img-fluid" muted loop playsinline>
                            <source src="{{ $show['video'] }}" type="video/mp4">
                            Seu navegador não suporta vídeo.
                        </video>
                    {% else %}
                        <img src="{{ $show['image'] }}" alt="{{ htmlspecialchars($show['title']) }}" class="project-media img-fluid">
                    {% endif; %}
                    <div class="card-body">
                        {% if isset($show['participants']) %}
                            <p class="show-participants">{{ htmlspecialchars($show['participants']) }}</p>
                        {% endif; %}
                        <h5 class="card-title">{{ htmlspecialchars($show['title']) }}</h5>
                        <p class="card-text">{{ htmlspecialchars($show['description']) }}</p>
                       
                    </div>
                </div>
            {% endforeach; %}
        </div>
    </section>
{% endif; %}
