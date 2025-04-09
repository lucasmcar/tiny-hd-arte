<div class="consultoria-container">
    <h2>{{ $title }}</h2>
    <form id="consultoriaForm" enctype="multipart/form-data">
        <!-- Dados do Cliente -->
        <div class="form-section">
            <h3>Dados do Cliente</h3>
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" class="form-input" placeholder="Digite o nome do cliente" required>
            </div>
            <div class="form-group">
                <label for="tipo_cliente">Tipo de Cliente:</label>
                <select id="tipo_cliente" name="tipo_cliente" class="form-input" required>
                    <option value="">Selecione o tipo de cliente</option>
                    <option value="iniciativa_privada">Iniciativa Privada</option>
                    <option value="poder_publico">Poder Público</option>
                    <option value="pessoa_fisica">Pessoa Física</option>
                </select>
            </div>
            <div class="form-group">
                <label for="contato">Contato:</label>
                <input type="text" id="contato" name="contato" class="form-input" placeholder="Digite o contato (e-mail ou telefone)" required>
            </div>
            <div class="form-group">
                <label for="objetivos">Objetivos Culturais:</label>
                <textarea id="objetivos" name="objetivos" class="form-textarea" placeholder="Descreva os objetivos culturais do cliente" required></textarea>
            </div>
        </div>

        <!-- Demandas Específicas -->
        <div class="form-section">
            <h3>Demandas Específicas</h3>
            <div class="form-group">
                <label for="demandas">Demandas:</label>
                <select id="demandas" name="demandas" class="form-input" required>
                    <option value="">Selecione a demanda</option>
                    <option value="fortalecimento_marca">Fortalecimento de Marca</option>
                    <option value="agregacao_valor">Agregação de Valor</option>
                    <option value="melhoria_imagem_publica">Melhoria de Imagem Pública</option>
                </select>
            </div>
        </div>

        <!-- Upload de Documentos -->
        <div class="form-section">
            <h3>Upload de Documentos</h3>
            <div class="form-group">
                <label for="documentos">Documentos (briefings, contratos, relatórios):</label>
                <input type="file" id="documentos" name="documentos[]" class="form-input" multiple accept=".pdf,.doc,.docx">
            </div>
        </div>

        <!-- Botões -->
        <div class="form-actions">
            <button type="submit" class="save-button">Salvar</button>
            <button type="button" id="generateReportBtn" class="report-button">Gerar Relatório</button>
        </div>
    </form>

    <!-- Área para Exibir o Relatório -->
    <div id="reportSection" class="report-section" style="display: none;">
        <h3>Relatório Personalizado</h3>
        <pre id="reportContent"></pre>
    </div>
</div>