<!--<section class="container hda-section">
    <h1 class="hda-title">Projetos e Eventos Realizados</h1>
    <p class="hda-text">Conheça os principais eventos organizados pela HD Arte Produções e Eventos.</p>

    
    <?php if (!empty($featured_projects)): ?>
        <h2 class="section-title">Em Destaque</h2>
        <div class="row mb-5">
            <?php foreach ($featured_projects as $project): ?>
                <div class="col-md-4 mb-4">
                    <div class="project-card">
                        <?php if (!empty($project['video'])): ?>
                            <video class="project-media" muted loop playsinline>
                                <source src="<?= $project['video'] ?>" type="video/mp4">
                                Seu navegador não suporta vídeo.
                            </video>
                        <?php else: ?>
                            <img src="<?= $project['image'] ?>" alt="<?= htmlspecialchars($project['title']) ?>" class="project-media">
                        <?php endif; ?>
                        <div class="card-body">
                            <h5 class="card-title"><?= htmlspecialchars($project['title']) ?></h5>
                            <p class="card-text"><?= htmlspecialchars($project['short_description']) ?></p>
                            <a href="/projetos/<?= $project['slug'] ?>" class="btn btn-hda">Saiba Mais</a>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>

    
    <h2 class="section-title">Galeria de Projetos</h2>
    <div class="row">
        <?php foreach ($all_projects as $project): ?>
            <div class="col-md-4 mb-4">
                <div class="project-card">
                    <?php if (!empty($project['video'])): ?>
                        <video class="project-media" muted loop playsinline>
                            <source src="<?= $project['video'] ?>" type="video/mp4">
                            Seu navegador não suporta vídeo.
                        </video>
                    <?php else: ?>
                        <img src="<?= $project['image'] ?>" alt="<?= htmlspecialchars($project['title']) ?>" class="project-media">
                    <?php endif; ?>
                    <div class="card-body">
                        <h5 class="card-title"><?= htmlspecialchars($project['title']) ?></h5>
                        <p class="card-text"><?= htmlspecialchars($project['short_description']) ?></p>
                        <a href="/projetos/<?= $project['slug'] ?>" class="btn btn-hda">Saiba Mais</a>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</section>-->

<!-- views/projects/index.php -->
<section class="container hda-section">
    <h1 class="hda-title">{{ $title }} </h1>
    <p class="hda-text">Conheça os principais eventos organizados pela HD Arte Produções e Eventos.</p>

    <!-- Seção de Destaque -->
    {% if $featured_projects %} 
        <h2 class="section-title">Em Destaque</h2>
        <div class="project-grid mb-5">
            {% foreach $featured_projects as $index => $project %}
                <div class="project-card">
                    {% if $project['video'] %}
                        <video class="project-media" muted loop playsinline>
                            <source src="{{ $project['video'] }}" type="video/mp4">
                            Seu navegador não suporta vídeo.
                        </video>
                    {% else %}
                        <img src="{{ $project['image'] }}" alt="{{ $project['title'] }}" class="project-media">
                    {% endif; %}
                    <div class="card-body">
                        <h5 class="card-title"> {{ $project['title'] }} </h5>
                        <p class="card-text">{{ $project['short_description'] }}</p>
                        <a href="/projetos/{{ $project['slug'] }}" class="btn btn-hda">Saiba Mais</a>
                    </div>
                </div>
            {% endforeach; %}
        </div>
    {% endif; %}

    <!-- Todos os Projetos -->
    <h2 class="section-title">Galeria de Projetos</h2>
    {% if $all_projects == null %}
        <p class="hda-text">Nenhum projeto encontrado nesta categoria no momento.</p>
    {% else %}
        <div class="project-grid">
            {% foreach $all_projects as $index => $project %}
                <div class="project-card">
                    {% if $project['video'] %}
                        <video class="project-media" muted loop playsinline>
                            <source src="{{ $project['video'] }}" type="video/mp4">
                            Seu navegador não suporta vídeo.
                        </video>
                     {% else %}
                        <img src="{{ $project['image'] }}" alt="{{ $project['title'] }}" class="project-media">
                    {% endif; %}
                    <div class="card-body">
                        <h5 class="card-title">{{ $project['title'] }}</h5>
                        <p class="card-text">{{ $project['short_description'] }}</p>
                        <a href="/projetos/{{ $project['slug'] }}" class="btn btn-hda">Saiba Mais</a>
                    </div>
                </div>
            {% endforeach; %}
        </div>
    {% endif; %}
</section>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const videoCards = document.querySelectorAll('.project-card video');

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
</script>