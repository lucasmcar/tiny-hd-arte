<section class="gerenciar-parceiros-section">
    <div class="container">
        <div class="header-info">
            <h2 class="hda-title">Gerenciar Parceiros</h2>
            <button class="action-btn add-btn" id="addPartnerBtn">Adicionar Parceiro</button>
        </div>

        {% if $parceiros %}
            <div class="parceiros-table">
                <div class="table-header">
                    <div class="table-cell">Nome</div>
                    <div class="table-cell">Tipo</div>
                    <div class="table-cell">E-mail</div>
                    <div class="table-cell">Telefone</div>
                    <div class="table-cell">Ações</div>
                </div>
                {% foreach $parceiros as $index => $item %}
                    <div class="table-row">
                        <div class="table-cell">{{ $item['nome'] }}</div>
                        <div class="table-cell">{{ $item['tipo'] }}</div>
                        <div class="table-cell">{{ $item['email'] }}</div>
                        <div class="table-cell">{{ $item['telefone'] }}</div>
                        <div class="table-cell">
                            <button class="action-btn edit-btn" data-id="{{ $item['id'] }}"><i class="bi bi-pen"></i></button>
                            <button class="action-btn delete-btn" data-id="{{ $item['id'] }}"><i class="bi bi-trash"></i></button>
                        </div>
                    </div>
                {% endforeach; %}
            </div>

            {% if $totalParceiros > 1 %}
                <div class="pagination-netflix">
                    {% if $paginaAtual > 1 %}
                        <a href="/admin/parceiros/todos?pagina={{ $paginaAtual - 1 }}" class="pagination-btn">Anterior</a>
                    {% endif; %}
                    @for( 1, $totalPaginas, $i ) 
                        <a href="/admin/parceiros/todos?pagina={{ $i }}" class="pagination-btn {% if $i == $paginaAtual %}active{% endif; %}">{{ $i }}</a>
                    @endfor()
                    {% if $paginaAtual < $totalPaginas %}
                        <a href="/admin/parceiros/todos?pagina={{ $paginaAtual + 1 }}" class="pagination-btn">Próximo</a>
                    {% endif; %}
                </div>
            {% endif; %}
        {% else %}
            <div class="no-parceiros">
                <p>Nenhum parceiro cadastrado no momento.</p>
            </div>
        {% endif; %}

        <!-- Modal Personalizado para Adicionar Parceiro -->
        <div class="custom-modal" id="addPartnerModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Adicionar Novo Parceiro</h3>
                    <button class="close-modal" id="closeAddModal">×</button>
                </div>
                <div class="modal-body">
                    <form id="addPartnerForm">
                        <div class="form-group">
                            <label for="partnerName">Nome</label>
                            <input type="text" id="partnerName" name="nome" required>
                        </div>
                        <div class="form-group">
                            <label for="partnerType">Tipo</label>
                            <select id="partnerType" name="tipo" required>
                                <option value="Pessoa">Pessoa</option>
                                <option value="Empresa">Empresa</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="partnerEmail">E-mail</label>
                            <input type="email" id="partnerEmail" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="partnerPhone">Telefone</label>
                            <input type="text" id="partnerPhone" name="telefone" required>
                        </div>
                        <button type="submit" class="action-btn save-btn">Salvar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>