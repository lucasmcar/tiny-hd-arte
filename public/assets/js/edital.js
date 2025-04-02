console.log('editais.js carregado');

function initializeEditalEvents() {
    console.log('Inicializando eventos de editais');

    const submitButton = document.getElementById('submitUpload');
    const uploadForm = document.getElementById('upload-edital-form');
    const loading = document.getElementById('loading');
    const csrfToken = document.querySelector('input[name="_csrf_token"]')?.value;

    if (submitButton && uploadForm) {
        submitButton.addEventListener('click', () => {
            const formData = new FormData(uploadForm);

            if (loading) {
                loading.style.display = 'block';
            }

            fetch('/admin/upload-edital', {
                headers: { 'X-Requested-With': 'XMLHttpRequest', 'X-CSRF-TOKEN': csrfToken },
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

    // Função para lidar com cliques nos botões de status
    function handleStatusChange(e) {
        // Encontra o botão mais próximo (para lidar com cliques no <i> dentro do botão)
        const button = e.target.closest('button');
        if (!button) {
            console.error('Botão não encontrado para o elemento clicado:', e.target);
            return;
        }
    
        const id = button.getAttribute('data-id');
        const status = button.classList.contains('approve-btn') ? 'aprovado' : 'reprovado';
        const csrfToken = document.querySelector('input[name="_csrf_token"]')?.value;
    
        // Validações
        if (!id) {
            console.error('ID não encontrado no botão:', button);
            return;
        }
    
        if (!csrfToken) {
            console.error('CSRF Token não encontrado.');
            return;
        }
    
        const loading = document.querySelector('.loading'); // Ajuste conforme seu elemento de loading
        if (loading) {
            loading.style.display = 'block';
        }
    
        fetch('/admin/alterar-status-edital', {
            method: 'PUT',
            headers: { 
                'Content-Type': 'application/json', 
                'X-Requested-With': 'XMLHttpRequest',
                'X-CSRF-TOKEN': csrfToken
            },
            body: JSON.stringify({ id, status, _csrf_token: csrfToken })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Erro na requisição: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            console.log('Dados recebidos:', data);
            if (loading) {
                loading.style.display = 'none';
            }
            const row = document.querySelector(`tr[data-id="${data.id}"]`);
            if (row) {
                const cells = row.getElementsByTagName('td');
                cells[0].textContent = data.name;
                cells[1].textContent = data.filename;
                cells[2].textContent = new Date(data.data_upload).toLocaleString('pt-BR');
                cells[3].textContent = data.status;
        
                // Adiciona uma mensagem de sucesso na página
                const statusMessage = document.createElement('div');
                statusMessage.className = 'success-message';
                statusMessage.textContent = data.message;
                document.querySelector('.edital-table').prepend(statusMessage);
                setTimeout(() => statusMessage.remove(), 3000); // Remove após 3 segundos
            } else {
                console.warn('Linha não encontrada para o edital:', data.id);
            }
        })
        .catch(error => {
            console.error('Erro ao atualizar status:', error);
            if (loading) {
                loading.style.display = 'none';
            }
        });
    }

    // Reatribuir eventos para botões de status
    function initializeStatusButtons() {
        document.querySelectorAll('.approve-btn, .reject-btn').forEach(button => {
            button.removeEventListener('click', handleStatusChange);
            button.addEventListener('click', handleStatusChange);
        });
    }

    // Inicializar eventos de status no carregamento inicial
    initializeStatusButtons();
}

function loadEditais(pagina = 1) {
    console.log('Carregando editais, página:', pagina);
    const loading = document.getElementById('loading');
    if (loading) loading.style.display = 'block';

    fetch(`/admin/listar-editais?pagina=${pagina}`, {
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(response => {
        if (!response.ok) throw new Error('Erro na requisição: ' + response.status);
        return response.json();
    })
    .then(data => {
        const tbody = document.getElementById('edital-list');
        const noEditais = document.getElementById('no-editais');
        if (loading) loading.style.display = 'none';

        if (!tbody) {
            console.error('Elemento edital-list não encontrado');
            return;
        }

        tbody.innerHTML = '';
        if (!data.editais || data.editais.length === 0) {
            tbody.innerHTML = '<tr><td colspan="5">Nenhum edital encontrado.</td></tr>';
            if (noEditais) noEditais.style.display = 'block';
            return;
        }

        if (noEditais) noEditais.style.display = 'none';
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

        document.querySelector('.total-count').textContent = `Total: ${data.totalEditais} editais`;
        updatePagination(data.paginaAtual, data.totalPaginas);

        // Reatribuir eventos para os botões de status após carregar a tabela
        initializeEditalEvents();
    })
    .catch(error => {
        console.error('Erro ao carregar editais:', error);
        if (loading) loading.style.display = 'none';
    });
}

function updatePagination(paginaAtual, totalPaginas) {
    const pagination = document.querySelector('.pagination-netflix');
    if (!pagination) return;

    pagination.innerHTML = '';
    if (paginaAtual > 1) {
        const prev = document.createElement('a');
        prev.href = `#pagina=${paginaAtual - 1}`;
        prev.className = 'pagination-btn';
        prev.textContent = 'Anterior';
        prev.addEventListener('click', (e) => {
            e.preventDefault();
            loadEditais(paginaAtual - 1);
        });
        pagination.appendChild(prev);
    }

    for (let i = 1; i <= totalPaginas; i++) {
        const link = document.createElement('a');
        link.href = `#pagina=${i}`;
        link.className = `pagination-btn ${i === paginaAtual ? 'active' : ''}`;
        link.textContent = i;
        link.addEventListener('click', (e) => {
            e.preventDefault();
            loadEditais(i);
        });
        pagination.appendChild(link);
    }

    if (paginaAtual < totalPaginas) {
        const next = document.createElement('a');
        next.href = `#pagina=${paginaAtual + 1}`;
        next.className = 'pagination-btn';
        next.textContent = 'Próximo';
        next.addEventListener('click', (e) => {
            e.preventDefault();
            loadEditais(paginaAtual + 1);
        });
        pagination.appendChild(next);
    }
}

// Inicializa eventos e carrega editais imediatamente
initializeEditalEvents();
loadEditais(1);