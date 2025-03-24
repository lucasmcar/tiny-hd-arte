<section class="gerenciar-depoimentos-section">
    <div class="grid-container">
        <!-- Título -->
        <div class="grid-item title-block">
            <h2 class="hda-title">Gerenciar Depoimentos</h2>
        </div>

        <!-- Aviso de Depoimentos Pendentes -->
        <div class="grid-item pending-block">
            <div class="pending-alert">
                <p>Depoimentos a aceitar: <span class="pending-count">{{ $totalPendentes }}</span></p>
            </div>
        </div>

        <!-- Filtro de Status (Regra 6) -->
        <div class="grid-item filter-block">
            <label for="status-filter">Filtrar por Status:</label>
            <select id="status-filter" class="status-dropdown">
                <option value="Pendente">Pendentes</option>
                <option value="Aceito">Aceitos</option>
                <option value="Rejeitado">Rejeitados</option>
            </select>
        </div>

        <!-- Dropdown de Depoimentos -->
        <div class="grid-item depoimentos-block">
            {% if $totalPendentes > 0 %}
                <button class="dropdown-btn" id="dropdownToggle">Ver Depoimentos Pendentes <i class="bi bi-caret-down-fill"></i></button>
                <div class="dropdown-content" id="dropdownContent">
                    {% foreach $depoimentos as $index => $item %}
                        <div class="dropdown-item" data-id="{{ $item['id'] }}" data-bs-toggle="modal" data-bs-target="#depoimentoModal">
                            <span>{{ $item['nome'] }} - {{ $item['titulo'] }} ({{ $item['data'] }})</span>
                        </div>
                    {% endforeach; %}
                </div>
                {% if $totalPaginas > 1 %}
                    <div class="pagination-netflix">
                        {% if $paginaAtual > 1 %}
                            <a href="/admin/gerenciar/depoimentos?pagina={{ $paginaAtual - 1 }}" class="pagination-btn">Anterior</a>
                        {% endif; %}
                        @for( 1, $totalPaginas, $i )
                            <a href="/admin/gerenciar/depoimentos?pagina={{ $i }}" class="pagination-btn {% if $i == $paginaAtual %}active{% endif; %}">{{ $i }}</a>
                        @endfor()
                        {% if $paginaAtual < $totalPaginas %}
                            <a href="/admin/gerenciar/depoimentos?pagina={{ $paginaAtual + 1 }}" class="pagination-btn">Próximo</a>
                        {% endif; %}
                    </div>
                {% endif; %}
            {% else %}
                <div class="no-depoimentos">
                    <p>Nenhum depoimento pendente no momento.</p>
                </div>
            {% endif; %}
        </div>

        <!-- Configuração de Notificação -->
        <div class="grid-item notification-block">
            <label class="checkbox-label">
                <input type="checkbox" id="notifyAdmin" {% if $notificarAdmin %}checked{% endif; %}>
                Notificar administrador por e-mail
            </label>
            <div class="email-config" id="emailConfig" {% if !$notificarAdmin %}style="display: none;"{% endif; %}>
                <input type="email" id="adminEmail" value="{{ $emailAdmin }}" placeholder="Digite o e-mail do administrador">
                <button class="action-btn save-btn" id="saveEmail">Salvar</button>
            </div>
        </div>

        <!-- Grid de Projetos -->
        <div class="grid-item projetos-block">
            <h3 class="hda-subtitle">Projetos</h3>
            <div class="projeto-grid">
                {% foreach $projetos as $index => $item %}
                    <div class="projeto-item">
                        <h4>{{ $item['nome'] }}</h4>
                        <p>Status: <span class="status-{{ $item['status'] }}">{{ $item['status'] }}</span></p>
                        {% if $item['status'] == 'Finalizado' %}
                            <button class="action-btn generate-link-btn" data-id="{{ $item['id'] }}">Gerar Link</button>
                        {% else %}
                            <button class="action-btn generate-link-btn disabled" disabled>Gerar Link</button>
                        {% endif; %}
                    </div>
                {% endforeach; %}
            </div>
        </div>

        <!-- Ações Extras -->
        <div class="grid-item actions-block">
            <button class="action-btn export-btn">Exportar Depoimentos (CSV)</button>
            <label class="checkbox-label">
                <input type="checkbox" id="autoReminders"> Enviar lembretes automáticos após 7 dias
            </label>
        </div>

        <!-- Modal para Visualizar Depoimento -->
        <div class="modal fade" id="depoimentoModal" tabindex="-1" aria-labelledby="depoimentoModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="depoimentoModalLabel">Detalhes do Depoimento</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p><strong>Nome:</strong> <span id="modal-nome"></span></p>
                        <p><strong>Título:</strong> <span id="modal-titulo"></span></p>
                        <p><strong>Depoimento:</strong> <span id="modal-depoimento"></span></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="action-btn accept-btn" id="acceptDepoimento">Aceitar</button>
                        <button type="button" class="action-btn reject-btn" id="rejectDepoimento">Rejeitar</button>
                        <button type="button" class="action-btn close-btn" data-bs-dismiss="modal">Fechar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal para Enviar Link -->
        <div class="modal fade" id="linkModal" tabindex="-1" aria-labelledby="linkModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="linkModalLabel">Enviar Link de Depoimento</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p><strong>Link Gerado:</strong> <span id="generated-link"></span></p>
                        <textarea id="emails" placeholder="Digite os e-mails separados por vírgula" rows="4" class="form-control"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="action-btn send-btn" id="sendEmails">Enviar</button>
                        <button type="button" class="action-btn close-btn" data-bs-dismiss="modal">Fechar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>