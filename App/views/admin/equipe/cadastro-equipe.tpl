<div class="equipe-container">
    <h1>Cadastro de Pessoa da Equipe</h1>
    <form id="pessoaForm" method="POST" enctype="multipart/form-data" class="equipe-form">
        @csrf
        <div class="dashboard-card">
            <div class="card-header" data-target="infoPessoal" data-expanded="false">
                <div class="card-title">Informações Pessoais</div>
                <button type="button" class="toggle-button"><i class="bi bi-chevron-down"></i><i class="bi bi-chevron-up" style="display: none;"></i></button>
            </div>
            <div id="infoPessoal" class="card-content">
                <div class="form-group">
                    <label for="nome">Nome</label>
                    <input type="text" id="nome" name="nome" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="cargo">Cargo</label>
                    <input type="text" id="cargo" name="cargo" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="resumo">Resumo</label>
                    <textarea id="resumo" name="resumo" class="form-textarea" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="foto">Foto</label>
                    <input type="file" id="foto" name="foto" class="form-input" accept="image/*">
                    <small></small>
                </div>
            </div>
        </div>
        <div class="dashboard-card">
            <div class="card-header" data-target="redesSociais" data-expanded="false">
                <div class="card-title">Redes Sociais</div>
                <button type="button" class="toggle-button"><i class="bi bi-chevron-down"></i><i class="bi bi-chevron-up" style="display: none;"></i></button>
            </div>
            <div id="redesSociais" class="card-content">
                <div class="form-group">
                    <label for="instagram">Instagram</label>
                    <input type="url" id="instagram" name="redes[instagram]" class="form-input" >
                </div>
                <div class="form-group">
                    <label for="facebook">Facebook</label>
                    <input type="url" id="facebook" name="redes[facebook]" class="form-input">
                </div>
                <div class="form-group">
                    <label for="linkedin">LinkedIn</label>
                    <input type="url" id="linkedin" name="redes[linkedin]" class="form-input">
                </div>
            </div>
        </div>
        <div class="dashboard-card">
            <div class="card-header" data-target="configuracoes" data-expanded="false">
                <div class="card-title">Configurações</div>
                <button type="button" class="toggle-button"><i class="bi bi-chevron-down"></i><i class="bi bi-chevron-up" style="display: none;"></i></button>
            </div>
            <div id="configuracoes" class="card-content">
                <div class="form-group">
                    <label>Destaque</label>
                    <input type="checkbox" id="destaque" name="destaque" class="form-checkbox" checked>
                </div>
            </div>
        </div>
        <div class="button-container">
            <button type="submit" class="save-button" style="padding: 4px 12px; height: 40px; width: 200px;">Cadastrar Pessoa</button>
        </div>
        <div id="successMessage" class="success-message" style="display: none;"></div>
    </form>
</div>