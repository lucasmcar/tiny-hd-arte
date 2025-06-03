@csrf
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
                    <div class="table-cell">Redes Sociais</div>
                    <div class="table-cell">Descrição</div>
                    <div class="table-cell">Ações</div>
                </div>
                {% foreach $parceiros as $index => $item %}
                    <div class="table-row">
                        <div class="table-cell">{{ $item['nome'] }}</div>
                        <div class="table-cell">{{ $item['tipo'] }}</div>
                        <div class="table-cell">{{ $item['email'] }}</div>
                        <div class="table-cell">{{ $item['telefone'] }}</div>
                        <div class="table-cell">
                            {% if $item['redes_sociais'] %}
                                {% set redes = json_decode($item['redes_sociais'], true) %}
                                {% if $redes['tiktok'] %}
                                    <a href="{{ $redes['tiktok'] }}" target="_blank"><i class="bi bi-tiktok"></i></a>
                                {% endif; %}
                                {% if $redes['linkedin'] %}
                                    <a href="{{ $redes['linkedin'] }}" target="_blank"><i class="bi bi-linkedin"></i></a>
                                {% endif; %}
                                {% if $redes['instagram'] %}
                                    <a href="{{ $redes['instagram'] }}" target="_blank"><i class="bi bi-instagram"></i></a>
                                {% endif; %}
                                {% if $redes['facebook'] %}
                                    <a href="{{ $redes['facebook'] }}" target="_blank"><i class="bi bi-facebook"></i></a>
                                {% endif; %}
                            {% else %}
                                <span>-</span>
                            {% endif; %}
                        </div>
                        <div class="table-cell">{{ $item['descricao'] ? substr($item['descricao'], 0, 50) ~ '...' : '-' }}</div>
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
                        <div class="form-group">
                            <label for="partnerTiktok">TikTok (URL)</label>
                            <input type="url" id="partnerTiktok" name="redes_sociais[tiktok]" placeholder="https://tiktok.com/@usuario">
                        </div>
                        <div class="form-group">
                            <label for="partnerLinkedin">LinkedIn (URL)</label>
                            <input type="url" id="partnerLinkedin" name="redes_sociais[linkedin]" placeholder="https://linkedin.com/in/usuario">
                        </div>
                        <div class="form-group">
                            <label for="partnerInstagram">Instagram (URL)</label>
                            <input type="url" id="partnerInstagram" name="redes_sociais[instagram]" placeholder="https://instagram.com/usuario">
                        </div>
                        <div class="form-group">
                            <label for="partnerFacebook">Facebook (URL)</label>
                            <input type="url" id="partnerFacebook" name="redes_sociais[facebook]" placeholder="https://facebook.com/usuario">
                        </div>
                        <div class="form-group">
                            <label for="partnerDescription">Descrição</label>
                            <textarea id="partnerDescription" name="descricao" placeholder="Descreva o parceiro"></textarea>
                        </div>
                        <button type="submit" class="action-btn save-btn">Salvar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>