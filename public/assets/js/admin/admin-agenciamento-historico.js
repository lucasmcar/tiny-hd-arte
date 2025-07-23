document.addEventListener('DOMContentLoaded', function () {
    const evaluationForm = document.getElementById('evaluationForm');
    const successMessage = document.getElementById('successMessage');

    if (evaluationForm) {
        evaluationForm.addEventListener('submit', function (e) {
            e.preventDefault();

            const formData = new FormData(evaluationForm);

            fetch('/admin/agenciamento-artistas/salvarAvaliacaoEvento', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    successMessage.textContent = data.success;
                    successMessage.style.display = 'block';
                    evaluationForm.reset();
                    setTimeout(() => {
                        successMessage.style.display = 'none';
                    }, 3000);
                } else {
                    alert(data.error || 'Erro ao salvar avaliação.');
                }
            })
            .catch(error => {
                console.error('Erro:', error);
                alert('Erro ao salvar avaliação.');
            });
        });
    }
});