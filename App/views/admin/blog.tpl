
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
            <button class="toolbar-btn" id="link-btn" title="Inserir link"><i class="bi bi-link-45deg"></i></button>
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
