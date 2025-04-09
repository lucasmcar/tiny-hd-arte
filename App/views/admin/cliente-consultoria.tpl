<div class="consultoria-container">
    <h2>{{ $title }} - {{ htmlspecialchars($cliente['nome']) }}</h2>
    <div class="client-profile">
        <div class="profile-section">
            <h3>Dados do Cliente</h3>
            <p><strong>Nome:</strong> {{ htmlspecialchars($cliente['nome']) }}</p>
            <p><strong>Tipo de Cliente:</strong> {{ htmlspecialchars($cliente['tipo_cliente']) }}</p>
            <p><strong>Contato:</strong> {{ htmlspecialchars($cliente['contato']) }}</p>
            <p><strong>Objetivos Culturais:</strong> {{ htmlspecialchars($cliente['objetivos']) }}</p>
        </div>

        <div class="profile-section">
            <h3>Demandas Específicas</h3>
            <p><strong>Demanda:</strong> {{ htmlspecialchars($cliente['demandas']) }}</p>
        </div>

        <div class="profile-section">
            <h3>Documentos Enviados</h3>
            {% if empty($cliente['documentos']) %}
                <p>Nenhum documento enviado.</p>
            {% else %}
                <ul class="document-list">
                    {% foreach $cliente['documentos'] as $index => $documento %}
                        <li>
                            <a href="/{{ htmlspecialchars($documento) }}" target="_blank" class="document-link">
                                {{ htmlspecialchars(basename($documento)) }}
                            </a>
                        </li>
                    {% endforeach; %}
                </ul>
            {% endif; %}
        </div>

        <a data-url="/admin/consultoria/listClients" class="back-button">Voltar para Lista</a>
    </div>
</div>