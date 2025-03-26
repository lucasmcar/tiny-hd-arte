function initSobre() {
    const carousel = document.querySelector('#artistsCarousel');
    let scrollAmount = 0;
    const cardWidth = 265; // 250px (card) + 15px (gap)
    const visibleCards = 3;
    const totalCards = carousel.children.length;

    function scrollCarousel() {
        scrollAmount += cardWidth;
        if (scrollAmount >= cardWidth * (totalCards - visibleCards)) {
            scrollAmount = 0; // Volta ao início
        }
        carousel.scrollTo({
            left: scrollAmount,
            behavior: 'smooth'
        });
    }

    setInterval(scrollCarousel, 3000); // Rola a cada 3 segundos
}

initSobre();