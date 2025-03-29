document.addEventListener('DOMContentLoaded', () => loadEditais());

    // Upload de edital
    document.getElementById('upload-edital-form').addEventListener('submit', function(e) {
        e.preventDefault();
        const fileInput = document.getElementById('edital-file');
        const csrfToken = document.getElementById('_csrf_token').value;
        const formData = new FormData();
        formData.append('edital_file', fileInput.files[0]);
        formData.append('_csrf_token', csrfToken);

        fetch('/admin/upload-edital', {
            method: 'POST',
            body: formData,
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                addLog(`Upload realizado: ${data.filename}`);
                loadEditais(); // Recarrega a lista
                fileInput.value = ''; // Limpa o input
            } else {
                alert('Erro ao fazer upload: ' + data.message);
            }
        })
        .catch(error => console.error('Erro:', error));
    });

    // Carregar lista de editais
    function loadEditais() {
        fetch('/admin/listar-editais', { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
        .then(response => response.json())
        .then(data => {
            const tbody = document.getElementById('edital-list');
            tbody.innerHTML = '';
            data.editais.forEach(edital => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${edital.name}</td>
                    <td><a href="${edital.url}" target="_blank">${edital.filename}</a></td>
                    <td>${edital.status}</td>
                    <td>
                        <select onchange="alterarStatus(${edital.id}, this.value)">
                            <option value="Em Análise" ${edital.status === 'Em Análise' ? 'selected' : ''}>Em Análise</option>
                            <option value="Aprovado" ${edital.status === 'Aprovado' ? 'selected' : ''}>Aprovado</option>
                            <option value="Reprovado" ${edital.status === 'Reprovado' ? 'selected' : ''}>Reprovado</option>
                        </select>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        });
    }

    // Alterar status
    function alterarStatus(id, status) {
        fetch('/admin/alterar-status-edital', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify({ id, status })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                addLog(`Status alterado: ${data.filename} para ${status}`);
                loadEditais(); // Recarrega a lista
            }
        });
    }

    // Adicionar log
    /*function addLog(message) {
        const logList = document.getElementById('log-list');
        const li = document.createElement('li');
        li.textContent = `${new Date().toLocaleString()} - ${message}`;
        logList.insertBefore(li, logList.firstChild); // Adiciona no topo
    }*/