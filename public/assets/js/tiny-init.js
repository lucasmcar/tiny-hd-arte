function initializeTinyMCE() {
    console.log('Inicializando TinyMCE...');

    // Verifica se o tinymce está disponível
    if (typeof tinymce === 'undefined') {
        console.error('TinyMCE não está definido. Tentando novamente em 100ms...');
        setTimeout(initializeTinyMCE, 100);
        return;
    }

    // Verifica se o elemento #content existe no DOM
    const contentElement = document.getElementById('content');
    if (!contentElement) {
        console.error('Elemento #content não encontrado no DOM. Tentando novamente em 100ms...');
        setTimeout(initializeTinyMCE, 100);
        return;
    }

    // Verifica se o elemento #content é visível
    const isVisible = contentElement.offsetParent !== null;
    if (!isVisible) {
        console.warn('Elemento #content não está visível no DOM. Tentando novamente em 100ms...');
        setTimeout(initializeTinyMCE, 100);
        return;
    }

    console.log('TinyMCE encontrado e elemento #content presente e visível. Configurando o editor...');

    // Remove qualquer instância anterior do TinyMCE no elemento #content
    if (tinymce.get('content')) {
        console.log('Removendo instância anterior do TinyMCE...');
        tinymce.get('content').remove();
    }

    tinymce.init({
        selector: '#content',
        plugins: 'advlist autolink lists link image charmap preview anchor searchreplace visualblocks code fullscreen insertdatetime media table',
        toolbar: 'undo redo | styles | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | code',
        menubar: true,
        height: 400,
        license_key: 'gpl',
        images_upload_handler: (blobInfo, progress) => new Promise((resolve, reject) => {
            const formData = new FormData();
            formData.append('file', blobInfo.blob(), blobInfo.filename());

            fetch('/uploadImage', {
                method: 'POST',
                body: formData,
                headers: {
                    'X-CSRF-Token': document.querySelector('input[name="_csrf_token"]')?.value
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.location) {
                    resolve(data.location);
                } else {
                    reject({ message: 'Erro ao fazer upload da imagem', remove: true });
                }
            })
            .catch(error => {
                reject({ message: 'Erro ao fazer upload da imagem: ' + error.message, remove: true });
            });
        }),
        setup: (editor) => {
            console.log('Editor TinyMCE configurado com sucesso.');
            editor.on('init', () => {
                console.log('Editor TinyMCE inicializado com sucesso.');
                // Forçar a visibilidade do editor
                const editorContainer = document.querySelector('.tox-tinymce');
                if (editorContainer) {
                    editorContainer.style.display = 'block';
                    editorContainer.style.visibility = 'visible';
                }
                // Mover o foco para o editor
                editor.focus();
            });
            editor.on('error', (error) => {
                console.error('Erro na inicialização do TinyMCE:', error.message);
            });
        }
    });

    // Adiciona o evento de salvar
    const saveBtn = document.getElementById('saveBtn');
    if (saveBtn) {
        saveBtn.addEventListener('click', function() {
            console.log('Botão Salvar clicado.');
            const title = document.getElementById('title').value;
            const content = tinymce.get('content') ? tinymce.get('content').getContent() : '';

            if (!title || !content) {
                alert('Por favor, preencha o título e o conteúdo.');
                return;
            }

            fetch('/saveContent', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('input[name="_csrf_token"]')?.value
                },
                body: JSON.stringify({ title: title, content: content })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.success);
                    document.getElementById('title').value = '';
                    tinymce.get('content').setContent('');
                } else {
                    alert(data.error);
                }
            })
            .catch(error => {
                console.error('Erro ao salvar conteúdo:', error);
                alert('Erro ao salvar conteúdo.');
            });
        });
    } else {
        console.error('Botão #saveBtn não encontrado no DOM.');
    }
}

// Função para inicializar o TinyMCE em um contexto dinâmico
function initializeTinyMCEOnDynamicLoad() {
    console.log('Inicializando TinyMCE em contexto dinâmico...');
    initializeTinyMCE();
}

// Executa a inicialização quando o DOM estiver carregado (para carregamento inicial)
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM carregado. Iniciando inicialização do TinyMCE...');
    initializeTinyMCE();
});

// Exporta a função para uso em carregamento dinâmico
window.initializeTinyMCEOnDynamicLoad = initializeTinyMCEOnDynamicLoad;