<section class="events-section">
    <div class="container">
        <h1 class="hda-title">{{ $title }}</h1>

        <!-- Formulário de Cadastro/Edição -->
        <div class="form-block mt-4">
            <h2 class="form-title">Cadastrar/Editar Evento</h2>
            <form id="eventForm">
                <input type="hidden" id="eventId" name="id">
                <div class="form-group">
                    <label for="eventName">Nome do Evento:</label>
                    <input type="text" id="eventName" name="name" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="eventDate">Data:</label>
                    <input type="date" id="eventDate" name="date" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="eventLocation">Local:</label>
                    <input type="text" id="eventLocation" name="location" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="eventDescription">Descrição:</label>
                    <textarea id="eventDescription" name="description" class="form-input" rows="4"></textarea>
                </div>
                <div class="form-group">
                    <label for="eventType">Tipo de Evento:</label>
                    <select id="eventType" name="type" class="form-input">
                        <option value="Cultural">Cultural</option>
                        <option value="Musical">Musical</option>
                        <option value="Esportivo">Esportivo</option>
                        <option value="Educacional">Educacional</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="eventTarget">Público-Alvo:</label>
                    <input type="text" id="eventTarget" name="target_audience" class="form-input">
                </div>
                <button type="submit" class="action-btn save-btn">Salvar Evento</button>
                <button type="button" class="action-btn reset-btn" id="resetForm">Limpar Formulário</button>
            </form>
            <span class="status-message" id="formStatus"></span>
        </div>

        <!-- Lista de Eventos -->
        <div class="events-list mt-4">
            <h2 class="list-title">Eventos Cadastrados</h2>
            {% if !empty($events) %}
                <table class="events-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nome</th>
                            <th>Data</th>
                            <th>Local</th>
                            <th>Tipo</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody id="eventsTableBody">
                        {% foreach $events as $index => $event %}
                            <tr>
                                <td>{{ $event['id'] }}</td>
                                <td>{{ htmlspecialchars($event['name']) }}</td>
                                <td>{{ date('d/m/Y', strtotime($event['date'])) }}</td>
                                <td>{{ htmlspecialchars($event['location']) }}</td>
                                <td>{{ htmlspecialchars($event['type']) }}</td>
                                <td>
                                    <button class="action-btn edit-btn" data-id="{{ $event['id'] }}">Editar</button>
                                </td>
                            </tr>
                        {% endforeach; %}
                    </tbody>
                </table>
            {% else %}
                <p class="no-events">Nenhum evento cadastrado.</p>
            {% endif; %}
        </div>
    </div>
</section>