
// Função para inicializar os eventos
function initializeEvents() {
   

    // Dropdown Toggle
    const dropdownToggle = document.getElementById('dropdownToggle');
    const dropdownContent = document.getElementById('dropdownContent');
    if (dropdownToggle && dropdownContent) {
        dropdownToggle.addEventListener('click', function () {
            const isVisible = dropdownContent.style.display === 'block';
            dropdownContent.style.display = isVisible ? 'none' : 'block';
            
        });
    } else {
        console.error('Erro ao encontrar elementos do dropdown:', {
            dropdownToggle: !!dropdownToggle,
            dropdownContent: !!dropdownContent
        });
    }

    // Checkbox de Notificação
    const notifyCheckbox = document.getElementById('notifyAdmin');
    const emailConfig = document.getElementById('emailConfig');
    if (notifyCheckbox && emailConfig) {
        
        notifyCheckbox.addEventListener('change', function () {
            emailConfig.style.display = this.checked ? 'flex' : 'none';
            
        });
    } else {
        console.error('Erro ao encontrar elementos de notificação:', {
            notifyCheckbox: !!notifyCheckbox,
            emailConfig: !!emailConfig
        });
    }

    // Botão Gerar Link
    const generateLinkButtons = document.querySelectorAll('.generate-link-btn:not(.disabled)');
    if (generateLinkButtons.length > 0) {
        
        generateLinkButtons.forEach(button => {
            button.addEventListener('click', function () {
                const id = this.getAttribute('data-id');
                const link = `http://localhost:8000/depoimento/form/${id}`;
                document.getElementById('generated-link').textContent = link;
                try {
                    const modalElement = document.getElementById('linkModal');
                    const modal = new bootstrap.Modal(modalElement);
                    modal.show();
                    // Move o foco para o modal após abrir
                    modalElement.querySelector('.modal-title').focus();
                    
                } catch (error) {
                    console.error('Erro ao abrir modal de link:', error);
                }
            });
        });
    } else {
        console.error('Nenhum botão Gerar Link encontrado!');
    }

    // Teste de Modal de Depoimento
    document.querySelectorAll('.dropdown-item').forEach(item => {
        item.addEventListener('click', function () {
            const id = this.getAttribute('data-id');
            const depoimento = {
                1: { nome: 'João Silva', titulo: 'Cliente', depoimento: 'Evento incrível!' },
                2: { nome: 'Maria Oliveira', titulo: 'Parceira', depoimento: 'Muito profissional!' }
            }[id];
            if (depoimento) {
                document.getElementById('modal-nome').textContent = depoimento.nome;
                document.getElementById('modal-titulo').textContent = depoimento.titulo;
                document.getElementById('modal-depoimento').textContent = depoimento.depoimento;
                const modalElement = document.getElementById('depoimentoModal');
                const modal = new bootstrap.Modal(modalElement);
                modal.show();
                // Move o foco para o modal após abrir
                modalElement.querySelector('.modal-title').focus();
                
            }
        });
    });
}

// Executa imediatamente
initializeEvents();