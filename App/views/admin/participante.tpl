<section class="participants-section">
    <div class="container">
        <h1 class="hda-title">{{ $title }}</h1>

        <!-- Formulário de Cadastro/Edição -->
        <div class="form-block mt-4">
            <h2 class="form-title">Cadastrar/Editar Participante</h2>
            <form id="participantForm">
                <input type="hidden" id="participantId" name="id">
                <div class="form-group">
                    <label for="participantName">Nome:</label>
                    <input type="text" id="participantName" name="name" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="participantType">Tipo:</label>
                    <select id="participantType" name="type" class="form-input" required>
                        <option value="Fornecedor">Fornecedor</option>
                        <option value="Artista">Artista</option>
                        <option value="Parceiro">Parceiro</option>
                        <option value="Patrocinador">Patrocinador</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="participantContact">Contato:</label>
                    <input type="text" id="participantContact" name="contact" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="participantEvent">Evento Associado:</label>
                    <select id="participantEvent" name="event_id" class="form-input" required>
                        {% foreach $events as $index => $event %}
                            <option value="{{ $event['id'] }}">{{ htmlspecialchars($event['name']) }}</option>
                        {% endforeach; %}
                    </select>
                </div>
                <div class="form-group">
                    <label for="participantDescription">Descrição:</label>
                    <textarea id="participantDescription" name="description" class="form-input" rows="4"></textarea>
                </div>
                <button type="submit" class="action-btn save-btn">Salvar Participante</button>
                <button type="button" class="action-btn reset-btn" id="resetForm">Limpar Formulário</button>
            </form>
            <span class="status-message" id="formStatus"></span>
        </div>

        <!-- Lista de Participantes -->
        <div class="participants-list mt-4">
            <h2 class="list-title">Participantes Cadastrados</h2>
            {% if !empty($participants) %}
                <table class="participants-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nome</th>
                            <th>Tipo</th>
                            <th>Contato</th>
                            <th>Evento</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody id="participantsTableBody">
                        {% foreach $participants as $index => $participant %}
                            <tr>
                                <td>{{ $participant['id'] }}</td>
                                <td>{{ htmlspecialchars($participant['name']) }}</td>
                                <td>{{ htmlspecialchars($participant['type']) }}</td>
                                <td>{{ htmlspecialchars($participant['contact']) }}</td>
                                <td>{{ htmlspecialchars($participant['event_name']) }}</td>
                                <td>
                                    <button class="action-btn edit-btn" data-id="{{ $participant['id'] }}">Editar</button>
                                </td>
                            </tr>
                        {% endforeach; %}
                    </tbody>
                </table>
            {% else %}
                <p class="no-participants">Nenhum participante cadastrado.</p>
            {% endif; %}
        </div>
    </div>
</section>