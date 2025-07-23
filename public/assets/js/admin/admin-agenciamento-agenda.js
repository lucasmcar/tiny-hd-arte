document.addEventListener('DOMContentLoaded', function () {
    const eventForm = document.getElementById('eventForm');
    const successMessage = document.getElementById('successMessage');

    if (eventForm) {
        eventForm.addEventListener('submit', function (e) {
            e.preventDefault();

            const formData = new FormData(eventForm);

            fetch('/admin/agenciamento-artistas/salvarEvento', {
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
                    alert(data.error || 'Erro ao adicionar evento à agenda.');
                }
            })
            .catch(error => {
                console.error('Erro:', error);
                alert('Erro ao adicionar evento à agenda.');
            });
        });
    }
});