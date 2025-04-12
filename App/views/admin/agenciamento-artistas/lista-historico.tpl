<div class="historico-container">
    <h2>{{ htmlspecialchars($title) }}</h2>
    <div class="historico-list">
        {% if empty($historico) %}
            <p class="hda-text">Nenhum evento avaliado no momento.</p>
        {% else %}
            <table class="historico-table">
                <thead>
                    <tr>
                        <th>Artista</th>
                        <th>Título</th>
                        <th>Data</th>
                        <th>Local</th>
                        <th>Público</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    {% foreach $historico as $index => $evento %}
                        <tr>
                            <td>{{ htmlspecialchars($artists[$evento['artist_id']]['nome']) }}</td>
                            <td>{{ htmlspecialchars($evento['titulo']) }}</td>
                            <td>{{ htmlspecialchars($evento['data']) }}</td>
                            <td>{{ htmlspecialchars($evento['local']) }}</td>
                            <td>{{ htmlspecialchars($evento['publico']) }}</td>
                            <td>
                                <a data-url="/admin/agenciamento-artistas/detalhesHistorico?id={{ $evento['id'] }}" class="view-details-btn">Ver Detalhes</a>
                            </td>
                        </tr>
                    {% endforeach; %}
                </tbody>
            </table>
        {% endif; %}
    </div>
    <a data-url="/admin/agenciamento-artistas/historico" class="back-button">Voltar para Avaliação</a>
</div>