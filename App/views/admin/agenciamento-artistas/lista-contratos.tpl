<div class="contratos-container">
    <h2>{{ htmlspecialchars($title) }}</h2>
    <div class="contracts-list">
        {% if empty($contratos) %}
            <p class="hda-text">Nenhum contrato cadastrado no momento.</p>
        {% else %}
            <table class="contract-table">
                <thead>
                    <tr>
                        <th>Artista</th>
                        <th>Valor (R$)</th>
                        <th>Duração</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    {% foreach $contratos as $index => $contrato %}
                        <tr>
                            <td>{{ htmlspecialchars($artists[$contrato['artist_id']]['nome']) }}</td>
                            <td>{{ number_format($contrato['valor'], 2, ',', '.') }}</td>
                            <td>{{ htmlspecialchars($contrato['duracao']) }}</td>
                            <td>
                                <a data-url="/admin/agenciamento-artistas/detalhesContrato?id={{ $contrato['id'] }}" class="view-details-btn">Ver Detalhes</a>
                            </td>
                        </tr>
                    {% endforeach; %}
                </tbody>
            </table>
        {% endif; %}
    </div>
    <a data-url="/admin/agenciamento-artistas/contratos" class="back-button">Voltar para Cadastro</a>
</div>