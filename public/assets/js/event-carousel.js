document.addEventListener('DOMContentLoaded', function () {
    // Interatividade para o carrossel de atrações
    const attractionsCarousel = document.querySelector('#attractionsCarousel');
    const highlightImage = document.querySelector('#highlight-image');
    const highlightButton = document.querySelector('#highlight-button');
    const modalTitle = document.querySelector('#modalAttractionTitle');
    const modalDescription = document.querySelector('#modalAttractionDescription');

    attractionsCarousel.addEventListener('slid.bs.carousel', function (event) {
        const activeItem = event.relatedTarget;
        const imageSrc = activeItem.querySelector('.attraction-img').src;
        const title = activeItem.getAttribute('data-title');
        const description = activeItem.getAttribute('data-description');

        highlightImage.src = imageSrc;
        modalTitle.textContent = title;
        modalDescription.textContent = description;
    });

    document.querySelectorAll('.attraction-img').forEach(img => {
        img.addEventListener('click', function () {
            const parentItem = this.closest('.carousel-item');
            const title = parentItem.getAttribute('data-title');
            const description = parentItem.getAttribute('data-description');
            modalTitle.textContent = title;
            modalDescription.textContent = description;
            highlightImage.src = this.src;
            highlightButton.click();
        });
    });

    // Impede que o carrossel de patrocinadores afete a imagem em destaque
    const sponsorsCarousel = document.querySelector('#sponsorsCarousel');
    if (sponsorsCarousel) {
        sponsorsCarousel.addEventListener('slid.bs.carousel', function (event) {
            event.stopPropagation();
        });
    }

    // Interatividade para vídeos nos cards de shows
    const videoCards = document.querySelectorAll('.shows-section .project-card video');
    videoCards.forEach(video => {
        video.addEventListener('mouseenter', () => {
            video.play();
        });
        video.addEventListener('mouseleave', () => {
            video.pause();
            video.currentTime = 0; // Volta ao início
        });
    });
});