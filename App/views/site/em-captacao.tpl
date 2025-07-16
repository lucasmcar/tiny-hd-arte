@csrf
<div class="container-fluid mt-4 projects-section" aria-label="Seção de Projetos em Captação">
    <div class="header-info" role="banner">
        <h1 class="hda-title">Projetos em Captação de Recursos – Lei Federal de Incentivo à Cultura</h1>
    </div>

    <div class="config-section table-section" role="region" aria-labelledby="projects-table-title">
        <h3 class="section-title" id="projects-table-title">Lista de Projetos</h3>
        <div class="table-container">
            <table class="projects-table" aria-live="polite">
                <thead>
                    <tr>
                        <th scope="col">PRONAC</th>
                        <th scope="col">Nome do Projeto</th>
                        <th scope="col">Portaria de Aprovação</th>
                    </tr>
                </thead>
                <tbody>
                    {% foreach $all_projects as $index => $project %}
                        <tr>
                            <td>{{ $project['pronac'] }}</td>
                            <td><a href="/projeto/projeto-detalhes/{{ $project['slug'] }}" class="project-link">{{ $project['title'] }}</a></td>
                            <td>{{ $project['post_date'] ? 'Nº  ~ ' .date('Y/m/d', strtotime($project['post_date'])) : 'Não disponível' }}</td>
                        </tr>
                    {% endforeach; %}
                </tbody>
            </table>
        </div>
    </div>
</div>