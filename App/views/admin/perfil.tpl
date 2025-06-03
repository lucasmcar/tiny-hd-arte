@csrf
<section class="gerenciar-perfil-section">
    <div class="container">
        <div class="header-info">
            <h2 class="hda-title">{{ $title }}</h2>
        </div>

        <!-- Informações do Perfil -->
        <div class="config-section">
            <h3 class="section-title">Informações do Perfil</h3>
            <div class="form-group">
                <label for="admin-name">Nome:</label>
                <input type="text" id="admin-name" name="admin_name" value="{{ htmlspecialchars($adminData['nome']) }}">
            </div>

            <div class="form-group">
                <label for="admin-name">Nome:</label>
                <input type="text" id="admin-email" name="admin_email" value="{{ htmlspecialchars($adminData['email']) }}">
            </div>
            <div class="form-group">
                <label>Data de Cadastro:</label>
                <span class="profile-info">{{ date('d/m/Y', strtotime($adminData['data_cadastro'])) }}</span>
            </div>
        </div>

        <!-- Foto de Perfil -->
        <div class="config-section">
            <h3 class="section-title">Foto de Perfil</h3>
            <div class="form-group">
                <img src="{{ $adminData['foto'] }}" alt="Foto de Perfil" id="profile-pic-preview" class="profile-pic">
                <input type="file" id="profile-pic-upload" accept="image/*" style="display: none;">
                <button class="action-btn" id="upload-profile-pic">Alterar Foto</button>
            </div>
        </div>

        <!-- Alterar Senha -->
        <div class="config-section">
            <h3 class="section-title">Alterar Senha</h3>
            <div class="form-group">
                <label for="current-password">Senha Atual:</label>
                <input type="password" id="current-password" name="current_password">
            </div>
            <div class="form-group">
                <label for="new-password">Nova Senha:</label>
                <input type="password" id="new-password" name="new_password">
            </div>
            <div class="form-group">
                <label for="confirm-password">Confirmar Nova Senha:</label>
                <input type="password" id="confirm-password" name="confirm_password">
            </div>
            <button class="action-btn" id="change-password-btn">Alterar Senha</button>
        </div>

        <!-- Novos Administradores -->
        <div class="config-section">
            <h3 class="section-title">Administradores</h3>
            <div class="form-group">
                <label for="new-admin-name">Nome:</label>
                <input type="text" id="new-admin-name" name="new_admin_name">
                <label for="new-admin-email">E-mail:</label>
                <input type="email" id="new-admin-email" name="new_admin_email">
                <label for="new-admin-senha">Senha:</label>
                <input type="password" id="new-admin-senha" name="new_admin_senha">
                <button class="action-btn" id="add-admin-btn">Adicionar Administrador</button>
            </div>
            <div id="admins-list">
            {% if isset($admins) %}
                {% foreach $admins as $index => $admin %}
                    <div class="admin-item" data-id="{{ $admin['id'] }}">
                        <span>{{ $admin['nome'] }} ({{ $admin['email'] }})</span>
                        <button class="remove-btn">Remover</button>
                    </div>
                {% endforeach; %}
            {% else %}
                <div>Não há administradores cadastrados para esse perfil</div>
            {% endif; %}
            </div>
        </div>

        <!-- E-mails da Empresa -->
        <div class="config-section">
            <h3 class="section-title">E-mails da Empresa</h3>
            <div class="form-group">
                <label for="new-email">Novo E-mail:</label>
                <input type="email" id="new-email" name="new_email">
                <button class="action-btn" id="add-email-btn"><i class="bi bi-plus"></i></button>
            </div>
            <div id="emails-list">
            {% if isset($emails_empresa) %}
                {% foreach $emails_empresa as $index => $email %}
                    <div class="email-item" data-id="{{ $email['id'] }}">
                        <span> {{ $email['email'] }} </span>
                        <button class="remove-btn">Remover</button>
                    </div>
                {% endforeach; %}
            {% else %}
                <div>Não há emails cadastrados</div>
            {% endif; %}
            </div>
        </div>

        <!-- Nome nos Artigos -->
        <div class="config-section">
            <h3 class="section-title">Nome nos Artigos</h3>
            <div class="form-group">
                <label for="display-name">Nome Exibido:</label>
                <input type="text" id="display-name" name="display_name" value="{{ $adminData['nome_exibicao'] }}">
            </div>
        </div>

        <!-- Modal de Confirmação de Salvamento -->
        <div class="modal fade" id="saveProfileModal" tabindex="-1" aria-labelledby="saveProfileModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveProfileModalLabel">Confirmação</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modalMessage">
                        Salvando dados...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary-netflix" data-bs-dismiss="modal">Fechar</button>
                    </div>
                </div>
            </div>
        </div>

        <button class="action-btn save-btn" id="saveProfileBtn">Salvar Tudo</button>
    </div>
</section>