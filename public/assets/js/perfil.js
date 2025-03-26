console.log('Script gerenciar-perfil.js carregado com sucesso!');

function initializeProfileManagement() {
    const profilePicPreview = document.getElementById('profile-pic-preview');
    const profilePicUpload = document.getElementById('profile-pic-upload');
    const uploadProfilePicBtn = document.getElementById('upload-profile-pic');
    const changePasswordBtn = document.getElementById('change-password-btn');
    const addAdminBtn = document.getElementById('add-admin-btn');
    const addEmailBtn = document.getElementById('add-email-btn');
    const saveProfileBtn = document.getElementById('saveProfileBtn');
    const adminsList = document.getElementById('admins-list');
    const emailsList = document.getElementById('emails-list');

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
        const name = document.getElementById('new-admin-name').value;
        const email = document.getElementById('new-admin-email').value;
        if (name && email) {
            const id = Date.now(); // ID temporário
            const adminItem = document.createElement('div');
            adminItem.className = 'admin-item';
            adminItem.dataset.id = id;
            adminItem.innerHTML = `
                <span>${name} (${email})</span>
                <button class="remove-btn">Remover</button>
            `;
            adminsList.appendChild(adminItem);
            document.getElementById('new-admin-name').value = '';
            document.getElementById('new-admin-email').value = '';
        } else {
            alert('Preencha nome e e-mail!');
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
                <input type="email" value="${email}" class="email-input">
                <button class="remove-btn">Remover</button>
            `;
            emailsList.appendChild(emailItem);
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
            foto_perfil: profilePicPreview.src,
            senha: document.getElementById('new-password').value || undefined,
            admins: Array.from(adminsList.children).map(item => ({
                id: item.dataset.id,
                nome: item.querySelector('span').textContent.split(' (')[0],
                email: item.querySelector('span').textContent.match(/\(([^)]+)\)/)[1]
            })),
            emails_empresa: Array.from(emailsList.children).map(item => ({
                id: item.dataset.id,
                email: item.querySelector('.email-input').value
            })),
            nome_exibicao: document.getElementById('display-name').value
        };

        console.log('Perfil salvo:', profileData);
        alert('Perfil salvo com sucesso! (Simulação)');
    });
}

initializeProfileManagement();