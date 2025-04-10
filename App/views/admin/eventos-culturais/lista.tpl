<div class="eventos-container">
    <h2>{{ $title }}</h2>
    <div class="event-list">
        {% if empty($eventos) %}
            <p class="no-events">Nenhum evento cadastrado.</p>
        {% else %}
            <table class="event-table">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Data</th>
                        <th>Local</th>
                        <th>Orçamento (R$)</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    {% foreach $eventos as $index => $evento %}
                        <tr>
                            <td>{{ htmlspecialchars($evento['nome']) }}</td>
                            <td>{{ htmlspecialchars($evento['data']) }}</td>
                            <td>{{ htmlspecialchars($evento['local']) }}</td>
                            <td>{{ number_format($evento['orcamento'], 2, ',', '.') }}</td>
                            <td>
                                <a data-url="/admin/eventos-culturais/eventDetails?id={{ $evento['id'] }}" class="view-details-btn">Ver Detalhes</a>
                            </td>
                        </tr>
                    {% endforeach; %}
                </tbody>
            </table>
        {% endif; %}
        <a data-url="/admin/eventos-culturais" class="back-button">Voltar para Cadastro</a>
    </div>
</div>