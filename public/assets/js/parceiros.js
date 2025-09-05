
function initializeEvents() {
    

    // Botão Adicionar Parceiro
    const addPartnerBtn = document.getElementById('addPartnerBtn');
    const addPartnerModal = document.getElementById('addPartnerModal');
    const closeAddModal = document.getElementById('closeAddModal');
    const addPartnerForm = document.getElementById('addPartnerForm');
    const parceirosTable = document.querySelector('.parceiros-table');

    const csrfToken = document.querySelector('input[name="_csrf_token"]')?.value;
    if (!csrfToken) {
        console.error('Token CSRF não encontrado. Verifique o HTML.');
        return;
    }

    if (addPartnerBtn && addPartnerModal && closeAddModal && addPartnerForm) {
        

        // Abrir Modal
        addPartnerBtn.addEventListener('click', function () {
            addPartnerModal.classList.add('active');
            document.querySelector('#addPartnerModal .modal-header h3').textContent = 'Adicionar Novo Parceiro';
            addPartnerForm.reset();
            addPartnerModal.removeAttribute('data-edit-id');
            
        });

        // Fechar Modal
        closeAddModal.addEventListener('click', function () {
            addPartnerModal.classList.remove('active');
           
        });

        // Fechar ao clicar fora do modal
        addPartnerModal.addEventListener('click', function (e) {
            if (e.target === addPartnerModal) {
                addPartnerModal.classList.remove('active');
                
            }
        });

        // Submissão do Formulário - Adicionar/Editar Parceiro
        addPartnerForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const isEditing = addPartnerModal.hasAttribute('data-edit-id');
            const id = addPartnerModal.getAttribute('data-edit-id');
            const redesSociais = {
                tiktok: document.getElementById('partnerTiktok').value.trim(),
                linkedin: document.getElementById('partnerLinkedin').value.trim(),
                instagram: document.getElementById('partnerInstagram').value.trim(),
                facebook: document.getElementById('partnerFacebook').value.trim()
            };
            const parceiro = {
                nome: document.getElementById('partnerName').value.trim(),
                tipo: document.getElementById('partnerType').value,
                email: document.getElementById('partnerEmail').value.trim(),
                telefone: document.getElementById('partnerPhone').value.trim(),
                redes_sociais: redesSociais,
                descricao: document.getElementById('partnerDescription').value.trim(),
                _csrf_token: csrfToken
            };

            const url = isEditing ? `/admin/parceiros/update/${id}` : '/admin/parceiros/add';
            const method = isEditing ? 'POST' : 'POST'; // Usando POST para ambos, mas você pode mudar para PUT se preferir

            fetch(url, {
                method: method,
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': csrfToken,
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: JSON.stringify(parceiro)
            })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => {
                        throw new Error(`Erro HTTP ${response.status}: ${text}`);
                    });
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    
                    // Atualizar a tabela dinamicamente
                    const redesIcons = [];
                    if (redesSociais.tiktok) redesIcons.push(`<a href="${redesSociais.tiktok}" target="_blank"><i class="bi bi-tiktok"></i></a>`);
                    if (redesSociais.linkedin) redesIcons.push(`<a href="${redesSociais.linkedin}" target="_blank"><i class="bi bi-linkedin"></i></a>`);
                    if (redesSociais.instagram) redesIcons.push(`<a href="${redesSociais.instagram}" target="_blank"><i class="bi bi-instagram"></i></a>`);
                    if (redesSociais.facebook) redesIcons.push(`<a href="${redesSociais.facebook}" target="_blank"><i class="bi bi-facebook"></i></a>`);
                    const redesHtml = redesIcons.length ? redesIcons.join(' ') : '-';
                    const descricaoHtml = parceiro.descricao ? (parceiro.descricao.length > 50 ? parceiro.descricao.substring(0, 50) + '...' : parceiro.descricao) : '-';

                    if (isEditing) {
                        const row = document.querySelector(`.table-row:has([data-id="${id}"])`);
                        row.innerHTML = `
                            <div class="table-cell">${parceiro.nome}</div>
                            <div class="table-cell">${parceiro.tipo}</div>
                            <div class="table-cell">${parceiro.email}</div>
                            <div class="table-cell">${parceiro.telefone}</div>
                            <div class="table-cell">${redesHtml}</div>
                            <div class="table-cell">${descricaoHtml}</div>
                            <div class="table-cell">
                                <button class="action-btn edit-btn" data-id="${id}"><i class="bi bi-pen"></i></button>
                                <button class="action-btn delete-btn" data-id="${id}"><i class="bi bi-trash"></i></button>
                            </div>
                        `;
                    } else {
                        const newRow = document.createElement('div');
                        newRow.className = 'table-row';
                        newRow.innerHTML = `
                            <div class="table-cell">${parceiro.nome}</div>
                            <div class="table-cell">${parceiro.tipo}</div>
                            <div class="table-cell">${parceiro.email}</div>
                            <div class="table-cell">${parceiro.telefone}</div>
                            <div class="table-cell">${redesHtml}</div>
                            <div class="table-cell">${descricaoHtml}</div>
                            <div class="table-cell">
                                <button class="action-btn edit-btn" data-id="${data.id}"><i class="bi bi-pen"></i></button>
                                <button class="action-btn delete-btn" data-id="${data.id}"><i class="bi bi-trash"></i></button>
                            </div>
                        `;
                        parceirosTable.appendChild(newRow);

                        // Remove mensagem de "nenhum parceiro"
                        const noParceiros = document.querySelector('.no-parceiros');
                        if (noParceiros) {
                            noParceiros.remove();
                        }
                    }

                    // Feedback visual
                    alert(isEditing ? 'Parceiro atualizado com sucesso!' : 'Parceiro adicionado com sucesso!');
                    addPartnerModal.classList.remove('active');
                    addPartnerForm.reset();
                } else {
                    alert(data.message || 'Erro ao salvar parceiro.');
                }
            })
            .catch(error => {
                console.error('Erro ao salvar parceiro:', error);
                alert('Erro ao salvar parceiro: ' + error.message);
            });
        });
    } else {
        console.error('Erro ao encontrar elementos do modal de adição.');
    }

    // Botões de Ação (Editar e Excluir)
    document.addEventListener('click', function (e) {
        if (e.target.closest('.edit-btn')) {
            const button = e.target.closest('.edit-btn');
            const id = button.getAttribute('data-id');
           

            // Preenche o formulário com os dados do parceiro
            const row = button.closest('.table-row');
            const nome = row.children[0].textContent;
            const tipo = row.children[1].textContent;
            const email = row.children[2].textContent;
            const telefone = row.children[3].textContent;
            const redesCell = row.children[4];
            const descricao = row.children[5].textContent === '-' ? '' : row.children[5].textContent.replace('...', '');

            document.getElementById('partnerName').value = nome;
            document.getElementById('partnerType').value = tipo;
            document.getElementById('partnerEmail').value = email;
            document.getElementById('partnerPhone').value = telefone;

            // Preenche os campos de redes sociais
            document.getElementById('partnerTiktok').value = redesCell.querySelector('.bi-tiktok')?.parentElement?.href || '';
            document.getElementById('partnerLinkedin').value = redesCell.querySelector('.bi-linkedin')?.parentElement?.href || '';
            document.getElementById('partnerInstagram').value = redesCell.querySelector('.bi-instagram')?.parentElement?.href || '';
            document.getElementById('partnerFacebook').value = redesCell.querySelector('.bi-facebook')?.parentElement?.href || '';
            document.getElementById('partnerDescription').value = descricao;

            addPartnerModal.classList.add('active');
            addPartnerModal.setAttribute('data-edit-id', id);
            document.querySelector('#addPartnerModal .modal-header h3').textContent = 'Editar Parceiro';
        }

        if (e.target.closest('.delete-btn')) {
            const button = e.target.closest('.delete-btn');
            const id = button.getAttribute('data-id');
           
            if (confirm('Tem certeza que deseja excluir este parceiro?')) {
                fetch(`/admin/parceiros/delete/${id}`, {
                    method: 'DELETE',
                    headers: {
                        'X-CSRF-TOKEN': csrfToken,
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                .then(response => {
                    if (!response.ok) {
                        return response.text().then(text => {
                            throw new Error(`Erro HTTP ${response.status}: ${text}`);
                        });
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        button.closest('.table-row').remove();
                        if (!document.querySelectorAll('.table-row').length) {
                            const noParceiros = document.createElement('div');
                            noParceiros.className = 'no-parceiros';
                            noParceiros.innerHTML = '<p>Nenhum parceiro cadastrado no momento.</p>';
                            parceirosTable.insertAdjacentElement('afterend', noParceiros);
                        }
                        alert('Parceiro excluído com sucesso!');
                    } else {
                        alert(data.message || 'Erro ao excluir parceiro.');
                    }
                })
                .catch(error => {
                    console.error('Erro ao excluir parceiro:', error);
                    alert('Erro ao excluir parceiro: ' + error.message);
                });
            }
        }
    });
}

initializeEvents();