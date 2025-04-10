<div class="eventos-container">
    <h2>{{ $title }} - {{ htmlspecialchars($evento['nome']) }}</h2>
    <div class="event-details">
        <!-- Dados do Evento -->
        <div class="details-section">
            <h3>Dados do Evento</h3>
            <p><strong>Nome:</strong> {{ htmlspecialchars($evento['nome']) }}</p>
            <p><strong>Data:</strong> {{ htmlspecialchars($evento['data']) }}</p>
            <p><strong>Local:</strong> {{ htmlspecialchars($evento['local']) }}</p>
            <p><strong>Descrição:</strong> {{ htmlspecialchars($evento['descricao']) }}</p>
            <p><strong>Artistas Envolvidos:</strong> {{ htmlspecialchars($evento['artistas']) }}</p>
            <p><strong>Orçamento Estimado (R$):</strong> {{ number_format($evento['orcamento'], 2, ',', '.') }}</p>
        </div>

        <!-- Editais (3.1.1) -->
        <div class="details-section">
            <h3>Editais Enviados</h3>
            {% if empty($data['evento']['editais']) %}
                <p>Nenhum edital enviado.</p>
            {% else %} 
                <ul class="edital-list">
                    {% foreach $evento['editais'] as $index => $edital %}
                        <li>
                            <a href="/{{ htmlspecialchars($edital) }}" target="_blank" class="edital-link">
                                {{ htmlspecialchars(basename($edital)) }}
                            </a>
                        </li>
                    {% endforeach; %}
                </ul>
            {% endif; %}
        </div>

        <!-- Tarefas de Produção (3.2) -->
        <div class="details-section">
            <h3>Tarefas de Produção</h3>
            {% if (empty($data['evento']['tarefas'])): %}
                <p>Nenhuma tarefa cadastrada.</p>
            {% else %}
                <table class="task-table">
                    <thead>
                        <tr>
                            <th>Tipo</th>
                            <th>Detalhes</th>
                            <th>Responsável</th>
                            <th>Prazo</th>
                        </tr>
                    </thead>
                    <tbody>
                        {% foreach $evento['tarefas'] as $index => $tarefa %}
                            <tr>
                                <td>{{ htmlspecialchars($tarefa['tipo']) }}</td>
                                <td>{{ htmlspecialchars($tarefa['detalhes']) }}</td>
                                <td>{{ htmlspecialchars($tarefa['responsavel']) }}</td>
                                <td>{{ htmlspecialchars($tarefa['prazo']) }}</td>
                            </tr>
                        {% endforeach; %}
                    </tbody>
                </table>
            {% endif; %}
            <form id="taskForm">
                <input type="hidden" name="event_id" value="{{ $evento['id'] }}">
                <div class="form-group">
                    <label for="tipo">Tipo de Tarefa</label>
                    <select id="tipo" name="tipo" class="form-input" required>
                        <option value="contratacao_fornecedores">Contratação de Fornecedores</option>
                        <option value="logistica">Logística</option>
                        <option value="divulgacao">Divulgação</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="detalhes">Detalhes</label>
                    <textarea id="detalhes" name="detalhes" class="form-textarea" required></textarea>
                </div>
                <div class="form-group">
                    <label for="responsavel">Responsável</label>
                    <input type="text" id="responsavel" name="responsavel" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="prazo">Prazo</label>
                    <input type="date" id="prazo" name="prazo" class="form-input" required>
                </div>
                <button type="submit" class="save-button">Adicionar Tarefa</button>
            </form>
            <div id="taskMessage" class="success-message" style="display: none;"></div>
        </div>

        <!-- Checklist (3.3) -->
        <div class="details-section">
            <h3>Checklist do Evento</h3>
            <form id="checklistForm">
                <input type="hidden" name="event_id" value="{{ $evento['id'] ?>">
                <div id="checklistEntries">
                    {% if !empty($evento['checklist']) %}
                        {% foreach $evento['checklist'] as $index => $item %}
                            <div class="checklist-entry">
                                <input type="text" name="itens[]" class="form-input" value="{{ htmlspecialchars($item['item']) }}" required>
                                <label class="checkbox-label">
                                    <input type="checkbox" name="status[{{ $index }}]" {{ $item['concluido'] ? 'checked' : '' }}>
                                    Concluído
                                </label>
                            </div>
                        {% endforeach; %}
                    {% else %}
                        <div class="checklist-entry">
                            <input type="text" name="itens[]" class="form-input" placeholder="Item do checklist" required>
                            <label class="checkbox-label">
                                <input type="checkbox" name="status[0]">
                                Concluído
                            </label>
                        </div>
                    {% endif; %}
                </div>
                <button type="button" id="addChecklistEntry" class="add-button">Adicionar Item</button>
                <button type="submit" class="save-button">Salvar Checklist</button>
            </form>
            <div id="checklistMessage" class="success-message" style="display: none;"></div>
        </div>

        <!-- Finanças (3.4) -->
        <div class="details-section">
            <h3>Controle Financeiro</h3>
            <p><strong>Custos (R$):</strong> {{ number_format($evento['financas']['custos'], 2, ',', '.') }}</p>
            <p><strong>Receitas (R$):</strong> {{ number_format($evento['financas']['receitas'], 2, ',', '.') }}</p>
            <p><strong>Saldo (R$):</strong> {{ number_format($evento['financas']['receitas'] - $evento['financas']['custos'], 2, ',', '.') }}</p>
            <form id="financasForm">
                <input type="hidden" name="event_id" value="{{ $evento['id'] }}">
                <div class="form-group">
                    <label for="custos">Custos (R$)</label>
                    <input type="number" id="custos" name="custos" class="form-input" step="0.01" value="{{ $evento['financas']['custos'] }}" required>
                </div>
                <div class="form-group">
                    <label for="receitas">Receitas (R$)</label>
                    <input type="number" id="receitas" name="receitas" class="form-input" step="0.01" value="{{ $evento['financas']['receitas'] }}" required>
                </div>
                <button type="submit" class="save-button">Salvar Finanças</button>
            </form>
            <div id="financasMessage" class="success-message" style="display: none;"></div>
        </div>

        <a data-url="/admin/eventos-culturais/listaEventos" class="back-button">Voltar para Lista</a>
    </div>
</div>