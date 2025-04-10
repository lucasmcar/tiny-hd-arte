<div class="eventos-container">
    <h2>{{ $title }}</h2>
    <div class="form-section">
        <h3>Criar Novo Evento Cultural</h3>
        <form id="eventForm" enctype="multipart/form-data">
            <div class="form-group">
                <label for="nome">Nome do Evento</label>
                <input type="text" id="nome" name="nome" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="data">Data do Evento</label>
                <input type="date" id="data" name="data" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="local">Local</label>
                <input type="text" id="local" name="local" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="descricao">Descrição</label>
                <textarea id="descricao" name="descricao" class="form-textarea" required></textarea>
            </div>
            <div class="form-group">
                <label for="artistas">Artistas Envolvidos</label>
                <input type="text" id="artistas" name="artistas" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="orcamento">Orçamento Estimado (R$)</label>
                <input type="number" id="orcamento" name="orcamento" class="form-input" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="editais">Upload de Editais (PDF)</label>
                <input type="file" id="editais" name="editais[]" class="form-input" multiple accept=".pdf">
            </div>
            <div class="form-actions">
                <button type="submit" class="save-button">Salvar Evento</button>
            </div>
        </form>
        <div id="successMessage" class="success-message" style="display: none;"></div>
    </div>
    <a data-url="/admin/eventos-culturais/listaEventos" class="back-button">Ver Lista de Eventos</a>
</div>