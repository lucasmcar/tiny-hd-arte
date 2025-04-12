<div class="historico-container">
    <h2>{{ htmlspecialchars($title) }}</h2>
    <div class="historico-details">
        <div class="details-section">
            <h3>Dados do Evento</h3>
            <p><strong>Artista:</strong> {{ htmlspecialchars($artista['nome']) }}</p>
            <p><strong>Título:</strong> {{ htmlspecialchars($evento['titulo']) }}</p>
            <p><strong>Data:</strong> {{ htmlspecialchars($evento['data']) }}</p>
            <p><strong>Local:</strong> {{ htmlspecialchars($evento['local']) }}</p>
            <p><strong>Público Presente:</strong> {{ htmlspecialchars($evento['publico']) }}</p>
            <p><strong>Feedback:</strong> {{ nl2br(htmlspecialchars($evento['feedback'])) }}</p>
        </div>

        <a data-url="/admin/agenciamento-artistas/listaHistorico" class="back-button">Voltar para Histórico</a>
    </div>
</div>