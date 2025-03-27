document.addEventListener('DOMContentLoaded', () => {
    const participantForm = document.getElementById('participantForm');
    const resetFormBtn = document.getElementById('resetForm');
    const formStatus = document.getElementById('formStatus');
    const editButtons = document.querySelectorAll('.edit-btn');

    // Submissão do formulário
    participantForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const formData = new FormData(participantForm);
        const data = Object.fromEntries(formData);

        fetch('/admin/participants/save', {
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
        participantForm.reset();
        document.getElementById('participantId').value = '';
        formStatus.textContent = '';
    });

    // Editar participante
    editButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            const id = btn.getAttribute('data-id');
            fetch(`/admin/participants/get/${id}`)
                .then(response => response.json())
                .then(result => {
                    if (result.success) {
                        const participant = result.participant;
                        document.getElementById('participantId').value = participant.id;
                        document.getElementById('participantName').value = participant.name;
                        document.getElementById('participantType').value = participant.type;
                        document.getElementById('participantContact').value = participant.contact;
                        document.getElementById('participantEvent').value = participant.event_id;
                        document.getElementById('participantDescription').value = participant.description;
                    } else {
                        formStatus.textContent = result.message;
                        setTimeout(() => formStatus.textContent = '', 3000);
                    }
                });
        });
    });
});