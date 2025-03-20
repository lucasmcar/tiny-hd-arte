<!--<section class="container hda-section">
    <h2 class="hda-title"><?= htmlspecialchars($project['title']) ?></h2>
    <div class="row">
        <div class="col-md-6">
            <img src="<?= $project['image'] ?>" alt="<?= htmlspecialchars($project['title']) ?>" class="img-fluid rounded">
        </div>
        <div class="col-md-6">
            <p class="hda-text"><?= htmlspecialchars($project['description']) ?></p>
            <p class="hda-text"><?= htmlspecialchars($project['details']) ?></p>
            <a href="/" class="btn btn-hda">Voltar à Home</a>
        </div>
    </div>
</section>-->
<section class="container hda-section">
    <h1 class="hda-title"><?= htmlspecialchars($project['title']) ?></h1>
    <div class="article-meta">
        <p>Por <span class="author"><?= htmlspecialchars($project['author']) ?></span> | Publicado em <time datetime="<?= $project['post_date'] ?>"><?= date('d/m/Y', strtotime($project['post_date'])) ?></time></p>
    </div>

    <div class="row">
        <div class="col-md-8">
            <img src="<?= $project['image'] ?>" alt="<?= htmlspecialchars($project['title']) ?>" class="img-fluid rounded mb-4">
            <p class="hda-text"><?= htmlspecialchars($project['description']) ?></p>
            <p class="hda-text"><?= htmlspecialchars($project['details']) ?></p>
            <div class="article-content">
                <p><?= nl2br(htmlspecialchars($project['content'])) ?></p>
            </div>
        </div>
        <div class="col-md-4">
            <img src="<?= $project['extra_image'] ?>" alt="Imagem adicional de <?= htmlspecialchars($project['title']) ?>" class="img-fluid rounded mb-4">
            <a href="/" class="btn btn-hda">Voltar à Home</a>
        </div>
    </div>
</section>