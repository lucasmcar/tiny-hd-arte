<!-- CSS adaptado para o estilo hda -->
<style>
body {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    padding-top: 80px; /* Mantido para evitar sobreposição com navbar */
    background: #141414; /* Fundo escuro hda */
    color: #fff;
    font-family: 'Montserrat', sans-serif;
}

.content {
    flex: 1;
}

footer {
    margin-top: auto;
}

.hda-section {
    padding: 40px 0;
}

.hda-title {
    font-size: 2rem;
    font-weight: 600;
    margin-bottom: 20px;
    text-align: center;
    color: #fff;
}

.carousel-inner {
    overflow: hidden;
}

.carousel-item {
    display: none;
    transition: transform 0.6s ease, opacity 0.6s ease; /* Transição suave mantida */
}

.carousel-item.active {
    display: flex; /* Mantido para exibir o item ativo */
}

.carousel-control-prev-icon,
.carousel-control-next-icon {
    background-color: rgba(0, 0, 0, 0.8); /* Fundo escuro no estilo hda */
    border-radius: 50%;
    width: 40px;
    height: 40px;
}

.card {
    background: #222; /* Cinza escuro hda */
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5); /* Sombra escura */
    max-width: 400px;
    margin: auto;
    max-height: 100%;
    overflow: hidden;
    width: 100%;
    height: 100%;
    transition: transform 0.3s; /* Efeito de hover */
}

.card:hover {
    transform: scale(1.05); /* Aumento ao passar o mouse, estilo hda */
}

.card img {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 15px;
}

.text {
    font-size: 14px;
    margin-bottom: 10px;
    color: #e0e0e0; /* Cinza claro para o texto */
    font-style: italic;
}

.author {
    font-size: 12px;
    font-weight: bold;
    color: #fff; /* Branco para destacar o autor */
}
</style>

<!-- HTML para Depoimentos -->
<div class="content">
    <div class="container hda-section">
        <h2 class="hda-title mb-4">Depoimentos</h2>
        <div id="testimonialCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                {% foreach $depoimentos as $index => $item %}
                    <div class="carousel-item {{ $index == 0 ? 'active' : '' }}">
                        <div class="card text-center p-4">
                            <img src="{{ $item['foto'] }}" alt="{{ $item['nome'] }}" class="rounded-circle mb-3">
                            <p class="text">"{{ $item['depoimento'] }}"</p>
                            <p class="author fw-bold">{{ $item['nome'] }} - {{ $item['profissao'] }}</p>
                        </div>
                    </div>
                {% endforeach; %}
            </div>
            <!-- Botões de navegação -->
            <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
</div>

<!-- JavaScript para o carrossel -->
<script>
document.addEventListener('DOMContentLoaded', function () {
    var carouselElement = document.querySelector('#testimonialCarousel');
    var carousel = new bootstrap.Carousel(carouselElement, {
        interval: 3000 // Rotação a cada 3 segundos
    });
});
</script>