<div class="historico-container">
    <h2>{{htmlspecialchars($title) }}</h2>
    <div class="form-section">
        <h3>Adicionar Avaliação a Evento Realizado</h3>
        <form id="evaluationForm">
            <div class="form-group">
                <label for="event_id">Evento</label>
                <select id="event_id" name="event_id" class="form-input" required>
                    <option value="">Selecione um evento</option>
                    {% foreach $agenda as $index => $evento %}
                        <option value="{{ $evento['id'] }}">{{ htmlspecialchars($evento['titulo']) }} ({{ htmlspecialchars($evento['data']) }})</option>
                    {% endforeach; %}
                </select>
            </div>
            <div class="form-group">
                <label for="publico">Público Presente</label>
                <input type="number" id="publico" name="publico" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="feedback">Feedback do Evento</label>
                <textarea id="feedback" name="feedback" class="form-textarea" required></textarea>
            </div>
            <div class="form-actions">
                <button type="submit" class="save-button">Salvar Avaliação</button>
            </div>
        </form>
        <div id="successMessage" class="success-message" style="display: none;"></div>
    </div>
    <a data-url="/admin/agenciamento-artistas/listaHistorico" class="back-button">Ver Histórico</a>
</div>