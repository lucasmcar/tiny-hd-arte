document.addEventListener('DOMContentLoaded', function() {
    const projectForm = document.getElementById('projectForm');
    const successMessage = document.getElementById('successMessage');

    if (projectForm) {
        projectForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(projectForm);

            fetch('/admin/projetos-culturais/saveProject', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    successMessage.textContent = data.success;
                    successMessage.style.display = 'block';
                    projectForm.reset();
                    setTimeout(() => {
                        successMessage.style.display = 'none';
                    }, 3000);
                } else {
                    successMessage.textContent = data.error || 'Erro ao salvar o projeto.';
                    successMessage.style.display = 'block';
                    setTimeout(() => {
                        successMessage.style.display = 'none';
                    }, 3000);
                }
            })
            .catch(error => {
                console.error('Erro ao salvar o projeto:', error);
                successMessage.textContent = 'Erro ao salvar o projeto.';
                successMessage.style.display = 'block';
                setTimeout(() => {
                    successMessage.style.display = 'none';
                }, 3000);
            });
        });
    }
});