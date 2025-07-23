(function () {
    console.log('Script carregado em', new Date().toLocaleString('pt-BR', { timeZone: 'America/Sao_Paulo' }));

    function ready(fn) {
        if (document.readyState === 'complete' || document.readyState === 'interactive') {
            setTimeout(fn, 0);
        } else {
            document.addEventListener('DOMContentLoaded', fn);
        }
    }

    ready(function () {
        console.log('DOM carregado em', new Date().toLocaleString('pt-BR', { timeZone: 'America/Sao_Paulo' }));

        const equipeListBody = document.getElementById('equipeTableBody');
        const editModal = document.getElementById('editModal');
        const deleteModal = document.getElementById('deleteModal');
        const closeEditModal = document.querySelector('#editModal .close-modal');
        const closeDeleteModal = document.querySelector('#deleteModal .close-modal');
        const editForm = document.getElementById('editForm');
        const confirmDelete = document.getElementById('confirmDelete');
        const cancelDelete = document.getElementById('cancelDelete');
        const deleteNome = document.getElementById('deleteNome');

        // Função para buscar dados da API
        function fetchEquipe() {
            fetch('/admin/equipe/lista')
                .then(response => response.json())
                .then(data => {
                    if (data.error) {
                        console.error('Erro ao carregar equipe:', data.error);
                        equipeListBody.innerHTML = '<tr><td colspan="5">Erro ao carregar dados.</td></tr>';
                    } else {
                        renderEquipe(data);
                    }
                })
                .catch(error => {
                    console.error('Erro na requisição:', error);
                    equipeListBody.innerHTML = '<tr><td colspan="5">Erro na conexão.</td></tr>';
                });
        }

        function renderEquipe(equipeData) {
            equipeListBody.innerHTML = '';
            if (!equipeData.length) {
                equipeListBody.innerHTML = '<tr><td colspan="5">Nenhuma pessoa cadastrada.</td></tr>';
                return;
            }
            equipeData.forEach(pessoa => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${pessoa.nome}</td>
                    <td>${pessoa.cargo}</td>
                    <td>${pessoa.resumo.substring(0, 50)}${pessoa.resumo.length > 50 ? '...' : ''}</td>
                    <td>${pessoa.destaque ? 'Sim' : 'Não'}</td>
                    <td>
                        <button class="edit-button" data-id="${pessoa.id}"><i class="bi bi-pencil"></i></button>
                        <button class="delete-button" data-id="${pessoa.id}"><i class="bi bi-trash"></i></button>
                    </td>
                `;
                equipeListBody.appendChild(row);
            });

            document.querySelectorAll('.edit-button').forEach(button => {
                button.addEventListener('click', editPessoa);
            });
            document.querySelectorAll('.delete-button').forEach(button => {
                button.addEventListener('click', showDeleteModal);
            });
        }

        function editPessoa(e) {
            const id = e.target.getAttribute('data-id');
            fetch(`/admin/equipe/editar/${id}`)
                .then(response => response.json())
                .then(pessoa => {
                    document.getElementById('editId').value = pessoa.id;
                    document.getElementById('editNome').value = pessoa.nome;
                    document.getElementById('editCargo').value = pessoa.cargo;
                    document.getElementById('editResumo').value = pessoa.resumo;
                    document.getElementById('editFotoAtual').textContent = `Imagem atual: ${pessoa.foto || 'Nenhuma'}`;
                    document.getElementById('editInstagram').value = pessoa.redes?.instagram || '';
                    document.getElementById('editFacebook').value = pessoa.redes?.facebook || '';
                    document.getElementById('editLinkedin').value = pessoa.redes?.linkedin || '';
                    document.getElementById('editDestaque').checked = pessoa.destaque;

                    editModal.style.display = 'block';
                })
                .catch(error => console.error('Erro ao carregar dados para edição:', error));
        }

        function showDeleteModal(e) {
            const id = e.target.getAttribute('data-id');
            fetch(`/admin/equipe/detalhes/${id}`)
                .then(response => response.json())
                .then(pessoa => {
                    deleteNome.textContent = pessoa.nome;
                    deleteModal.setAttribute('data-id', id);
                    deleteModal.style.display = 'block';
                })
                .catch(error => console.error('Erro ao carregar dados para exclusão:', error));
        }

        confirmDelete.addEventListener('click', function () {
            const id = deleteModal.getAttribute('data-id');
            fetch(`/admin/equipe/excluir/${id}`, { method: 'DELETE', headers: { 'X-CSRF-Token': document.querySelector('input[name="_csrf_token"]').value } })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        deleteModal.style.display = 'none';
                        fetchEquipe(); // Recarrega a lista
                    } else {
                        alert(data.error || 'Erro ao excluir pessoa.');
                    }
                })
                .catch(error => console.error('Erro na exclusão:', error));
        });

        cancelDelete.addEventListener('click', function () {
            deleteModal.style.display = 'none';
        });

        closeEditModal.addEventListener('click', function () {
            editModal.style.display = 'none';
        });

        closeDeleteModal.addEventListener('click', function () {
            deleteModal.style.display = 'none';
        });

        editForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const id = document.getElementById('editId').value;
            const formData = new FormData(editForm);
            fetch(`/admin/equipe/atualizar/${id}`, {
                method: 'POST',
                body: formData,
                headers: { 'X-CSRF-Token': document.querySelector('input[name="_csrf_token"]').value }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    editModal.style.display = 'none';
                    fetchEquipe(); // Recarrega a lista
                } else {
                    alert(data.error || 'Erro ao atualizar pessoa.');
                }
            })
            .catch(error => console.error('Erro na atualização:', error));
        });

        window.addEventListener('click', function (e) {
            if (e.target === editModal) editModal.style.display = 'none';
            if (e.target === deleteModal) deleteModal.style.display = 'none';
        });

        fetchEquipe(); // Inicializa a lista
    });
})();