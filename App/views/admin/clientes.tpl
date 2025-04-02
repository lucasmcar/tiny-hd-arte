<div class="container-cadastro">
    <div class="card-cadastro">
        <h2 class="title">{{ $title }}</h2>
        <form id="form-cadastro" action="/cliente/novo" method="POST">
            <div class="form-group">
                <label for="nome">Nome *</label>
                <input type="text" id="nome" name="nome" required placeholder="Digite o nome do cliente" class="input-field">
            </div>

            <div class="form-group">
                <label for="contato">Contato *</label>
                <input type="text" id="contato" name="contato" required placeholder="E-mail ou telefone" class="input-field">
            </div>

            <div class="form-group">
                <label for="tipo_cliente">Tipo de Entidade *</label>
                <select id="tipo_cliente" name="tipo_cliente" required class="input-field">
                    <option value="">Selecione o tipo</option>
                    <option value="privado">Iniciativa Privada</option>
                    <option value="publico">Poder Público</option>
                    <option value="pessoa_fisica">Pessoa Física</option>
                </select>
            </div>

            <div class="form-group">
                <label for="objetivos">Objetivos Culturais *</label>
                <textarea id="objetivos" name="objetivos" required placeholder="Descreva os objetivos culturais" class="input-field textarea"></textarea>
            </div>

            <button type="submit" class="btn-submit">Cadastrar</button>
            <button type="button" class="btn-cancel" onclick="window.location.href='/clientes'">Cancelar</button>
        </form>
    </div>
</div>