<style>

.carousel-item {
            text-align: center; /* Centraliza o conteúdo */
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
        }
        .author {
            font-size: 12px;
            font-weight: bold;
            color: #bbb;
        }

</style>


<?php
    $testimonials = [
    ["nome" => "Ana Souza", "profissao" => "Designer", "foto" => "ana.jpg", "texto" => "Ótimo serviço! Recomendo a todos."],
    ["nome" => "Carlos Lima", "profissao" => "Desenvolvedor", "foto" => "carlos.jpg", "texto" => "Equipe muito profissional e atenciosa."],
    ["nome" => "Mariana Santos", "profissao" => "Gerente de Projetos", "foto" => "mariana.jpg", "texto" => "Uma experiência incrível, superou minhas expectativas!"],
    ["nome" => "Roberto Alves", "profissao" => "Empresário", "foto" => "roberto.jpg", "texto" => "Serviço de alta qualidade e atendimento nota 10!"]
];
?>

<div class="container mt-5">
    <h2 class="mb-4">Depoimentos</h2>
    <div id="testimonialCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <?php foreach ($testimonials as $index => $depoimento): ?>
                <div class="carousel-item <?php echo $index === 0 ? 'active' : ''; ?>">
                    <div class="card">
                        <img src="images/<?php echo $depoimento['foto']; ?>" alt="<?php echo $depoimento['nome']; ?>">
                        <p class="text">"<?php echo $depoimento['texto']; ?>"</p>
                        <p class="author"><?php echo $depoimento['nome']; ?> - <?php echo $depoimento['profissao']; ?></p>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
        </button>
    </div>
</div>


<script>
    document.addEventListener("DOMContentLoaded", () => {
    const slider = document.querySelector(".testimonials");
    const prev = document.getElementById("prev");
    const next = document.getElementById("next");
    
    let index = 0;
    const cardWidth = document.querySelector(".card").offsetWidth + 15;
    const maxIndex = slider.children.length - 1;
    
    next.addEventListener("click", () => {
        if (index < maxIndex) {
            index++;
            slider.style.transform = `translateX(-${index * cardWidth}px)`;
        }
    });
    
    prev.addEventListener("click", () => {
        if (index > 0) {
            index--;
            slider.style.transform = `translateX(-${index * cardWidth}px)`;
        }
    });
});
</script>