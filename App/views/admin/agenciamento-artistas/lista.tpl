<div class="artistas-container">
    <h2>{{ htmlspecialchars($title) }}</h2>
    <div class="artists-list">
        {% if empty($artists) %}
            <p class="hda-text">Nenhum artista cadastrado no momento.</p>
        {% else %}
            <div class="project-grid">
                {% foreach $artists as $index => $artista %}
                    <div class="project-card">
                        {% if !empty($artista['portfolio']['fotos']) %}
                            <img src="/{{ htmlspecialchars($artista['portfolio']['fotos'][0]) }}" alt="{{ htmlspecialchars($artista['nome']) }}" class="project-media">
                        {% else %}
                            <div class="project-media placeholder-image">Sem Foto</div>
                        {% endif; %}
                        <div class="card-body">
                            <h5 class="card-title">{{ htmlspecialchars($artista['nome']) }}</h5>
                            <p class="card-text">Gênero: {{ htmlspecialchars($artista['genero']) }}</p>
                            <p class="card-text">Cachê: R$ {{ number_format($artista['cache'], 2, ',', '.') }}</p>
                            <a data-url="/admin/agenciamento-artistas/detalhesArtista?id={{ $artista['id'] }}" class="btn btn-hda">Ver Detalhes</a>
                        </div>
                    </div>
                {% endforeach; %}
            </div>
        {% endif; %}
    </div>
    <a data-url="/admin/agenciamento-artistas" class="back-button">Voltar para Cadastro</a>
</div>