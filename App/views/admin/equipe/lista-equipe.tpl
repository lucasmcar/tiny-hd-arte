<div class="equipe-container">
    <h2>{{ $title }}</h2>
    <div class="equipe-list">
        {% if empty($equipe) %}
            <p class="no-equipe">Nenhuma pessoa cadastrada.</p>
        {% else %}
            <table class="equipe-table">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Cargo</th>
                        <th>Resumo</th>
                        <th>Destaque</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody id="equipeTableBody">
                    <!-- Dados serão preenchidos via JavaScript -->
                </tbody>
            </table>
        {% endif; %}
        <a href="/admin/equipe/cadastro-pessoa" class="back-button">Voltar para Cadastro</a>
    </div>
</div>

<!-- Modal de Edição -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Editar Pessoa</h2>
            <span class="close-modal">×</span>
        </div>
        <div class="modal-body">
            <form id="editForm" enctype="multipart/form-data">
                @csrf
                <input type="hidden" id="editId" name="id">
                <div class="form-group">
                    <label for="editNome">Nome</label>
                    <input type="text" id="editNome" name="nome" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="editCargo">Cargo</label>
                    <input type="text" id="editCargo" name="cargo" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="editResumo">Resumo</label>
                    <textarea id="editResumo" name="resumo" class="form-textarea" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="editFoto">Foto</label>
                    <input type="file" id="editFoto" name="foto" class="form-input" accept="image/*">
                    <small id="editFotoAtual"></small>
                </div>
                <div class="form-group">
                    <label for="editInstagram">Instagram</label>
                    <input type="url" id="editInstagram" name="redes[instagram]" class="form-input">
                </div>
                <div class="form-group">
                    <label for="editFacebook">Facebook</label>
                    <input type="url" id="editFacebook" name="redes[facebook]" class="form-input">
                </div>
                <div class="form-group">
                    <label for="editLinkedin">LinkedIn</label>
                    <input type="url" id="editLinkedin" name="redes[linkedin]" class="form-input">
                </div>
                <div class="form-group">
                    <label>Destaque</label>
                    <input type="checkbox" id="editDestaque" name="destaque" class="form-checkbox">
                </div>
                <button type="submit" class="save-button">Salvar Alterações</button>
            </form>
        </div>
    </div>
</div>

<!-- Modal de Confirmação de Exclusão -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Confirmar Exclusão</h2>
            <span class="close-modal">×</span>
        </div>
        <div class="modal-body">
            <p>Tem certeza que deseja excluir <span id="deleteNome"></span>?</p>
            <div class="modal-actions">
                <button id="confirmDelete" class="delete-button">Sim, Excluir</button>
                <button id="cancelDelete" class="save-button">Cancelar</button>
            </div>
        </div>
    </div>
</div>