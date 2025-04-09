<div class="projetos-container">
    <h2>{{ $title }}</h2>
    <div class="form-section">
        <h3>Criar Novo Projeto Cultural</h3>
        <form id="projectForm">
            @csrf
            <div class="form-group">
                <label for="nome">Nome do Projeto</label>
                <input type="text" id="nome" name="nome" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="descricao">Descrição</label>
                <textarea id="descricao" name="descricao" class="form-textarea" required></textarea>
            </div>
            <div class="form-group">
                <label for="objetivos">Objetivos</label>
                <textarea id="objetivos" name="objetivos" class="form-textarea" required></textarea>
            </div>
            <div class="form-group">
                <label for="publico_alvo">Público-Alvo</label>
                <input type="text" id="publico_alvo" name="publico_alvo" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="orcamento_estimado">Orçamento Estimado (R$)</label>
                <input type="number" id="orcamento_estimado" name="orcamento_estimado" class="form-input" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="cronograma">Cronograma</label>
                <textarea id="cronograma" name="cronograma" class="form-textarea" required></textarea>
            </div>
            <div class="form-actions">
                <button type="submit" class="save-button">Salvar Projeto</button>
            </div>
        </form>
        <div id="successMessage" class="success-message" style="display: none;"></div>
    </div>
    <a data-url="/admin/projetos-culturais/listaProjetos" class="back-button">Ver Lista de Projetos</a>
</div>