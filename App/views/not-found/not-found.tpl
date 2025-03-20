<style>
/* /assets/css/404.css */
body {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    padding-top: 80px;
    background: #141414; /* Fundo escuro hda */
    color: #fff;
    font-family: 'Montserrat', sans-serif;
}

.hda-section {
    padding: 40px 0;
}

.not-found-section {
    min-height: 60vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
}

.hda-title {
    font-size: 4rem; /* Maior para impacto */
    font-weight: 700;
    color: #fff;
    margin-bottom: 20px;
    text-shadow: 0 2px 5px rgba(0, 0, 0, 0.8); /* Sombra para destaque */
}

.hda-text {
    font-size: 1.2rem;
    color: #e0e0e0;
    margin-bottom: 30px;
    max-width: 600px;
}

.btn-hda {
    background-color: #e50914; /* Vermelho hda */
    color: #fff;
    border: none;
    padding: 12px 25px;
    font-size: 1rem;
    font-weight: 600;
    border-radius: 5px;
    text-decoration: none;
    transition: background-color 0.3s ease;
    text-transform: uppercase;
}

.btn-hda:hover {
    background-color: #b20710; /* Vermelho mais escuro no hover */
}

/* Responsividade */
@media (max-width: 768px) {
    .hda-title {
        font-size: 2.5rem;
    }

    .hda-text {
        font-size: 1rem;
    }

    .btn-hda {
        padding: 10px 20px;
        font-size: 0.9rem;
    }
}
</style>

<!-- views/errors/404.php -->
<section class="container hda-section not-found-section">
    <h1 class="hda-title">404 - Página Não Encontrada</h1>
    <p class="hda-text">Parece que você se perdeu no caminho. Não se preocupe, podemos levá-lo de volta!</p>
    <div class="text-center">
        <a href="/" class="btn btn-hda">Voltar para Home</a>
    </div>
</section>