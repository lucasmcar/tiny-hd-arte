<section class="logs-section">
    <div class="container">
        <h1 class="hda-title">{{ $title }}</h1>

        <!-- Filtro -->
        <form method="get" action='/admin/configuracoes/list-logs'>
            <div class="filter-block mt-4">
            <label for="log-filter" class="filter-label">Filtrar Logs:</label>
            <input type="text" id="log-filter" class="filter-input" value="{{ htmlspecialchars($filter) }}" placeholder="Digite para filtrar por ação, tabela ou detalhes">
        </div>
        </form>

        <!-- Ações -->
        <div class="actions-block mt-3">
            <button class="action-btn export-btn" id="exportPdf">Exportar PDF</button>
            <button class="action-btn clear-btn" id="clearLogs">Limpar Selecionados</button>
            <span class="status-message" id="statusMessage"></span>
        </div>

        <!-- Lista de Logs -->
        <div class="logs-list mt-4">
            <table class="logs-table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAll"></th>
                        <th>Data</th>
                        <th>Ação</th>
                        <th>Tabela</th>
                        <th>ID Registro</th>
                        <th>Detalhes</th>
                    </tr>
                </thead>
                <tbody id="logs-tbody">
                    {% if !empty($logs) %}
                        {% foreach $logs as $index => $log %}
                            <tr>
                                <td><input type="checkbox" class="log-checkbox" value="{{ $log['id'] }}"></td>
                                <td>{{ date('d/m/Y H:i', strtotime($log['data_acao'])) }}</td>
                                <td>{{ htmlspecialchars($log['acao']) }}</td>
                                <td>{{ htmlspecialchars($log['tabela_afetada']) }}</td>
                                <td>{{ $log['id_registro'] ?? 'N/A' }}</td>
                                <td>
                                    { var $details = $log['detalhes'] ? json_decode($log['detalhes'], true) : [] }
                                    {{ htmlspecialchars($details['titulo'] ?? $details['name'] ?? $details['status_antigo'] ?? '-') }}
                                </td>
                            </tr>
                        {% endforeach; %}
                    {% else %}
                        <tr><td colspan="6">Nenhum log encontrado.</td></tr>
                    {% endif; %}
                </tbody>
            </table>
            <p class="no-logs" id="no-logs" style="display: {% if !empty($logs) %}none{% else %}block{% endif; %};">Nenhum log encontrado.</p>
        </div>
    </div>
</section>