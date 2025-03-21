<div class="services-wrapper">
    <h2>{{ $title }}</h2>
    <button class="btn-add-service" onclick="document.getElementById('addServiceModal').classList.add('show')">Adicionar Serviço</button>

    <div class="services-table">
        <div class="table-header">
            <div class="table-cell">Ícone</div>
            <div class="table-cell">Título</div>
            <div class="table-cell">Descrição</div>
            <div class="table-cell">Ações</div>
        </div>
        <div class="table-body">
            {% foreach $servicos as $index => $item %}
                <div class="table-row" data-service-id="{{ $item['id'] || $index }}">
                    <div class="table-cell"><i class="bi {{ $item['icone'] }}"></i></div>
                    <div class="table-cell">{{ $item['titulo'] }}</div>
                    <div class="table-cell">{{ $item['descricao'] }}</div>
                    <div class="table-cell">
                        <button class="btn-edit" onclick="document.getElementById('editServiceModal').classList.add('show')" data-service-id="{{ $item['id'] || $index }}">Editar</button>
                        <button class="btn-delete" data-service-id="{{ $item['id'] || $index }}">Excluir</button>
                    </div>
                </div>
            {% endforeach; %}
        </div>
    </div>

    <!-- Modal para Adicionar Serviço -->
    <div class="modal" id="addServiceModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Adicionar Novo Serviço</h3>
                <button class="modal-close" onclick="document.getElementById('addServiceModal').classList.remove('show')">×</button>
            </div>
            <div class="modal-body">
                <form id="addServiceForm">
                    <div class="form-group">
                        <label for="addIcon">Ícone (classe Bootstrap Icons)</label>
                        <input type="text" id="addIcon" name="icone" required>
                    </div>
                    <div class="form-group">
                        <label for="addTitle">Título</label>
                        <input type="text" id="addTitle" name="titulo" required>
                    </div>
                    <div class="form-group">
                        <label for="addDescription">Descrição</label>
                        <textarea id="addDescription" name="descricao" rows="3" required></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn-cancel" onclick="document.getElementById('addServiceModal').classList.remove('show')">Cancelar</button>
                <button class="btn-save" id="saveNewService">Salvar</button>
            </div>
        </div>
    </div>

    <!-- Modal para Editar Serviço -->
    <div class="modal" id="editServiceModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Editar Serviço</h3>
                <button class="modal-close" onclick="document.getElementById('editServiceModal').classList.remove('show')">×</button>
            </div>
            <div class="modal-body">
                <form id="editServiceForm">
                    <input type="hidden" id="editServiceId" name="id">
                    <div class="form-group">
                        <label for="editIcon">Ícone (classe Bootstrap Icons)</label>
                        <input type="text" id="editIcon" name="icone" required>
                    </div>
                    <div class="form-group">
                        <label for="editTitle">Título</label>
                        <input type="text" id="editTitle" name="titulo" required>
                    </div>
                    <div class="form-group">
                        <label for="editDescription">Descrição</label>
                        <textarea id="editDescription" name="descricao" rows="3" required></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn-cancel" onclick="document.getElementById('editServiceModal').classList.remove('show')">Cancelar</button>
                <button class="btn-save" id="saveEditService">Salvar</button>
            </div>
        </div>
    </div>
</div>