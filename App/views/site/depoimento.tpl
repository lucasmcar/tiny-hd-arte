<style>
body {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    padding-top: 80px;
}
.content {
    flex: 1;
}
footer {
    margin-top: auto;
}

.carousel-control-prev-icon,
.carousel-control-next-icon {
    background-color: #fff;
    border-radius: 50%;
}

.carousel-item {
    display: flex;
    justify-content: center;
    align-items: center;
}
.card {
    background: #222;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(255, 255, 255, 0.1);
    max-width: 400px;
    margin: auto;
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
    color: #e0e0e0;
}
.author {
    font-size: 12px;
    font-weight: bold;
    color: #bbb;
}
</style>


<div class="content">
    <div class="container mt-5">
        <h2 class="mb-4">Depoimentos</h2>
        <div id="testimonialCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                {% foreach $depoimentos as $index => $depoimento %}
                    <div class="carousel-item <?php echo $index === 0 ? 'active' : ''; ?>">
                        <div class="card text-center p-4">
                            <img src="{{ $depoimento['foto'] }}" alt="{{ $depoimento['nome'] }}" class="rounded-circle mb-3">
                            <p class="text">"{{ $depoimento['texto'] }}"</p>
                            <p class="author fw-bold">{{ $depoimento['nome']; }} - {{ $depoimento['profissao'] }}</p>
                        </div>
                    </div>
                {% endforeach; %}
            </div>
            <!-- Botões de navegação -->
            <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon bg-dark" aria-hidden="true"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon bg-dark" aria-hidden="true"></span>
            </button>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    var carouselElement = document.querySelector('#testimonialCarousel');
    var carousel = new bootstrap.Carousel(carouselElement, {
        interval: 3000,
        ride: 'carousel'
    });
});
</script>