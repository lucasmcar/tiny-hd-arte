
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