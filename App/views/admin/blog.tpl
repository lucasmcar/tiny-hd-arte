
    <div class="main-container">
        <h2>{{ $title }}</h2>
        <input type="text" id="title" class="title-input" placeholder="Digite o título aqui">
        
        <!-- Barra de ferramentas do editor -->
        <div class="editor-toolbar">
            <button class="toolbar-btn" data-command="bold" title="Negrito"><i class="bi bi-type-bold"></i></button>
            <button class="toolbar-btn" data-command="italic" title="Itálico"><i class="bi bi-type-italic"></i></button>
            <button class="toolbar-btn" data-command="underline" title="Sublinhado"><i class="bi bi-type-underline"></i></button>
            <button class="toolbar-btn" data-command="insertUnorderedList" title="Lista não ordenada"><i class="bi bi-list-ul"></i></button>
            <button class="toolbar-btn" data-command="insertOrderedList" title="Lista ordenada"><i class="bi bi-list-ol"></i></button>
            <button class="toolbar-btn" data-command="paragraph"><i class="bi bi-paragraph"></i></button>
            <!-- Botão de Upload de Imagem com Ícone -->
            <button class="toolbar-btn" id="image-upload-btn"><i class="bi bi-image"></i></button>
            <input type="file" id="image-upload" accept="image/*" multiple style="display: none;">
            <!-- Botões de Alinhamento -->
            <button class="toolbar-btn" data-align="left"><i class="bi bi-text-left"></i></button>
            <button class="toolbar-btn" data-align="center"><i class="bi bi-text-center"></i></button>
            <button class="toolbar-btn" data-align="right"><i class="bi bi-text-right"></i></button>
            <button class="toolbar-btn" data-align="justify"><i class="bi bi-justify"></i></button>
            <button class="toolbar-btn" id="link-btn" title="Inserir link"><i class="bi bi-link-45deg"></i></button>
            <select id="heading-select" class="toolbar-select">
                <option value="">Texto Normal</option>
                <option value="h1">Título 1</option>
                <option value="h2">Título 2</option>
                <option value="h3">Título 3</option>
                <option value="h4">Título 4</option>
                <option value="h5">Título 5</option>
                <option value="h6">Título 6</option>
            </select>
        </div>
        
        <!-- Área de edição -->
        <div contenteditable="true" id="content" class="editor-content" placeholder="Digite o conteúdo aqui..."></div>

        <!-- Upload de imagem -->
        <div class="image-upload-container">
            <label for="image-upload" class="upload-label">Escolher Imagem</label>
            <input type="file" id="image-upload" accept="image/*" style="display: none;">
            <div id="image-preview" class="image-preview"></div>
        </div>

        <button class="save-button" id="saveBtn">Salvar</button>
    </div>
