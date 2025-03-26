function sendEmail() {
    const form = document.getElementById('contactForm');
    const submitBtn = document.getElementById('submitBtn');
    const loadingSpinner = document.getElementById('loadingSpinner');
    const modal = document.getElementById('feedbackModal');
    const modalMessage = document.getElementById('modalMessage');
    const closeModalBtn = modal.querySelector('.netflix-modal-close');
    const footerCloseBtn = modal.querySelector('.netflix-btn');

    form.addEventListener('submit', function (e) {
        e.preventDefault();

        // Mostra o loading e desativa o botão
        submitBtn.disabled = true;
        loadingSpinner.style.display = 'inline-block';

        // Coleta os dados do formulário
        const formData = new FormData(form);

        // Envia a requisição AJAX
        fetch('/contato/email', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            // Esconde o loading e reativa o botão
            loadingSpinner.style.display = 'none';
            submitBtn.disabled = false;

            // Configura a mensagem do modal
            if (data.success) {
                modalMessage.innerHTML = 'E-mail enviado com sucesso! Entraremos em contato em breve.';
                modalMessage.className = 'netflix-modal-body text-success';
                form.reset();
            } else {
                modalMessage.innerHTML = 'Erro ao enviar o e-mail. Tente novamente mais tarde.';
                modalMessage.className = 'netflix-modal-body text-danger';
            }

            // Exibe o modal
            modal.classList.add('show');
        })
        .catch(error => {
            // Esconde o loading e reativa o botão
            loadingSpinner.style.display = 'none';
            submitBtn.disabled = false;

            // Exibe erro no modal
            modalMessage.innerHTML = 'Erro inesperado. Verifique sua conexão e tente novamente.';
            modalMessage.className = 'netflix-modal-body text-danger';
            modal.classList.add('show');

            console.error('Erro:', error);
        });
    });
    // Fecha o modal ao clicar no "X" ou no botão "Fechar"
    closeModalBtn.addEventListener('click', function () {
        modal.classList.remove('show');
    });

    footerCloseBtn.addEventListener('click', function () {
        modal.classList.remove('show');
    });

    // Fecha o modal ao clicar fora dele
    modal.addEventListener('click', function (e) {
        if (e.target === modal) {
            modal.classList.remove('show');
        }
    });
}

sendEmail();