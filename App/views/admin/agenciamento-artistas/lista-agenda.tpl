<div class="agenda-container">
    <h2>{{ htmlspecialchars($title) }}</h2>
    <div class="agenda-list">
        {% if empty($agenda) %}
            <p class="hda-text">Nenhum evento agendado no momento.</p>
        {% else %}
            <table class="agenda-table">
                <thead>
                    <tr>
                        <th>Artista</th>
                        <th>Título</th>
                        <th>Data</th>
                        <th>Local</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    {% foreach $agenda as $index => $evento %}
                        <tr>
                            <td>{{ htmlspecialchars($artists[$evento['artist_id']]['nome'])}}</td>
                            <td>{{ htmlspecialchars($evento['titulo']) }}</td>
                            <td>{{ htmlspecialchars($evento['data']) }}</td>
                            <td>{{ htmlspecialchars($evento['local']) }}</td>
                            <td>
                                <a data-url="/admin/agenciamento-artistas/detalhesEvento?id={{ $evento['id'] }}" class="view-details-btn">Ver Detalhes</a>
                            </td>
                        </tr>
                    {% endforeach; %}
                </tbody>
            </table>
        {% endif; %}
    </div>
    <a data-url="/admin/agenciamento-artistas/agenda" class="back-button">Voltar para Cadastro</a>
</div>