<div class="projetos-container">
    <h1>Cadastro de Projetos em Captação</h1>
    <form id="projectForm" method="POST" enctype="multipart/form-data" class="project-form">
        @csrf
        <!-- Card 1: Informações Gerais -->
        <div class="dashboard-card">
            <div class="card-header" data-target="infoGerais">
                <div class="card-title">Informações Gerais</div>
                <button type="button" class="toggle-button"><i class="bi bi-chevron-down"></i><i class="bi bi-chevron-up" style="display: none;"></i></button>
            </div>
            <div id="infoGerais" class="card-content">
                <div class="form-group">
                    <label for="pronac">PRONAC</label>
                    <input type="text" id="pronac" name="pronac" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="title">Nome do Projeto</label>
                    <input type="text" id="title" name="title" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="proponente">Proponente</label>
                    <input type="text" id="proponente" name="proponente" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="cnpj_cpf">CNPJ/CPF</label>
                    <input type="text" id="cnpj_cpf" name="cnpj_cpf" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="uf">UF</label>
                    <input type="text" id="uf" name="uf" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="mecanismo">Mecanismo</label>
                    <input type="text" id="mecanismo" name="mecanismo" class="form-input" readonly>
                </div>
            </div>
        </div>

        <!-- Card 2: Detalhes do Projeto -->
        <div class="dashboard-card">
            <div class="card-header" data-target="detalhesProjeto">
                <div class="card-title">Detalhes do Projeto</div>
                <button type="button" class="toggle-button"><i class="bi bi-chevron-down"></i><i class="bi bi-chevron-up" style="display: none;"></i></button>
            </div>
            <div id="detalhesProjeto" class="card-content">
                <div class="form-group">
                    <label for="area_cultural">Área Cultural</label>
                    <select id="area_cultural" name="area_cultural" class="form-select" required>
                        <option value="Música" selected>Música</option>
                        <option value="Artes Cênicas">Artes Cênicas</option>
                        <option value="Multicultural">Multicultural</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="segmento">Segmento</label>
                    <input type="text" id="segmento" name="segmento" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="tipologia">Tipologia</label>
                    <select id="tipologia" name="tipologia" class="form-select" required>
                        <option value="Projetos Normais" selected>Projetos Normais</option>
                        <option value="Festival">Festival</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="tipicidade">Tipicidade</label>
                    <input type="text" id="tipicidade" name="tipicidade" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="processo">Processo</label>
                    <input type="text" id="processo" name="processo" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="portaria">Portaria</label>
                    <input type="text" id="portaria" name="portaria" class="form-input" required>
                </div>
            </div>
        </div>

        <!-- Card 3: Financeiro e Períodos -->
        <div class="dashboard-card">
            <div class="card-header" data-target="financeiroPeriodos">
                <div class="card-title">Financeiro e Períodos</div>
                <button type="button" class="toggle-button"><i class="bi bi-chevron-down"></i><i class="bi bi-chevron-up" style="display: none;"></i></button>
            </div>
            <div id="financeiroPeriodos" class="card-content">
                <div class="form-group">
                    <label for="valor_captacao">Valor para Captação</label>
                    <input type="text" id="valor_captacao" name="valor_captacao" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="periodo_captacao">Período de Captação</label>
                    <input type="text" id="periodo_captacao" name="periodo_captacao" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="periodo_execucao">Período de Execução</label>
                    <input type="text" id="periodo_execucao" name="periodo_execucao" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="situacao">Situação</label>
                    <input type="text" id="situacao" name="situacao" class="form-input" required>
                </div>
            </div>
        </div>

        <!-- Card 4: Conteúdo -->
        <div class="dashboard-card">
            <div class="card-header" data-target="conteudo">
                <div class="card-title">Conteúdo</div>
                <button type="button" class="toggle-button"><i class="bi bi-chevron-down"></i><i class="bi bi-chevron-up" style="display: none;"></i></button>
            </div>
            <div id="conteudo" class="card-content">
                <div class="form-group">
                    <label for="description">Descrição</label>
                    <textarea id="description" name="description" class="form-textarea" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="resumo">Resumo</label>
                    <textarea id="resumo" name="resumo" class="form-textarea" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="content">Conteúdo</label>
                    <textarea id="content" name="content" class="form-textarea" rows="5" required></textarea>
                </div>
                <div class="form-group">
                    <label for="image">Imagem Principal</label>
                    <input type="file" id="image" name="image" class="form-input">
                </div>
                <div class="form-group">
                    <label for="extra_image">Imagem Adicional</label>
                    <input type="file" id="extra_image" name="extra_image" class="form-input">
                </div>
            </div>
        </div>

        <div class="button-container">
            <button type="submit" class="save-button" style="padding: 4px 12px; height: 40px; width: 200px;">Cadastrar Projeto</button>
        </div>
        <div id="successMessage" class="success-message" style="display: none;"></div>
    </form>
</div>