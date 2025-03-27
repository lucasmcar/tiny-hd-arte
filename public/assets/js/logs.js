document.addEventListener('DOMContentLoaded', () => {
    const filterInput = document.getElementById('log-filter');
    const exportBtn = document.getElementById('exportPdf');
    const clearBtn = document.getElementById('clearLogs');
    const selectAll = document.getElementById('selectAll');
    const tableBody = document.getElementById('logsTableBody');
    const statusMessage = document.getElementById('statusMessage');

    // Verificar se allLogs está definido
    console.log('allLogs:', window.allLogs);
    if (!window.allLogs) {
        console.error('allLogs não está definido!');
        return;
    }

    // Função para renderizar logs filtrados
    function renderLogs(logs) {
        console.log('Renderizando logs:', logs);
        tableBody.innerHTML = '';
        if (logs.length === 0) {
            tableBody.innerHTML = '<tr><td colspan="5" class="no-logs">Nenhum log encontrado.</td></tr>';
            return;
        }
        logs.forEach(log => {
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td><input type="checkbox" class="log-checkbox" value="${log.id}"></td>
                <td>${new Date(log.created_at).toLocaleString('pt-BR', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' })}</td>
                <td>${log.action}</td>
                <td>${log.testimony_id || 'N/A'}</td>
                <td>${log.details || '-'}</td>
            `;
            tableBody.appendChild(tr);
        });
    }

    // Filtro enquanto digita
    filterInput.addEventListener('input', () => {
        const filter = filterInput.value.toLowerCase();
        console.log('Filtro digitado:', filter);
        const filteredLogs = window.allLogs.filter(log => {
            const actionMatch = log.action.toLowerCase().includes(filter);
            const detailsMatch = log.details && log.details.toLowerCase().includes(filter);
            console.log(`Log: ${log.action}, Action Match: ${actionMatch}, Details Match: ${detailsMatch}`);
            return actionMatch || detailsMatch;
        });
        renderLogs(filteredLogs);
    });

    // Selecionar todos
    selectAll.addEventListener('change', () => {
        document.querySelectorAll('.log-checkbox').forEach(cb => cb.checked = selectAll.checked);
    });

    // Exportar PDF
    exportBtn.addEventListener('click', () => {
        const visibleLogs = Array.from(tableBody.querySelectorAll('tr')).map(row => {
            const cells = row.querySelectorAll('td');
            return {
                id: cells[0].querySelector('input').value,
                created_at: cells[1].textContent,
                action: cells[2].textContent,
                testimony_id: cells[3].textContent,
                details: cells[4].textContent
            };
        });

        fetch('/admin/logs/export-pdf', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ logs: visibleLogs })
        }).then(response => response.blob()).then(blob => {
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'logs_' + new Date().toISOString().slice(0, 10) + '.pdf';
            a.click();
            window.URL.revokeObjectURL(url);
        });
    });

    // Limpar logs selecionados
    clearBtn.addEventListener('click', () => {
        const selected = Array.from(document.querySelectorAll('.log-checkbox'))
            .filter(cb => cb.checked)
            .map(cb => cb.value);
        
        if (selected.length === 0) {
            statusMessage.textContent = 'Selecione ao menos um log para limpar.';
            setTimeout(() => statusMessage.textContent = '', 3000);
            return;
        }

        fetch('/admin/logs/clear', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ selected })
        })
        .then(response => response.json())
        .then(data => {
            statusMessage.textContent = data.message;
            if (data.success) {
                setTimeout(() => location.reload(), 1000);
            } else {
                setTimeout(() => statusMessage.textContent = '', 3000);
            }
        });
    });
});