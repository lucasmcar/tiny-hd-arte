document.addEventListener('DOMContentLoaded', function () {
    const artistForm = document.getElementById('artistForm');
    const successMessage = document.getElementById('successMessage');

    if (artistForm) {
        artistForm.addEventListener('submit', function (e) {
            e.preventDefault();

            const formData = new FormData(artistForm);

            fetch('/admin/agenciamento-artistas/salvarArtista', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    successMessage.textContent = data.success;
                    successMessage.style.display = 'block';
                    artistForm.reset();
                    setTimeout(() => {
                        successMessage.style.display = 'none';
                    }, 3000);
                } else {
                    alert(data.error || 'Erro ao cadastrar artista.');
                }
            })
            .catch(error => {
                console.error('Erro:', error);
                alert('Erro ao cadastrar artista.');
            });
        });
    }
});