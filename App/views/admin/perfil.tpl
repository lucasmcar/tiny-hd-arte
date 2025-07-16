@csrf
<section class="gerenciar-perfil-section" aria-label="Seção de Gerenciamento de Perfil">
    <div class="container">
        <div class="header-info" role="banner">
            <h2 class="hda-title">{{ $title }}</h2>
        </div>

        <div class="profile-grid" role="main">
            <!-- Coluna 1: Informações do Perfil e Foto -->
            <div class="config-section profile-info-section" role="region" aria-labelledby="profile-info-title">
                <h3 class="section-title" id="profile-info-title">Informações do Perfil</h3>
                <div class="form-group">
                    <label for="admin-name" class="form-label">Nome:</label>
                    <input type="text" id="admin-name" name="admin_name" value="{{ htmlspecialchars($adminData['nome']) }}" aria-required="true">
                </div>
                <div class="form-group">
                    <label for="admin-email" class="form-label">E-mail:</label>
                    <input type="email" id="admin-email" name="admin_email" value="{{ htmlspecialchars($adminData['email']) }}" aria-required="true">
                </div>
                <div class="form-group">
                    <label class="form-label">Data de Cadastro:</label>
                    <span class="profile-info" aria-live="polite">{{ date('d/m/Y', strtotime($adminData['data_cadastro'])) }}</span>
                </div>
            </div>

            <div class="config-section profile-pic-section" role="region" aria-labelledby="profile-pic-title">
                <h3 class="section-title" id="profile-pic-title">Foto de Perfil</h3>
                <div class="form-group">
                    <img src="{{ $adminData['foto'] }}" alt="Foto de Perfil" id="profile-pic-preview" class="profile-pic">
                    <input type="file" id="profile-pic-upload" accept="image/*" style="display: none;" aria-label="Carregar nova foto">
                    <button class="action-btn" id="upload-profile-pic" aria-label="Alterar foto de perfil">Alterar Foto</button>
                </div>
            </div>

            <!-- Coluna 2: Alterar Senha -->
            <div class="config-section password-section" role="region" aria-labelledby="password-title">
                <h3 class="section-title" id="password-title">Alterar Senha</h3>
                <div class="form-group">
                    <label for="current-password" class="form-label">Senha Atual:</label>
                    <input type="password" id="current-password" name="current_password" aria-required="true">
                </div>
                <div class="form-group">
                    <label for="new-password" class="form-label">Nova Senha:</label>
                    <input type="password" id="new-password" name="new_password" aria-required="true">
                </div>
                <div class="form-group">
                    <label for="confirm-password" class="form-label">Confirmar Nova Senha:</label>
                    <input type="password" id="confirm-password" name="confirm_password" aria-required="true">
                </div>
                <button class="action-btn" id="change-password-btn" aria-label="Alterar senha">Alterar Senha</button>
            </div>

            <!-- Coluna 3: Administradores e E-mails -->
            <div class="config-section admins-section" role="region" aria-labelledby="admins-title">
                <h3 class="section-title" id="admins-title">Administradores</h3>
                <div class="form-group">
                    <label for="new-admin-name" class="form-label">Nome:</label>
                    <input type="text" id="new-admin-name" name="new_admin_name" aria-required="true">
                    <label for="new-admin-email" class="form-label">E-mail:</label>
                    <input type="email" id="new-admin-email" name="new_admin_email" aria-required="true">
                    <label for="new-admin-senha" class="form-label">Senha:</label>
                    <input type="password" id="new-admin-senha" name="new_admin_senha" aria-required="true">
                    <button class="action-btn" id="add-admin-btn" aria-label="Adicionar administrador">Adicionar Administrador</button>
                </div>
                <div id="admins-list" role="list" aria-live="polite" class="list-container">
                    {% if isset($admins) %}
                        {% foreach $admins as $index => $admin %}
                            <div class="admin-item" data-id="{{ $admin['id'] }}" role="listitem">
                                <span>{{ $admin['nome'] }} ({{ $admin['email'] }})</span>
                                <button class="remove-btn" aria-label="Remover administrador {{ $admin['nome'] }}">Remover</button>
                            </div>
                        {% endforeach; %}
                    {% else %}
                        <div class="admin-item" role="listitem">Não há administradores cadastrados para esse perfil</div>
                    {% endif; %}
                </div>
            </div>

            <div class="config-section emails-section" role="region" aria-labelledby="emails-title">
                <h3 class="section-title" id="emails-title">E-mails da Empresa</h3>
                <div class="form-group">
                    <label for="new-email" class="form-label">Novo E-mail:</label>
                    <input type="email" id="new-email" name="new_email" aria-required="true">
                    <button class="action-btn" id="add-email-btn" aria-label="Adicionar novo e-mail"><i class="bi bi-plus"></i></button>
                </div>
                <div id="emails-list" role="list" aria-live="polite" class="list-container">
                    {% if isset($emails_empresa) %}
                        {% foreach $emails_empresa as $index => $email %}
                            <div class="email-item" data-id="{{ $email['id'] }}" role="listitem">
                                <span>{{ $email['email'] }}</span>
                                <button class="remove-btn" aria-label="Remover e-mail {{ $email['email'] }}">Remover</button>
                            </div>
                        {% endforeach; %}
                    {% else %}
                        <div class="email-item" role="listitem">Não há emails cadastrados</div>
                    {% endif; %}
                </div>
            </div>

            <!-- Coluna 4: Nome nos Artigos -->
            <div class="config-section display-name-section" role="region" aria-labelledby="display-name-title">
                <h3 class="section-title" id="display-name-title">Nome nos Artigos</h3>
                <div class="form-group">
                    <label for="display-name" class="form-label">Nome Exibido:</label>
                    <input type="text" id="display-name" name="display_name" value="{{ $adminData['nome_exibicao'] }}" aria-required="true">
                </div>
            </div>
        </div>

        <!-- Modal de Confirmação de Salvamento -->
        <div class="modal fade" id="saveProfileModal" tabindex="-1" aria-labelledby="saveProfileModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveProfileModalLabel">Confirmação</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Fechar"></button>
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

        <button class="action-btn save-btn" id="saveProfileBtn" aria-label="Salvar todas as alterações">Salvar Tudo</button>
    </div>
</section>