<section class="gerenciar-perfil-section">
    <div class="container">
        <div class="header-info">
            <h2 class="hda-title">Gerenciar Perfil do Administrador</h2>
        </div>

        <!-- Foto de Perfil -->
        <div class="config-section">
            <h3 class="section-title">Foto de Perfil</h3>
            <div class="form-group">
                <img src="{{ $adminData['foto_perfil'] }}" alt="Foto de Perfil" id="profile-pic-preview" class="profile-pic">
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
                <button class="action-btn" id="add-admin-btn">Adicionar Administrador</button>
            </div>
            <div id="admins-list">
                {% foreach $adminData['admins'] as $index => $admin %}
                    <div class="admin-item" data-id="{{ $admin['id'] }}">
                        <span>{{ $admin['nome'] }} ({{ $admin['email'] }})</span>
                        <button class="remove-btn">Remover</button>
                    </div>
                {% endforeach; %}
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
                {% foreach $adminData['emails_empresa'] as $index => $email %}
                    <div class="email-item" data-id="{{ $email['id'] }}">
                        <input type="email" value="{{ $email['email'] }}" class="email-input">
                        <button class="remove-btn">Remover</button>
                    </div>
                {% endforeach; %}
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

        <button class="action-btn save-btn" id="saveProfileBtn">Salvar Tudo</button>
    </div>
</section>