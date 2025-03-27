<section class="logs-section">
    <div class="container">
        <h1 class="hda-title">Logs de Alterações</h1>

        <!-- Filtro -->
        <div class="filter-block mt-4">
            <label for="log-filter" class="filter-label">Filtrar Logs:</label>
            <input type="text" id="log-filter" class="filter-input" value="{{ htmlspecialchars($filter) }}" placeholder="Digite para filtrar por ação ou detalhes">
            <!-- Alternativa com select (descomente se preferir) -->
            <!--
            <select id="log-filter" class="filter-select">
                <option value="">Todos</option>
                <option value="accepted">Aceitos</option>
                <option value="rejected">Rejeitados</option>
                <option value="notification_enabled">Notificação Ativada</option>
                <option value="notification_disabled">Notificação Desativada</option>
                <option value="link_generated">Link Gerado</option>
            </select>
            -->
        </div>

        <!-- Ações -->
        <div class="actions-block mt-3">
            <button class="action-btn export-btn" id="exportPdf">Exportar PDF</button>
            <button class="action-btn clear-btn" id="clearLogs">Limpar Selecionados</button>
            <span class="status-message" id="statusMessage"></span>
        </div>

        <!-- Lista de Logs -->
        <div class="logs-list mt-4">
            {% if !empty($logs) %}
                <table class="logs-table">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="selectAll"></th>
                            <th>Data</th>
                            <th>Ação</th>
                            <th>ID do Depoimento</th>
                            <th>Detalhes</th>
                        </tr>
                    </thead>
                    <tbody>
                        {% foreach $logs as $index => $log %}
                            <tr>
                                <td><input type="checkbox" class="log-checkbox" value="{{ $log['id'] }}"></td>
                                <td>{{ date('d/m/Y H:i', strtotime($log['created_at'])) }}</td>
                                <td>{{ htmlspecialchars($log['action']) }}</td>
                                <td>{{ $log['testimony_id'] ?? 'N/A' }}</td>
                                <td>{{ htmlspecialchars($log['details'] ?? '-') }}</td>
                            </tr>
                        {% endforeach; %}
                    </tbody>
                </table>
            {% else  %}
                <p class="no-logs">Nenhum log encontrado.</p>
            {% endif; %}
        </div>
    </div>
    <script>
        window.allLogs = {{ json_encode($logs) }}
    </script>
</section>