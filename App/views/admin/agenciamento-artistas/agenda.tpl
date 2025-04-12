<div class="agenda-container">
    <h2>{{ htmlspecialchars($title) }}</h2>
    <div class="form-section">
        <h3>Adicionar Evento à Agenda</h3>
        <form id="eventForm">
            <div class="form-group">
                <label for="artist_id">Artista/Grupo</label>
                <select id="artist_id" name="artist_id" class="form-input" required>
                    <option value="">Selecione um artista</option>
                    {% foreach $artists as $index => $artista %}
                        <option value="{{ $artista['id'] }}">{{ htmlspecialchars($artista['nome']) }}</option>
                    {% endforeach; %}
                </select>
            </div>
            <div class="form-group">
                <label for="titulo">Título do Evento</label>
                <input type="text" id="titulo" name="titulo" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="data">Data do Evento</label>
                <input type="date" id="data" name="data" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="local">Local do Evento</label>
                <input type="text" id="local" name="local" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="detalhes">Detalhes do Evento</label>
                <textarea id="detalhes" name="detalhes" class="form-textarea"></textarea>
            </div>
            <div class="form-actions">
                <button type="submit" class="save-button">Adicionar Evento</button>
            </div>
        </form>
        <div id="successMessage" class="success-message" style="display: none;"></div>
    </div>
    <a data-url="/admin/agenciamento-artistas/listaAgenda" class="back-button">Ver Agenda</a>
</div>