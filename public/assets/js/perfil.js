

function initializeProfileManagement() {
    const profilePicPreview = document.getElementById('profile-pic-preview');
    const profilePicUpload = document.getElementById('profile-pic-upload');
    const uploadProfilePicBtn = document.getElementById('upload-profile-pic');
    const changePasswordBtn = document.getElementById('change-password-btn');
    const addAdminBtn = document.getElementById('add-admin-btn');
    const addEmailBtn = document.getElementById('add-email-btn');
    const newAdminName = document.getElementById('new-admin-name');
    const newAdminEmail = document.getElementById('new-admin-email');
    const newAdminSenha = document.getElementById('new-admin-senha');
    const saveProfileBtn = document.getElementById('saveProfileBtn');
    const adminsList = document.getElementById('admins-list');
    const emailsList = document.getElementById('emails-list');
    const modal = new bootstrap.Modal(document.getElementById('saveProfileModal'));
    const modalMessage = document.getElementById('modalMessage');

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

        alert('Senha alterada com sucesso! (Simulação)');
    });

    // Adicionar Novo Administrador
    addAdminBtn.addEventListener('click', () => {
        const nome = newAdminName.value.trim();
        const email = newAdminEmail.value.trim();
        const senha = newAdminSenha.value.trim();

        if (nome && email) {
            const newAdmin = { nome, email, senha: senha || undefined };
            const adminItem = document.createElement('div');
            adminItem.className = 'admin-item';
            adminItem.dataset.id = Date.now();
            adminItem.innerHTML = `
                <span>${newAdmin.nome} (${newAdmin.email})</span>
                <button class="remove-btn">Remover</button>
            `;
            adminsList.appendChild(adminItem);

            const noAdminsMessage = adminsList.querySelector('div:not(.admin-item)');
            if (noAdminsMessage) noAdminsMessage.remove();

            newAdminName.value = '';
            newAdminEmail.value = '';
            newAdminSenha.value = '';
        } else {
            alert('Preencha nome e e-mail.');
        }
    });

    // Adicionar Novo E-mail
    addEmailBtn.addEventListener('click', () => {
        const email = document.getElementById('new-email').value.trim();
        if (email) {
            const emailItem = document.createElement('div');
            emailItem.className = 'email-item';
            emailItem.dataset.id = Date.now();
            emailItem.innerHTML = `<span>${email}</span><button class="remove-btn">Remover</button>`;
            emailsList.appendChild(emailItem);

            const noEmailsMessage = emailsList.querySelector('div:not(.email-item)');
            if (noEmailsMessage) noEmailsMessage.remove();

            document.getElementById('new-email').value = '';
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
            nome_exibicao: document.getElementById('display-name').value,
            admin_name: document.getElementById('admin-name').value,
            admin_email: document.getElementById('admin-email').value,
            foto_perfil: document.getElementById('profile-pic-preview').src,
            admins: Array.from(adminsList.children)
                .filter(item => item.classList.contains('admin-item'))
                .map(item => {
                    const span = item.querySelector('span');
                    if (!span) return null;
                    const [nome, emailPart] = span.textContent.split(' (');
                    const email = emailPart ? emailPart.replace(')', '') : '';
                    return { id: item.dataset.id, nome, email };
                })
                .filter(item => item !== null),
            emails_empresa: Array.from(emailsList.children)
                .filter(item => item.classList.contains('email-item'))
                .map(item => {
                    const span = item.querySelector('span');
                    if (!span) return null;
                    return { id: item.dataset.id, email: span.textContent.trim() };
                })
                .filter(item => item !== null)
        };

        modalMessage.textContent = 'Salvando dados...';
        modal.show();

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
            if (!response.ok) throw new Error(`Erro HTTP ${response.status}`);
            return response.json();
        })
        .then(data => {
            if (data.success) {
                modalMessage.textContent = data.message || 'Perfil salvo com sucesso!';
                modalMessage.style.color = '#e0e0e0';
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

       
    });
}

initializeProfileManagement();