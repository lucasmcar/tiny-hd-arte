document.addEventListener('DOMContentLoaded', function() {
    const eventForm = document.getElementById('eventForm');
    const successMessage = document.getElementById('successMessage');

    if (eventForm) {
        eventForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(eventForm);

            fetch('/admin/eventos-culturais/saveEvent', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    successMessage.textContent = data.success;
                    successMessage.style.display = 'block';
                    eventForm.reset();
                    setTimeout(() => {
                        successMessage.style.display = 'none';
                    }, 3000);
                } else {
                    successMessage.textContent = data.error || 'Erro ao salvar o evento.';
                    successMessage.style.display = 'block';
                    setTimeout(() => {
                        successMessage.style.display = 'none';
                    }, 3000);
                }
            })
            .catch(error => {
                console.error('Erro ao salvar o evento:', error);
                successMessage.textContent = 'Erro ao salvar o evento.';
                successMessage.style.display = 'block';
                setTimeout(() => {
                    successMessage.style.display = 'none';
                }, 3000);
            });
        });
    }
});