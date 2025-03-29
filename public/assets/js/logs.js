console.log('logs.js carregado');

function initializeLogEvents() {
    console.log('Inicializando eventos de logs');

    const filterInput = document.getElementById('log-filter');
    if (filterInput) {
        console.log('Campo de filtro encontrado');
        filterInput.removeEventListener('input', handleFilterInput);
        filterInput.addEventListener('input', handleFilterInput);
    } else {
        console.error('Campo log-filter não encontrado');
    }

    const selectAll = document.getElementById('selectAll');
    if (selectAll) {
        console.log('Checkbox selectAll encontrado');
        selectAll.removeEventListener('change', handleSelectAll);
        selectAll.addEventListener('change', handleSelectAll);
    } else {
        console.error('Checkbox selectAll não encontrado');
    }

    const exportBtn = document.getElementById('exportPdf');
    if (exportBtn) {
        exportBtn.removeEventListener('click', handleExportPdf);
        exportBtn.addEventListener('click', handleExportPdf);
    }

    const clearBtn = document.getElementById('clearLogs');
    if (clearBtn) {
        clearBtn.removeEventListener('click', handleClearLogs);
        clearBtn.addEventListener('click', handleClearLogs);
    }
}

function handleFilterInput() {
    const filter = this.value.toLowerCase();
    console.log('Filtro digitado:', filter);
    loadLogs(filter);
}

function handleSelectAll() {
    const checkboxes = document.querySelectorAll('.log-checkbox');
    console.log('Checkboxes encontrados:', checkboxes.length);
    checkboxes.forEach(cb => {
        cb.checked = this.checked;
        console.log('Checkbox atualizado:', cb.value, cb.checked);
    });
}

function handleExportPdf() {
    console.log('Exportando PDF');
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();
    doc.autoTable({ html: '.logs-table' });
    doc.save('logs.pdf');
}

function handleClearLogs() {
    const selected = Array.from(document.querySelectorAll('.log-checkbox:checked'))
        .map(cb => cb.value);
    console.log('Logs selecionados para limpeza:', selected);
    if (selected.length === 0) {
        showStatus('Nenhum log selecionado.');
        return;
    }

    fetch('/admin/clear-logs', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
        body: JSON.stringify({ ids: selected })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showStatus('Logs limpos com sucesso!');
            const filterInput = document.getElementById('log-filter');
            loadLogs(filterInput ? filterInput.value.toLowerCase() : '');
        } else {
            showStatus('Erro ao limpar logs.');
        }
    })
    .catch(error => console.error('Erro ao limpar logs:', error));
}

function loadLogs(filter = '') {
    console.log('Carregando logs com filtro:', filter);
    fetch('/admin/configuracoes/list-logs' + (filter ? `?filter=${encodeURIComponent(filter)}` : ''), {
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(response => {
        console.log('Status da resposta:', response.status);
        if (!response.ok) {
            return response.text().then(text => {
                throw new Error(`Erro na requisição: ${response.status} - ${text}`);
            });
        }
        return response.json();
    })
    .then(data => {
        console.log('Dados recebidos:', data);
        const tbody = document.getElementById('logs-tbody');
        const noLogs = document.getElementById('no-logs');

        if (!tbody) {
            console.error('Elemento logs-tbody não encontrado');
            return;
        }

        tbody.innerHTML = '';

        if (!data.logs || data.logs.length === 0) {
            console.log('Nenhum log encontrado');
            tbody.innerHTML = '<tr><td colspan="6">Nenhum log encontrado.</td></tr>';
            noLogs.style.display = 'block';
            return;
        }

        console.log('Renderizando', data.logs.length, 'logs');
        noLogs.style.display = 'none';
        data.logs.forEach(log => {
            const details = log.detalhes ? JSON.parse(log.detalhes) : {};
            const detailsText = details.titulo || details.name || details.status_antigo || '-';
            const date = log.data_acao || log.created_at || 'N/A';
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td><input type="checkbox" class="log-checkbox" value="${log.id}"></td>
                <td>${new Date(date).toLocaleString('pt-BR')}</td>
                <td>${log.acao || '-'}</td>
                <td>${log.tabela_afetada || '-'}</td>
                <td>${log.id_registro || 'N/A'}</td>
                <td>${detailsText}</td>
            `;
            tbody.appendChild(tr);
        });
        console.log('Tabela atualizada, reiniciando eventos');
        initializeLogEvents();
    })
    .catch(error => console.error('Erro ao carregar logs:', error));
}

function showStatus(message) {
    const statusMessage = document.getElementById('statusMessage');
    if (statusMessage) {
        statusMessage.textContent = message;
        setTimeout(() => statusMessage.textContent = '', 3000);
    } else {
        console.error('Elemento statusMessage não encontrado');
    }
}

initializeLogEvents();