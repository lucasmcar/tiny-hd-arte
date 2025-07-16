document.addEventListener('DOMContentLoaded', () => {
    const images = document.querySelectorAll('.thumbnail-img, .thumbnail-img-small');
    const overlay = document.createElement('div');
    const overlayImage = document.createElement('img');
    const backBtn = document.getElementById('backBtn');

    // Configurar o overlay
    overlay.classList.add('image-overlay');
    overlayImage.classList.add('overlay-image');
    overlay.appendChild(overlayImage);
    document.body.appendChild(overlay);

    // Adicionar evento de clique nas imagens
    images.forEach(image => {
        image.addEventListener('click', () => {
            overlayImage.src = image.src;
            overlay.style.display = 'flex';
        });
    });

    // Fechar o overlay ao clicar fora
    overlay.addEventListener('click', (e) => {
        if (e.target === overlay) {
            overlay.style.display = 'none';
        }
    });

    // Manter a funcionalidade do botão Voltar
    backBtn.addEventListener('click', () => {
        window.location.href = '/em-captacao';
    });
});