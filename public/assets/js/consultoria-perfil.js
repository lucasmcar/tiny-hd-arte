// public/assets/js/consultoria-profile.js
document.addEventListener('DOMContentLoaded', function() {
    const backButton = document.querySelector('.back-button');
    if (backButton) {
        backButton.addEventListener('click', function(e) {
            e.preventDefault();
            loadPage('/admin/consultoria'); // Carrega a página dinamicamente
        });
    }
});