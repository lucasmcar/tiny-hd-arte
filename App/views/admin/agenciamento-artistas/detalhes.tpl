<div class="artistas-container">
    <h2>{{ htmlspecialchars($title) }}</h2>
    <div class="artist-details">
        <!-- Dados do Artista -->
        <div class="details-section">
            <h3>Dados do Artista</h3>
            <p><strong>Nome:</strong> {{ htmlspecialchars($artista['nome']) }}</p>
            <p><strong>Gênero Artístico:</strong> {{ htmlspecialchars($artista['genero']) }}</p>
            <p><strong>Cachê (R$):</strong> {{ number_format($artista['cache'], 2, ',', '.') }}</p>
            <p><strong>Histórico de Apresentações:</strong> {{ nl2br(htmlspecialchars($artista['historico'])) }}</p>
        </div>

        <!-- Portfólio -->
        <div class="details-section">
            <h3>Portfólio</h3>
            <h4>Fotos</h4>
            {% if empty($artista['portfolio']['fotos']) %}
                <p>Nenhuma foto no portfólio.</p>
            {% else %}
                <div class="portfolio-gallery">
                    {% foreach $artista['portfolio']['fotos'] as $index => $foto %}
                        <img src="/{{ htmlspecialchars($foto) }}" alt="Foto do Portfólio" class="portfolio-media img-fluid rounded mb-3">
                    {% endforeach; %}
                </div>
            {% endif; %}

            <h4>Vídeos</h4>
            {% if empty($artista['portfolio']['videos']) %}
                <p>Nenhum vídeo no portfólio.</p>
            {% else %}
                <div class="portfolio-gallery">
                    {% foreach $artista['portfolio']['videos'] as $index => %video %}
                        <video class="portfolio-media img-fluid rounded mb-3" controls>
                            <source src="/{{ htmlspecialchars($video) }}" type="video/mp4">
                            Seu navegador não suporta vídeo.
                        </video>
                    {% endforeach; %}
                </div>
            {% endif; %}

            <h4>Textos</h4>
            <p>{{ nl2br(htmlspecialchars($artista['portfolio']['textos'] ?: 'Nenhum texto disponível.')) }}</p>
        </div>

        <a data-url="/admin/agenciamento-artistas/listaArtistas" class="back-button">Voltar para Lista</a>
    </div>
</div>