<section class="container hda-section">
    <h1 class="hda-title">{{ $title }}</h1>

    {% if !empty($all_projects) %}
        <div class="row">
            {% foreach $all_projects as $index => $project %}
                <div class="col-md-4 mb-4">
                    <div class="project-card">
                        <img src="{{ $project['image'] }}" alt="{{ htmlspecialchars(project['title']) }}" class="img-fluid img-destaque rounded mb-2">
                        <div class="article-meta">
                            <p>Por <span class="author">{{ $project['author'] }}</span> | Publicado em <time datetime="{{ $project['post_date'] }}">{{ date('d/m/Y', strtotime($project['post_date'])) }}</time></p>
                        </div>
                        <p class="hda-text">{{ htmlspecialchars($project['short_description']) }}</p>
                        <a href="/projetos/{{ $project['slug'] }}" class="btn btn-hda">Ver Detalhes</a>
                    </div>
                </div>
            {% endforeach; %}
        </div>
    {% else %}
        <p class="hda-text">Nenhum projeto ocorrido encontrado.</p>
    {% endif; %}
</section>