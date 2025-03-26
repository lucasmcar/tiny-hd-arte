console.log('Script gerenciar-parceiros.js carregado com sucesso!');

function initializeEvents() {
    console.log('Inicializando eventos...');

    // Botão Adicionar Parceiro
    const addPartnerBtn = document.getElementById('addPartnerBtn');
    const addPartnerModal = document.getElementById('addPartnerModal');
    const closeAddModal = document.getElementById('closeAddModal');
    const addPartnerForm = document.getElementById('addPartnerForm');

    if (addPartnerBtn && addPartnerModal && closeAddModal && addPartnerForm) {
        console.log('Elementos do modal de adição encontrados.');

        // Abrir Modal
        addPartnerBtn.addEventListener('click', function () {
            addPartnerModal.classList.add('active');
            console.log('Modal de adição aberto.');
        });

        // Fechar Modal
        closeAddModal.addEventListener('click', function () {
            addPartnerModal.classList.remove('active');
            console.log('Modal de adição fechado.');
        });

        // Fechar ao clicar fora do modal
        addPartnerModal.addEventListener('click', function (e) {
            if (e.target === addPartnerModal) {
                addPartnerModal.classList.remove('active');
                console.log('Modal fechado ao clicar fora.');
            }
        });

        // Submissão do Formulário
        addPartnerForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const parceiro = {
                nome: document.getElementById('partnerName').value,
                tipo: document.getElementById('partnerType').value,
                email: document.getElementById('partnerEmail').value,
                telefone: document.getElementById('partnerPhone').value
            };
            console.log('Novo parceiro adicionado:', parceiro);
            // Aqui você pode fazer um fetch POST para salvar no backend
            addPartnerModal.classList.remove('active');
            addPartnerForm.reset();
        });
    } else {
        console.error('Erro ao encontrar elementos do modal de adição.');
    }

    // Botões de Ação (Editar e Excluir)
    document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function () {
            const id = this.getAttribute('data-id');
            console.log('Editar parceiro ID:', id);
            // Lógica para editar (ex.: abrir outro modal ou redirecionar)
        });
    });

    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function () {
            const id = this.getAttribute('data-id');
            console.log('Excluir parceiro ID:', id);
            // Lógica para excluir (ex.: confirmação e fetch DELETE)
        });
    });
}

initializeEvents();