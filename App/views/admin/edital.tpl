<div class="content" id="main-content">
    <h2>{{ $title }}</h2>
    
    <!-- Formulário de Upload -->
    <div class="upload-section">
        <form id="upload-edital-form" enctype="multipart/form-data">
            @csrf
            <label for="edital-file">Upload de Edital (PDF):</label>
            <input type="file" id="edital-file" name="edital_file" accept=".pdf" required>
            <button type="button" id="submitUpload">Enviar</button>
            <span id="uploadStatus"></span>
        </form>
    </div>

    <p class="total-count">Total: {{ $totalEditais }} editais</p>

    {% if $totalEditais > 0 %}
        <div class="edital-table">
            <table>
                <thead>
                    <tr>
                        <th>Nome do Edital</th>
                        <th>Arquivo</th>
                        <th>Data de Upload</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody id="edital-list" >
                    {% if !empty($editais) %}
                        {% foreach $editais as $index => $edital %}
                            <tr data-id="{{ $edital['id'] }}">
                                <td >{{ htmlspecialchars($edital['name']) }}</td>
                                <td>{{ htmlspecialchars($edital['filename']) }}</td>
                                <td>{{ date('d/m/Y H:i', strtotime($edital['data_upload'])) }}</td>
                                
                                <td>{{ htmlspecialchars($edital['status']) }}</td>
                                <td>
                                    <button class="approve-btn" data-id="{{ $edital['id'] }}"><i class="bi bi-check-circle"></i></button>
                                    <button class="reject-btn" data-id="{{ $edital['id'] }}"><i class="bi bi-x-circle-fill"></i></button>
                                </td>
                            </tr>
                        {% endforeach; %}
                    {% else %}
                        <tr><td colspan="3">Nenhum edital encontrado.</td></tr>
                    {% endif; %}
                </tbody>
            </table>
            <div id="no-editais" style="display: none;">Nenhum edital disponível.</div>
        </div>
        {% if $totalPaginas > 1 %}
            <div class="pagination-netflix">
                {% if $paginaAtual > 1 %}
                    <a href="/admin/editais?pagina={{ $paginaAtual - 1 }}" class="pagination-btn">Anterior</a>
                {% endif; %}
                @for( 1, $totalPaginas, $i ) 
                    <a href="/admin/editais?pagina={{ $i }}" class="pagination-btn {% if $i == $paginaAtual %}active{% endif; %}">{{ $i }}</a>
                @endfor()
                    {% if $paginaAtual < $totalPaginas %}
                        <a href="/admin/editais?pagina={{ $paginaAtual + 1 }}" class="pagination-btn">Próximo</a>
                    {% endif; %}
            </div>
        {% endif; %}
    {% else %}
            <p class="empty-list">Nenhum edital encontrado.</p>
    {% endif; %}    
</div>