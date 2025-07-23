document.addEventListener('DOMContentLoaded', function () {
    const contractForm = document.getElementById('contractForm');
    const successMessage = document.getElementById('successMessage');

    if (contractForm) {
        contractForm.addEventListener('submit', function (e) {
            e.preventDefault();

            const formData = new FormData(contractForm);

            fetch('/admin/agenciamento-artistas/salvarContrato', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    successMessage.textContent = data.success;
                    successMessage.style.display = 'block';
                    contractForm.reset();
                    setTimeout(() => {
                        successMessage.style.display = 'none';
                    }, 3000);
                } else {
                    alert(data.error || 'Erro ao cadastrar contrato.');
                }
            })
            .catch(error => {
                console.error('Erro:', error);
                alert('Erro ao cadastrar contrato.');
            });
        });
    }
});