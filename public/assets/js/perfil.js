console.log('Script gerenciar-perfil.js carregado com sucesso!');

function initializeProfileManagement() {
    const profilePicPreview = document.getElementById('profile-pic-preview');
    const profilePicUpload = document.getElementById('profile-pic-upload');
    const uploadProfilePicBtn = document.getElementById('upload-profile-pic');
    const changePasswordBtn = document.getElementById('change-password-btn');
    const addAdminBtn = document.getElementById('add-admin-btn');
    const addEmailBtn = document.getElementById('add-email-btn');
    const newAdminName = document.getElementById('new-admin-name');
    const newAdminEmail = document.getElementById('new-admin-email');
    const saveProfileBtn = document.getElementById('saveProfileBtn');
    const adminsList = document.getElementById('admins-list');
    const emailsList = document.getElementById('emails-list');
    const modal = new bootstrap.Modal(document.getElementById('saveProfileModal'));
    const modalMessage = document.getElementById('modalMessage');

    // Captura o token CSRF
    const csrfToken = document.querySelector('input[name="_csrf_token"]')?.value;
    if (!csrfToken) {
        console.error('Token CSRF não encontrado. Verifique o HTML.');
    }

    // Upload da Foto de Perfil
    uploadProfilePicBtn.addEventListener('click', () => profilePicUpload.click());
    profilePicUpload.addEventListener('change', () => {
        const file = profilePicUpload.files[0];
        if (file && file.type.startsWith('image/')) {
            const reader = new FileReader();
            reader.onload = (e) => profilePicPreview.src = e.target.result;
            reader.readAsDataURL(file);
        }
    });

    // Alterar Senha
    changePasswordBtn.addEventListener('click', () => {
        const currentPassword = document.getElementById('current-password').value;
        const newPassword = document.getElementById('new-password').value;
        const confirmPassword = document.getElementById('confirm-password').value;

        if (newPassword !== confirmPassword) {
            alert('As senhas não coincidem!');
            return;
        }
        console.log('Alterando senha:', { currentPassword, newPassword });
        alert('Senha alterada com sucesso! (Simulação)');
    });

    // Adicionar Novo Administrador
    addAdminBtn.addEventListener('click', () => {
        const nome = newAdminName.value.trim();
        const email = newAdminEmail.value.trim();

        if (nome && email) {
            const newAdmin = {
                nome: nome,
                email: email,
                funcao: 'admin'
            };

            // Adiciona ao DOM
            const adminItem = document.createElement('div');
            adminItem.className = 'admin-item';
            adminItem.dataset.id = Date.now(); // ID temporário até salvar no backend
            adminItem.innerHTML = `<span>${newAdmin.nome} (${newAdmin.email})</span><button class="remove-btn">Remover</button>`;
            adminsList.appendChild(adminItem);

            // Remove a mensagem de "não há administradores"
            const noAdminsMessage = adminsList.querySelector('div:not(.admin-item)');
            if (noAdminsMessage) {
                noAdminsMessage.remove();
            }

            newAdminName.value = '';
            newAdminEmail.value = '';
        } else {
            alert('Preencha nome e e-mail.');
        }
    });

    // Adicionar Novo E-mail
    addEmailBtn.addEventListener('click', () => {
        const email = document.getElementById('new-email').value;
        if (email) {
            const id = Date.now(); // ID temporário
            const emailItem = document.createElement('div');
            emailItem.className = 'email-item';
            emailItem.dataset.id = id;
            emailItem.innerHTML = `
                <span>${email}</span>
                <button class="remove-btn">Remover</button>
            `;
            emailsList.appendChild(emailItem);
            const noEmailsMessage = emailsList.querySelector('div:not(.email-item)');
            if (noEmailsMessage) {
                noEmailsMessage.remove();
            }

            document.getElementById('new-email').value = ''; // Limpa o campo
        } else {
            alert('Preencha o e-mail!');
        }
    });

    // Remover Administradores ou E-mails
    [adminsList, emailsList].forEach(list => {
        list.addEventListener('click', (e) => {
            if (e.target.classList.contains('remove-btn')) {
                e.target.parentElement.remove();
            }
        });
    });

    // Salvar Tudo
    saveProfileBtn.addEventListener('click', () => {
        const profileData = {
            foto_perfil: document.getElementById('profile-pic-preview').src,
            senha: document.getElementById('new-password').value || undefined,
            admins: Array.from(adminsList.children).filter(item => item.classList.contains('admin-item')).map(item => {
                const span = item.querySelector('span');
                if (!span) {
                    console.warn('Span não encontrado em um item de admin:', item);
                    return null;
                }
                const text = span.textContent;
                return {
                    id: item.dataset.id,
                    nome: text.split(' (')[0],
                    email: text.match(/\(([^)]+)\)/)?.[1] || ''
                };
            }).filter(item => item !== null),
            emails_empresa: Array.from(emailsList.children)
                .filter(item => item.classList.contains('email-item'))
                .map(item => {
                    const span = item.querySelector('span');
                    if (!span) {
                        console.warn('Span não encontrado em um item de email:', item);
                        return null;
                    }
                    const text = span.textContent.trim(); // Remove espaços extras
                    return {
                        id: item.dataset.id,
                        email: text
                    };
                })
                .filter(item => item !== null),
            nome_exibicao: document.getElementById('display-name').value,
            admin_name: document.getElementById('admin-name').value,
            admin_email: document.getElementById('admin-email').value
        };

        // Simula uma chamada ao backend
        modalMessage.textContent = 'Salvando dados...';
        modal.show();

        // Envia os dados para o backend
        fetch('/admin/profile/updateProfile', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': csrfToken,
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify({ ...profileData, _csrf_token: csrfToken })
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
            console.log("Resposta do backend:", data); // Log para depuração
            if (data.success) {
                modalMessage.textContent = data.message || 'Perfil salvo com sucesso!';
                modalMessage.style.color = '#e0e0e0';

                // Atualiza a lista de e-mails
                emailsList.innerHTML = '';
                if (data.data.emails_empresa && data.data.emails_empresa.length > 0) {
                    console.log("E-mails a renderizar:", data.data.emails_empresa);
                    data.data.emails_empresa.forEach(email => {
                        const emailItem = document.createElement('div');
                        emailItem.className = 'email-item';
                        emailItem.dataset.id = email.id;
                        emailItem.innerHTML = `<span>${email.email}</span><button class="remove-btn">Remover</button>`;
                        emailsList.appendChild(emailItem);
                    });
                } else {
                    console.log("Nenhum e-mail retornado para renderizar.");
                    emailsList.innerHTML = '<div>Não há e-mails cadastrados</div>';
                }

                // Atualiza a lista de administradores
                adminsList.innerHTML = '';
                if (data.data.admins && data.data.admins.length > 0) {
                    console.log("Administradores a renderizar:", data.data.admins);
                    data.data.admins.forEach(admin => {
                        const adminItem = document.createElement('div');
                        adminItem.className = 'admin-item';
                        adminItem.dataset.id = admin.id;
                        adminItem.innerHTML = `<span>${admin.nome} (${admin.email})</span><button class="remove-btn">Remover</button>`;
                        adminsList.appendChild(adminItem);
                    });
                } else {
                    console.log("Nenhum administrador retornado para renderizar.");
                    adminsList.innerHTML = '<div>Não há administradores cadastrados para esse perfil</div>';
                }

                setTimeout(() => modal.hide(), 2000);
            } else {
                modalMessage.textContent = data.message || 'Erro ao salvar o perfil.';
                modalMessage.style.color = '#ff4d4d';
                setTimeout(() => modal.hide(), 2000);
            }
        })
        .catch(error => {
            modalMessage.textContent = `Erro na requisição: ${error.message}`;
            modalMessage.style.color = '#ff4d4d';
            console.error('Erro detalhado:', error);
            setTimeout(() => modal.hide(), 2000);
        });

        console.log('Perfil salvo:', profileData);
    });
}

initializeProfileManagement();