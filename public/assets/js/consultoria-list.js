// public/assets/js/consultoria-list.js
document.addEventListener('DOMContentLoaded', function() {
    // Seleciona todos os links "Ver Perfil" e o botão "Voltar"
    const profileLinks = document.querySelectorAll('.view-profile-btn');
    const backButton = document.querySelector('.back-button');

    profileLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const url = this.getAttribute('href');
            loadPage(url); // Carrega a página dinamicamente
        });
    });

    if (backButton) {
        backButton.addEventListener('click', function(e) {
            e.preventDefault();
            const url = this.getAttribute('data-url');
            loadPage(url); // Carrega a página dinamicamente
        });
    }
});