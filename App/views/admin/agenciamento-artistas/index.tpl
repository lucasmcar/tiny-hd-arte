<div class="artistas-container">
    <h2>{{ htmlspecialchars($title) }}</h2>
    <div class="form-section">
        <h3>Cadastrar Novo Artista ou Grupo</h3>
        <form id="artistForm" enctype="multipart/form-data">
            <div class="form-group">
                <label for="nome">Nome do Artista/Grupo</label>
                <input type="text" id="nome" name="nome" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="genero">Gênero Artístico</label>
                <input type="text" id="genero" name="genero" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="fotos">Fotos do Portfólio (JPG, PNG)</label>
                <input type="file" id="fotos" name="fotos[]" class="form-input" multiple accept="image/jpeg,image/png">
            </div>
            <div class="form-group">
                <label for="videos">Vídeos do Portfólio (MP4)</label>
                <input type="file" id="videos" name="videos[]" class="form-input" multiple accept="video/mp4">
            </div>
            <div class="form-group">
                <label for="textos">Textos do Portfólio (Biografia, etc.)</label>
                <textarea id="textos" name="textos" class="form-textarea"></textarea>
            </div>
            <div class="form-group">
                <label for="historico">Histórico de Apresentações</label>
                <textarea id="historico" name="historico" class="form-textarea" required></textarea>
            </div>
            <div class="form-group">
                <label for="cache">Cachê (R$)</label>
                <input type="number" id="cache" name="cache" class="form-input" step="0.01" required>
            </div>
            <div class="form-actions">
                <button type="submit" class="save-button">Cadastrar Artista</button>
            </div>
        </form>
        <div id="successMessage" class="success-message" style="display: none;"></div>
    </div>
    <a data-url="/admin/agenciamento-artistas/listaArtistas" class="back-button">Ver Lista de Artistas</a>
</div>