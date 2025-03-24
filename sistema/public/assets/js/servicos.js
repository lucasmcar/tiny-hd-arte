// /assets/js/services.js
console.log('Services JS carregado');

function attachServiceEvents() {
    // Editar serviço
    document.querySelectorAll('.btn-edit').forEach(button => {
        button.addEventListener('click', function () {
            const serviceId = this.getAttribute('data-service-id');
            const row = this.closest('.table-row');
            const icon = row.querySelector('.table-cell:nth-child(1) i').className.replace('bi ', '');
            const title = row.querySelector('.table-cell:nth-child(2)').textContent;
            const description = row.querySelector('.table-cell:nth-child(3)').textContent;

            document.getElementById('editServiceId').value = serviceId;
            document.getElementById('editIcon').value = icon;
            document.getElementById('editTitle').value = title;
            document.getElementById('editDescription').value = description;
        });
    });

    // Excluir serviço
    document.querySelectorAll('.btn-delete').forEach(button => {
        button.addEventListener('click', function () {
            const serviceId = this.getAttribute('data-service-id');
            if (confirm('Tem certeza que deseja excluir este serviço?')) {
                fetch(`/admin/servicos/${serviceId}`, {
                    method: 'DELETE',
                    headers: { "X-Requested-With": "XMLHttpRequest" }
                })
                .then(response => {
                    if (!response.ok) throw new Error('Erro ao excluir serviço');
                    this.closest('.table-row').remove();
                    console.log(`Serviço ${serviceId} excluído`);
                })
                .catch(error => console.error('Erro:', error));
            }
        });
    });

    // Salvar novo serviço
    document.getElementById('saveNewService').addEventListener('click', function () {
        const form = document.getElementById('addServiceForm');
        const formData = new FormData(form);
        const data = Object.fromEntries(formData);

        fetch('/admin/servicos', {
            method: 'POST',
            headers: {
                "X-Requested-With": "XMLHttpRequest",
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (!response.ok) throw new Error('Erro ao adicionar serviço');
            return response.json();
        })
        .then(newService => {
            const tbody = document.querySelector('.table-body');
            tbody.insertAdjacentHTML('beforeend', `
                <div class="table-row" data-service-id="${newService.id || Date.now()}">
                    <div class="table-cell"><i class="bi ${newService.icone}"></i></div>
                    <div class="table-cell">${newService.titulo}</div>
                    <div class="table-cell">${newService.descricao}</div>
                    <div class="table-cell">
                        <button class="btn-edit" onclick="document.getElementById('editServiceModal').classList.add('show')" data-service-id="${newService.id || Date.now()}">Editar</button>
                        <button class="btn-delete" data-service-id="${newService.id || Date.now()}">Excluir</button>
                    </div>
                </div>
            `);
            document.getElementById('addServiceModal').classList.remove('show');
            attachServiceEvents();
        })
        .catch(error => console.error('Erro:', error));
    });

    // Salvar edição de serviço
    document.getElementById('saveEditService').addEventListener('click', function () {
        const form = document.getElementById('editServiceForm');
        const formData = new FormData(form);
        const data = Object.fromEntries(formData);
        const serviceId = data.id;

        fetch(`/admin/servicos/${serviceId}`, {
            method: 'PUT',
            headers: {
                "X-Requested-With": "XMLHttpRequest",
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (!response.ok) throw new Error('Erro ao editar serviço');
            return response.json();
        })
        .then(updatedService => {
            const row = document.querySelector(`.table-row[data-service-id="${serviceId}"]`);
            row.querySelector('.table-cell:nth-child(1) i').className = `bi ${updatedService.icone}`;
            row.querySelector('.table-cell:nth-child(2)').textContent = updatedService.titulo;
            row.querySelector('.table-cell:nth-child(3)').textContent = updatedService.descricao;
            document.getElementById('editServiceModal').classList.remove('show');
        })
        .catch(error => console.error('Erro:', error));
    });
}

attachServiceEvents();