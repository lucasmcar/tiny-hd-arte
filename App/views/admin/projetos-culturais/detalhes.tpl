<div class="projetos-container">
    <h2>{{ $title }} - {{ htmlspecialchars($projeto['nome']) }}</h2>
    <div class="project-details">
        <!-- Dados do Projeto -->
        <div class="details-section">
            <h3>Dados do Projeto</h3>
            <p><strong>Nome:</strong> {{ htmlspecialchars($projeto['nome']) }}</p>
            <p><strong>Descrição:</strong> {{ htmlspecialchars($projeto['descricao']) }}</p>
            <p><strong>Objetivos:</strong> {{ htmlspecialchars($projeto['objetivos']) }}</p>
            <p><strong>Público-Alvo:</strong> {{ htmlspecialchars($projeto['publico_alvo']) }}</p>
            <p><strong>Orçamento Estimado (R$):</strong> {{ number_format($projeto['orcamento_estimado'], 2, ',', '.') }}</p>
            <p><strong>Cronograma:</strong> {{ htmlspecialchars($projeto['cronograma']) }}</p>
        </div>

        <!-- Status do Projeto (2.4) -->
        <div class="details-section">
            <h3>Status do Projeto</h3>
            <p><strong>Status Atual:</strong> {{ htmlspecialchars(ucfirst(str_replace('_', ' ', $projeto['status']))) }}</p>
            <form id="statusForm">
                @csrf
                <input type="hidden" name="project_id" value="{{ $projeto['id'] }}">
                <div class="form-group">
                    <label for="status">Atualizar Status</label>
                    <select id="status" name="status" class="form-input">
                        <option value="em_elaboracao" {{ $projeto['status'] === 'em_elaboracao' ? 'selected' : '' }}>Em Elaboração</option>
                        <option value="submetido" {{ $projeto['status'] === 'submetido' ? 'selected' : '' }}>Submetido</option>
                        <option value="aprovado" {{ $projeto['status'] === 'aprovado' ? 'selected' : '' }}>Aprovado</option>
                        <option value="em_execucao" {{ $projeto['status'] === 'em_execucao' ? 'selected' : '' }}>Em Execução</option>
                        <option value="concluido" {{ $projeto['status'] === 'concluido' ? 'selected' : '' }}>Concluído</option>
                    </select>
                </div>
                <button type="submit" class="save-button">Atualizar Status</button>
            </form>
            <div id="statusMessage" class="success-message" style="display: none;"></div>
        </div>

        <!-- Planejamento Estratégico (2.2) -->
        <div class="details-section">
            <h3>Planejamento Estratégico</h3>
            {% if empty($data['projeto']['planejamento']) %}
                <p>Nenhum planejamento cadastrado.</p>
            {% else %}
                <table class="planning-table">
                    <thead>
                        <tr>
                            <th>Etapa</th>
                            <th>Responsável</th>
                            <th>Prazo</th>
                        </tr>
                    </thead>
                    <tbody>
                        {% foreach $projeto['planejamento'] as $index => $etapa %}
                            <tr>
                                <td>{{ htmlspecialchars($etapa['etapa']) }}</td>
                                <td>{{ htmlspecialchars($etapa['responsavel']) }}</td>
                                <td>{{ htmlspecialchars($etapa['prazo']) }}</td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            {% endif; %}
            <form id="planningForm">
                @csrf
                <input type="hidden" name="project_id" value="{{ $projeto['id'] }}">
                <div id="planningEntries">
                    <div class="planning-entry">
                        <div class="form-group">
                            <label>Etapa</label>
                            <input type="text" name="etapas[]" class="form-input" required>
                        </div>
                        <div class="form-group">
                            <label>Responsável</label>
                            <input type="text" name="responsaveis[]" class="form-input" required>
                        </div>
                        <div class="form-group">
                            <label>Prazo</label>
                            <input type="date" name="prazos[]" class="form-input" required>
                        </div>
                    </div>
                </div>
                <button type="button" id="addPlanningEntry" class="add-button">Adicionar Etapa</button>
                <button type="submit" class="save-button">Salvar Planejamento</button>
            </form>
            <div id="planningMessage" class="success-message" style="display: none;"></div>
        </div>

        <!-- Elaboração para Leis de Incentivo (2.3) -->
        <div class="details-section">
            <h3>Elaboração para Leis de Incentivo</h3>
            {% if empty($projeto['incentivo']) %}
                <p>Nenhum dado de incentivo cadastrado.</p>
            {% else %}
                <p><strong>Justificativa:</strong> {{ htmlspecialchars($projeto['incentivo']['justificativa']) }}</p>
                <p><strong>Metas:</strong> {{ htmlspecialchars($projeto['incentivo']['metas']) }}</p>
                <p><strong>Plano de Aplicação de Recursos:</strong> {{ htmlspecialchars($projeto['incentivo']['plano_recursos']) }}</p>
            {% endif; %}
            <form id="incentivoForm">
                @csrf
                <input type="hidden" name="project_id" value="{{ $projeto['id'] }}">
                <div class="form-group">
                    <label for="justificativa">Justificativa</label>
                    <textarea id="justificativa" name="justificativa" class="form-textarea" required></textarea>
                </div>
                <div class="form-group">
                    <label for="metas">Metas</label>
                    <textarea id="metas" name="metas" class="form-textarea" required></textarea>
                </div>
                <div class="form-group">
                    <label for="plano_recursos">Plano de Aplicação de Recursos</label>
                    <textarea id="plano_recursos" name="plano_recursos" class="form-textarea" required></textarea>
                </div>
                <button type="submit" class="save-button">Salvar Dados de Incentivo</button>
            </form>
            <div id="incentivoMessage" class="success-message" style="display: none;"></div>
        </div>

        <!-- Avaliação de Resultados (2.5) -->
        <div class="details-section">
            <h3>Avaliação de Resultados</h3>
            {% if empty($data['projeto']['resultados']) %}
                <p>Nenhum resultado cadastrado.</p>
            {% else %}
                <p><strong>Alcance:</strong> {{ htmlspecialchars($projeto['resultados']['alcance']) }}</p>
                <p><strong>Impacto Cultural:</strong> {{ htmlspecialchars($projeto['resultados']['impacto_cultural']) }}</p>
                <p><strong>Retorno Financeiro (R$):</strong> {{ htmlspecialchars($projeto['resultados']['retorno_financeiro']) }}</p>
                <p><strong>Observações:</strong> {{ htmlspecialchars($projeto['resultados']['observacoes']) }}</p>
            <?php endif; ?>
            <form id="resultadosForm">
                <input type="hidden" name="project_id" value="{{ $projeto['id'] }}">
                <div class="form-group">
                    <label for="alcance">Alcance (ex.: número de pessoas impactadas)</label>
                    <input type="number" id="alcance" name="alcance" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="impacto_cultural">Impacto Cultural</label>
                    <textarea id="impacto_cultural" name="impacto_cultural" class="form-textarea" required></textarea>
                </div>
                <div class="form-group">
                    <label for="retorno_financeiro">Retorno Financeiro (R$)</label>
                    <input type="number" id="retorno_financeiro" name="retorno_financeiro" class="form-input" step="0.01" required>
                </div>
                <div class="form-group">
                    <label for="observacoes">Observações</label>
                    <textarea id="observacoes" name="observacoes" class="form-textarea"></textarea>
                </div>
                <button type="submit" class="save-button">Salvar Resultados</button>
            </form>
            <div id="resultadosMessage" class="success-message" style="display: none;"></div>
        </div>

        <a data-url="/admin/projetos-culturais/listaProjetos" class="back-button">Voltar para Lista</a>
    </div>
</div>