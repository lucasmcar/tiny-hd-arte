<section class="container hda-section">
    <h1 class="hda-title">{{ $project['title'] }}</h1>
    <div class="article-meta">
        <p>Por <span class="author">{{ $project['author'] }}</span> | Publicado em <time datetime="{{ $project['post_date'] }}">{{ date('d/m/Y', strtotime($project['post_date'])) }}</time></p>
    </div>

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
                                    <div class="sponsor-item">
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