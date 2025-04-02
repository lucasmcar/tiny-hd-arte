// script.js
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('form-cadastro');
    const inputs = form.querySelectorAll('.input-field');

    // Validação em tempo real
    inputs.forEach(input => {
        input.addEventListener('input', function() {
            if (this.value.trim() === '' && this.required) {
                this.style.borderColor = '#ff0000';
            } else {
                this.style.borderColor = '#333';
            }
        });
    });

    // Validação antes do submit
    form.addEventListener('submit', function(e) {
        let isValid = true;
        inputs.forEach(input => {
            if (input.required && !input.value.trim()) {
                isValid = false;
                input.style.borderColor = '#ff0000';
            }
        });

        if (!isValid) {
            e.preventDefault();
            alert('Por favor, preencha todos os campos obrigatórios!');
        }
    });

    // Cancelar redirecionamento
    document.querySelector('.btn-cancel').addEventListener('click', function(e) {
        e.preventDefault();
        if (confirm('Tem certeza que deseja cancelar?')) {
            window.location.href = '/clientes';
        }
    });
});