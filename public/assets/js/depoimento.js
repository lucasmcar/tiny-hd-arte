console.log('depoimentos.js carregado');

function initializeDepoimentoEvents() {
    console.log('Inicializando eventos de depoimentos');

    const loading = document.getElementById('loading');
    const csrfToken = document.querySelector('input[name="_csrf_token"]')?.value;

    function handleDelete(e) {
        e.preventDefault();
        const id = e.target.closest('.delete-btn').getAttribute('data-id');

        if (!confirm('Tem certeza que deseja excluir este depoimento?')) {
            return;
        }

        if (loading) {
            loading.style.display = 'block';
        }

        fetch(`/admin/excluir/depoimento/${id}`, {
            method: 'DELETE',
            headers: {
                'X-Requested-With': 'XMLHttpRequest',
                'X-CSRF-TOKEN': csrfToken
            }
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Erro na requisição: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            if (loading) {
                loading.style.display = 'none';
            }
            if (data.success) {
                console.log('Depoimento excluído com sucesso, recarregando depoimentos');
                loadDepoimentos(); // Recarrega os depoimentos dinamicamente
            } else {
                alert('Erro ao excluir depoimento: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Erro ao excluir depoimento:', error);
            if (loading) {
                loading.style.display = 'none';
            }
            alert('Erro ao excluir depoimento.');
        });
    }

    function initializeDeleteButtons() {
        document.querySelectorAll('.delete-btn').forEach(button => {
            button.removeEventListener('click', handleDelete);
            button.addEventListener('click', handleDelete);
        });
    }

    initializeDeleteButtons();
}

function loadDepoimentos(pagina = 1) {
    console.log('Carregando depoimentos, página:', pagina);
    const loading = document.getElementById('loading');
    if (loading) loading.style.display = 'block';

    fetch(`/admin/listar-depoimentos?pagina=${pagina}`, {
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(text => {
                console.error('Resposta bruta do servidor:', text);
                throw new Error('Erro na requisição: ' + response.status + ' - ' + text);
            });
        }
        return response.json();
    })
    .then(data => {
        const tbody = document.getElementById('depoimento-list');
        const noDepoimentos = document.getElementById('no-depoimentos');
        if (loading) loading.style.display = 'none';

        if (!tbody) {
            console.error('Elemento depoimento-list não encontrado');
            return;
        }

        tbody.innerHTML = '';
        if (!data.depoimentos || data.depoimentos.length === 0) {
            tbody.innerHTML = '<tr><td colspan="5">Nenhum depoimento encontrado.</td></tr>';
            if (noDepoimentos) noDepoimentos.style.display = 'block';
            return;
        }

        if (noDepoimentos) noDepoimentos.style.display = 'none';
        data.depoimentos.forEach(item => {
            const tr = document.createElement('tr');
            tr.setAttribute('data-id', item.id);
            tr.innerHTML = `
                <td><img src="${item.foto}" width="64" height="64" class="rounded-circle"></td>
                <td>${item.nome}</td>
                <td>${item.titulo}</td>
                <td>${item.depoimento}</td>
                <td>
                    <a href="#" class="action-btn delete-btn" data-id="${item.id}"><i class="bi bi-trash"></i> Excluir</a>
                </td>
            `;
            tbody.appendChild(tr);
        });

        document.querySelector('.total-count').textContent = `Total: ${data.totalDepoimentos} depoimentos`;
        updatePagination(data.paginaAtual, data.totalPaginas);

        // Reatribuir eventos para os botões de exclusão após carregar a tabela
        initializeDepoimentoEvents();
    })
    .catch(error => {
        console.error('Erro ao carregar depoimentos:', error);
        if (loading) loading.style.display = 'none';
    });
}

function updatePagination(paginaAtual, totalPaginas) {
    const pagination = document.querySelector('.pagination-netflix');
    if (!pagination) {
        console.error('Elemento .pagination-netflix não encontrado');
        return;
    }

    pagination.innerHTML = '';
    if (totalPaginas <= 1) {
        return;
    }

    if (paginaAtual > 1) {
        const prev = document.createElement('a');
        prev.href = `#pagina=${paginaAtual - 1}`;
        prev.className = 'pagination-btn';
        prev.textContent = 'Anterior';
        prev.addEventListener('click', (e) => {
            e.preventDefault();
            loadDepoimentos(paginaAtual - 1);
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
            loadDepoimentos(i);
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
            loadDepoimentos(paginaAtual + 1);
        });
        pagination.appendChild(next);
    }
}

// Inicializa eventos e carrega depoimentos com base na URL inicial
document.addEventListener('DOMContentLoaded', () => {
    console.log('Evento DOMContentLoaded disparado em depoimentos.js');
    if (window.location.pathname.includes('/admin/todos/depoimentos')) {
        const urlParams = new URLSearchParams(window.location.search);
        const paginaInicial = parseInt(urlParams.get('pagina')) || 1;
        initializeDepoimentoEvents();
        loadDepoimentos(paginaInicial);
    }
});