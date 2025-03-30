console.log('editais.js carregado');

function initializeEditalEvents() {
    console.log('Inicializando eventos de editais');

    const submitButton = document.getElementById('submitUpload');
    const uploadForm = document.getElementById('upload-edital-form');
    const loading = document.getElementById('loading');

    if (submitButton && uploadForm) {
        submitButton.addEventListener('click', () => {
            const formData = new FormData(uploadForm);

            if (loading) {
                loading.style.display = 'block';
            }

            fetch('/admin/upload-edital', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Erro na requisição: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                const status = document.getElementById('uploadStatus');
                status.textContent = data.message;

                if (loading) {
                    loading.style.display = 'none';
                }

                if (data.success) {
                    console.log('Upload bem-sucedido, chamando loadEditais');
                    loadEditais();
                }
            })
            .catch(error => {
                console.error('Erro ao fazer upload:', error);
                if (loading) {
                    loading.style.display = 'none';
                }
                document.getElementById('uploadStatus').textContent = 'Erro ao fazer upload.';
            });
        });
    }

    // Eventos para botões de status
    document.addEventListener('click', (e) => {
        if (e.target.classList.contains('approve-btn') || e.target.classList.contains('reject-btn')) {
            const id = e.target.getAttribute('data-id');
            const status = e.target.classList.contains('approve-btn') ? 'aprovado' : 'reprovado';
            const csrfToken = document.querySelector('input[name="_csrf_token"]').value;
            if (loading) {
                loading.style.display = 'block';
            }

            fetch('/admin/alterar-status-edital', {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json', 
                    'X-Requested-With': 'XMLHttpRequest',
                'X-CSRF-TOKEN': csrfToken }, // },
                body: JSON.stringify({ id, status, _csrf_token: csrfToken })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Erro na requisição 2: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                console.log('Dados recebidos :', data);
                if (loading) {
                    loading.style.display = 'none';
                }
                // Atualiza a linha correspondente na tabela
                const row = document.querySelector(`tr[data-id="${data.id}"]`);
                if (row) {
                    const cells = row.getElementsByTagName('td');
                    cells[0].textContent = data.name; // Nome (titulo)
                    cells[1].textContent = data.filename; // Nome do arquivo
                    cells[2].textContent = new Date(data.data_upload).toLocaleString('pt-BR'); // Data
                    cells[3].textContent = data.status; // Status
                    // A célula 4 contém os botões, não precisa atualizar
                } else {
                    console.warn('Linha não encontrada para o edital:', data.id);
                }
                /*if (data.success) {
                    console.log('Status atualizado, chamando loadEditais');
                    loadEditais();
                }*/
            })
            .catch(error => {
                console.error('Erro ao atualizar status:', error);
                if (loading) {
                    loading.style.display = 'none';
                }
            });
        }
    });
}

function loadEditais() {
    console.log('Carregando editais');
    const loading = document.getElementById('loading');
    if (loading) {
        loading.style.display = 'block';
    }

    fetch('/admin/listar-editais', {
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Erro na requisição: ' + response.status);
        }
        return response.json();
    })
    .then(data => {
        console.log('Dados recebidos:', data);
        const tbody = document.getElementById('edital-list');
        const noEditais = document.getElementById('no-editais');

        if (loading) {
            loading.style.display = 'none';
        }

        if (!tbody) {
            console.error('Elemento editais-tbody não encontrado');
            return;
        }

        tbody.innerHTML = '';

        if (!data.editais || data.editais.length === 0) {
            console.log('Nenhum edital encontrado');
            tbody.innerHTML = '<tr><td colspan="5">Nenhum edital encontrado.</td></tr>';
            noEditais.style.display = 'block';
            return;
        }

        console.log('Renderizando', data.editais.length, 'editais');
        noEditais.style.display = 'none';
        data.editais.forEach(edital => {
            const tr = document.createElement('tr');
            tr.setAttribute('data-id', edital.id);
            tr.innerHTML = `
                <td>${edital.name || '-'}</td>
                <td>${edital.filename || '-'}</td>
                <td>${new Date(edital.data_upload).toLocaleString('pt-BR')}</td>
                <td>${edital.status || 'em_analise'}</td>
                <td>
                    <button class="approve-btn" data-id="${edital.id}"><i class="bi bi-check-circle"></i></button>
                    <button class="reject-btn" data-id="${edital.id}"><i class="bi bi-x-circle-fill"></i></button>
                </td>
            `;
            tbody.appendChild(tr);
        });
    })
    .catch(error => {
        console.error('Erro ao carregar editais:', error);
        if (loading) {
            loading.style.display = 'none';
        }
    });
}

// Inicializa eventos e carrega editais imediatamente
initializeEditalEvents();
loadEditais();