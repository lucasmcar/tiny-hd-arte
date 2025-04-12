<div class="agenda-container">
    <h2>{{ htmlspecialchars($title) }}</h2>
    <div class="event-details">
        <div class="details-section">
            <h3>Dados do Evento</h3>
            <p><strong>Artista:</strong> {{ htmlspecialchars($artista['nome']) }}</p>
            <p><strong>Título:</strong> {{ htmlspecialchars($evento['titulo']) }}</p>
            <p><strong>Data:</strong> {{ htmlspecialchars($evento['data']) }}</p>
            <p><strong>Local:</strong> {{ htmlspecialchars($evento['local']) }}</p>
            <p><strong>Detalhes:</strong> {{ nl2br(htmlspecialchars($evento['detalhes'] ?: 'Nenhum detalhe disponível.')) }}</p>
        </div>

        <a data-url="/admin/agenciamento-artistas/listaAgenda" class="back-button">Voltar para Agenda</a>
    </div>
</div>