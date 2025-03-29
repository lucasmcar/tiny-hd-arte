<div class="content" id="main-content">
    <h2>{{ $title }}</h2>
    
    <!-- Formulário de Upload -->
    <div class="upload-section">
        <form id="upload-edital-form" enctype="multipart/form-data">
            @csrf
            <label for="edital-file">Upload de Edital (PDF):</label>
            <input type="file" id="edital-file" name="edital_file" accept=".pdf" required>
            <button type="submit">Enviar</button>
        </form>
    </div>

    <!-- Tabela de Editais -->
    <div class="edital-table">
        <table>
            <thead>
                <tr>
                    <th>Nome do Edital</th>
                    <th>Arquivo</th>
                    <th>Status</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody id="edital-list">
                <!-- Preenchido dinamicamente via JS -->
            </tbody>
        </table>
    </div>
</div>