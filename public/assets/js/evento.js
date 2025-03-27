document.addEventListener('DOMContentLoaded', () => {
    const eventForm = document.getElementById('eventForm');
    const resetFormBtn = document.getElementById('resetForm');
    const formStatus = document.getElementById('formStatus');
    const editButtons = document.querySelectorAll('.edit-btn');

    // Submissão do formulário
    eventForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const formData = new FormData(eventForm);
        const data = Object.fromEntries(formData);

        fetch('/admin/events/save', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        })
        .then(response => response.json())
        .then(result => {
            formStatus.textContent = result.message;
            if (result.success) {
                setTimeout(() => {
                    location.reload(); // Recarrega para atualizar a lista
                }, 1000);
            } else {
                setTimeout(() => formStatus.textContent = '', 3000);
            }
        });
    });

    // Limpar formulário
    resetFormBtn.addEventListener('click', () => {
        eventForm.reset();
        document.getElementById('eventId').value = '';
        formStatus.textContent = '';
    });

    // Editar evento
    editButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            const id = btn.getAttribute('data-id');
            fetch(`/admin/events/get/${id}`)
                .then(response => response.json())
                .then(result => {
                    if (result.success) {
                        const event = result.event;
                        document.getElementById('eventId').value = event.id;
                        document.getElementById('eventName').value = event.name;
                        document.getElementById('eventDate').value = event.date;
                        document.getElementById('eventLocation').value = event.location;
                        document.getElementById('eventDescription').value = event.description;
                        document.getElementById('eventType').value = event.type;
                        document.getElementById('eventTarget').value = event.target_audience;
                    } else {
                        formStatus.textContent = result.message;
                        setTimeout(() => formStatus.textContent = '', 3000);
                    }
                });
        });
    });
});