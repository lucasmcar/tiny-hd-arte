document.addEventListener('DOMContentLoaded', function () {
    // Dropdown Toggle
    const dropdownToggle = document.getElementById('dropdownToggle');
    const dropdownContent = document.getElementById('dropdownContent');
    if (dropdownToggle && dropdownContent) {
        dropdownToggle.addEventListener('click', function () {
            const isVisible = dropdownContent.style.display === 'block';
            dropdownContent.style.display = isVisible ? 'none' : 'block';
            console.log('Dropdown toggled:', !isVisible ? 'aberto' : 'fechado');
        });
    } else {
        console.error('Erro: Elementos do dropdown não encontrados!', {
            dropdownToggle: !!dropdownToggle,
            dropdownContent: !!dropdownContent
        });
    }

    // Abrir Modal de Depoimento
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
                document.getElementById('acceptDepoimento').setAttribute('data-id', id);
                document.getElementById('rejectDepoimento').setAttribute('data-id', id);
                console.log('Modal aberto para depoimento ID:', id);
            } else {
                console.error('Depoimento não encontrado para ID:', id);
            }
        });
    });

    // Aceitar Depoimento
    document.getElementById('acceptDepoimento').addEventListener('click', function () {
        const id = this.getAttribute('data-id');
        console.log('Aceitando depoimento ID:', id);
        document.querySelector('#depoimentoModal .close-btn').click();
    });

    // Rejeitar Depoimento
    document.getElementById('rejectDepoimento').addEventListener('click', function () {
        const id = this.getAttribute('data-id');
        console.log('Rejeitando depoimento ID:', id);
        document.querySelector('#depoimentoModal .close-btn').click();
    });

    // Checkbox de Notificação
    const notifyCheckbox = document.getElementById('notifyAdmin');
    const emailConfig = document.getElementById('emailConfig');
    if (notifyCheckbox && emailConfig) {
        notifyCheckbox.addEventListener('change', function () {
            emailConfig.style.display = this.checked ? 'flex' : 'none';
            console.log('Notificação toggled:', this.checked ? 'ativada' : 'desativada');
        });
    } else {
        console.error('Erro: Elementos de notificação não encontrados!', {
            notifyCheckbox: !!notifyCheckbox,
            emailConfig: !!emailConfig
        });
    }

    // Salvar E-mail
    document.getElementById('saveEmail').addEventListener('click', function () {
        const email = document.getElementById('adminEmail').value;
        console.log('Salvando e-mail do administrador:', email);
    });

    // Gerar Link
    document.querySelectorAll('.generate-link-btn:not(.disabled)').forEach(button => {
        button.addEventListener('click', function () {
            const id = this.getAttribute('data-id');
            const link = `http://localhost:8000/depoimento/form/${id}`;
            document.getElementById('generated-link').textContent = link;
            const modal = new bootstrap.Modal(document.getElementById('linkModal'));
            modal.show();
            console.log('Modal de link aberto para projeto ID:', id);
        });
    });

    // Enviar E-mails
    document.getElementById('sendEmails').addEventListener('click', function () {
        const emails = document.getElementById('emails').value;
        const link = document.getElementById('generated-link').textContent;
        console.log('Enviando link', link, 'para:', emails);
        document.querySelector('#linkModal .close-btn').click();
    });

    // Exportar Depoimentos
    document.querySelector('.export-btn').addEventListener('click', function () {
        console.log('Exportando depoimentos para CSV');
    });

    // Lembretes Automáticos
    document.getElementById('autoReminders').addEventListener('change', function () {
        console.log('Lembretes automáticos:', this.checked ? 'ativados' : 'desativados');
    });

    // Filtro de Status
    document.getElementById('status-filter').addEventListener('change', function () {
        console.log('Filtrando por status:', this.value);
    });
});