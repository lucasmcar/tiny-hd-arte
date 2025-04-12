<div class="contratos-container">
    <h2>{{ htmlspecialchars($title) }}</h2>
    <div class="form-section">
        <h3>Cadastrar Novo Contrato</h3>
        <form id="contractForm" enctype="multipart/form-data">
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
                <label for="valor">Valor do Contrato (R$)</label>
                <input type="number" id="valor" name="valor" class="form-input" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="duracao">Duração do Contrato</label>
                <input type="text" id="duracao" name="duracao" class="form-input" placeholder="Ex.: 12 meses" required>
            </div>
            <div class="form-group">
                <label for="clausulas">Cláusulas do Contrato</label>
                <textarea id="clausulas" name="clausulas" class="form-textarea" required></textarea>
            </div>
            <div class="form-group">
                <label for="assinaturas">Assinaturas Digitais (PDF, PNG, JPG)</label>
                <input type="file" id="assinaturas" name="assinaturas[]" class="form-input" multiple accept=".pdf,image/png,image/jpeg">
            </div>
            <div class="form-actions">
                <button type="submit" class="save-button">Cadastrar Contrato</button>
            </div>
        </form>
        <div id="successMessage" class="success-message" style="display: none;"></div>
    </div>
    <a data-url="/admin/agenciamento-artistas/listaContratos" class="back-button">Ver Lista de Contratos</a>
</div>