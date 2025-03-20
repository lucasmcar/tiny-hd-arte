<style>
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

.testimonial-container {
    max-width: 800px;
    margin: 40px auto; /* Ajustado para consistência com outras seções */
    padding: 30px;
    background: #222; /* Cinza escuro hda */
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5); /* Sombra sutil */
}

.hda-title {
    font-size: 2.5rem;
    font-weight: 600;
    color: #fff;
    margin-bottom: 20px;
    text-align: center;
}

.hda-text {
    font-size: 1.1rem;
    color: #e0e0e0;
    margin-bottom: 30px;
    text-align: center;
}

.hda-form {
    max-width: 600px;
    margin: 0 auto;
}

.hda-input {
    background: #333;
    color: #fff;
    border: 2px solid transparent;
    padding: 12px;
    font-size: 1rem;
    border-radius: 5px;
    transition: border-color 0.3s ease, box-shadow 0.3s ease, background 0.3s ease;
    width: 100%;
}

.hda-input:focus {
    background: #222;
    border-color: #e50914; /* Vermelho hda */
    box-shadow: 0 0 8px rgba(229, 9, 20, 0.8);
    outline: none;
}

.hda-input::placeholder {
    color: #999; /* Cinza claro para placeholders */
}

.btn-hda {
    background-color: #e50914; /* Vermelho hda */
    color: #fff;
    border: none;
    padding: 12px;
    font-size: 1rem;
    font-weight: 600;
    border-radius: 5px;
    transition: background-color 0.3s ease;
    width: 100%;
    text-transform: uppercase; /* Para um toque mais hda */
}

.btn-hda:hover {
    background-color: #b20710; /* Vermelho mais escuro no hover */
}

/* Ajustes para responsividade */
@media (max-width: 768px) {
    .testimonial-container {
        margin: 20px;
        padding: 20px;
    }

    .hda-title {
        font-size: 2rem;
    }

    .hda-text {
        font-size: 1rem;
    }
}
</style>

<!-- views/testimonials/create.php -->
<section class="container hda-section">
    <div class="testimonial-container text-center">
        <h1 class="hda-title">Deixe seu Depoimento</h1>
        <p class="hda-text">Compartilhe sua experiência conosco preenchendo o formulário abaixo.</p>

        <?php if (isset($_GET['success'])): ?>
            <p class="hda-text text-success">Depoimento enviado com sucesso! Aguardando aprovação.</p>
        <?php endif; ?>

        <form action="/depoimentos/criar" method="POST" class="hda-form">
            <div class="mb-3">
                <input type="text" class="form-control hda-input" name="nome" placeholder="Seu Nome" required>
            </div>
            <div class="mb-3">
                <input type="text" class="form-control hda-input" name="titulo" placeholder="Título do Depoimento" required>
            </div>
            <div class="mb-3">
                <input type="text" class="form-control hda-input" name="profissao" placeholder="Sua Profissão" required>
            </div>
            <div class="mb-3">
                <textarea class="form-control hda-input" name="depoimento" rows="4" placeholder="Seu Depoimento" required></textarea>
            </div>
            <button type="submit" class="btn btn-hda w-100">Enviar Depoimento</button>
        </form>
    </div>
</section>