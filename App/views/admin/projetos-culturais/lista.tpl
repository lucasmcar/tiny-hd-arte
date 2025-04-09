<div class="projetos-container">
    <h2>{{ $title }}</h2>
    <div class="project-list">
        {% if empty($data['projetos']) %}
            <p class="no-projects">Nenhum projeto cadastrado.</p>
        {% else %}
            <table class="project-table">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Público-Alvo</th>
                        <th>Orçamento (R$)</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    {% foreach $projetos as $index => $projeto %}
                        <tr>
                            <td>{{ htmlspecialchars($projeto['nome']) }}</td>
                            <td>{{ htmlspecialchars($projeto['publico_alvo']) }}</td>
                            <td>{{ number_format($projeto['orcamento_estimado'], 2, ',', '.') }}</td>
                            <td>{{ htmlspecialchars(ucfirst(str_replace('_', ' ', $projeto['status']))) }}</td>
                            <td>
                                <a data-url="/admin/projetos-culturais/projectDetails?id={{ $projeto['id'] }}" class="view-details-btn">Ver Detalhes</a>
                            </td>
                        </tr>
                    {% endforeach; %}
                </tbody>
            </table>
        {% endif; %}
        <a data-url="/admin/projetos-culturais" class="back-button">Voltar para Cadastro</a>
    </div>
</div>