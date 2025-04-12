<div class="contratos-container">
    <h2>{{ htmlspecialchars($title) }}</h2>
    <div class="contract-details">
        <div class="details-section">
            <h3>Dados do Contrato</h3>
            <p><strong>Artista:</strong> {{ htmlspecialchars($artista['nome']) }}</p>
            <p><strong>Valor (R$):</strong> {{ number_format($contrato['valor'], 2, ',', '.') }}</p>
            <p><strong>Duração:</strong> {{ htmlspecialchars($contrato['duracao']) }}</p>
            <p><strong>Cláusulas:</strong> {{ nl2br(htmlspecialchars($contrato['clausulas'])) }}</p>
        </div>

        <div class="details-section">
            <h3>Assinaturas Digitais</h3>
            {% if empty($contrato['assinaturas']) %}
                <p>Nenhuma assinatura enviada.</p>
            {% else %}
                <ul class="signature-list">
                    {% foreach $contrato['assinaturas'] as $index => $assinatura %}
                        <li>
                            <a href="/{{ htmlspecialchars($assinatura) }}" target="_blank" class="signature-link">
                                {{ htmlspecialchars(basename($assinatura)) }}
                            </a>
                        </li>
                    {% endforeach; %}
                </ul>
            {% endif; %}
        </div>

        <a data-url="/admin/agenciamento-artistas/listaContratos" class="back-button">Voltar para Lista</a>
    </div>
</div>