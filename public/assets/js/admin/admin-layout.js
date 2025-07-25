document.addEventListener('DOMContentLoaded', function () {
    if (window.location.pathname === '/admin/login') {
        fabToggle.setAttribute("hidden");
        const sessionTimer = document.getElementById('session-timer');
        if (sessionTimer) sessionTimer.classList.add('hidden');
        return;
    }

    if (!isLoggedIn || tokenExpiry === 0) {
        const sessionTimer = document.getElementById('session-timer');
        if (sessionTimer) sessionTimer.classList.add('hidden');
        return;
    }

    const timerElement = document.getElementById('timer');
    const modalTimerElement = document.getElementById('modal-timer');
    const sessionExpiryModal = new bootstrap.Modal(document.getElementById('session-expiry-modal'), {
        backdrop: 'static',
        keyboard: false
    });

    const now = Math.floor(Date.now() / 1000);
    let timeLeft = tokenExpiry - now;
    let isLoggingOut = false;
    let modalTimerInterval;

    function formatTime(seconds) {
        const hours = Math.floor(seconds / 3600);
        const minutes = Math.floor((seconds % 3600) / 60);
        const secs = seconds % 60;
        return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
    }

    function logout() {
        if (isLoggingOut) return;
        isLoggingOut = true;
        fetch('/admin/logout', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('input[name="_csrf_token"]')?.value
            }
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    localStorage.removeItem('jwt');
                    sessionStorage.removeItem('jwt');
                    window.location.href = '/admin/login?loggedOut=true';
                } else {
                    console.error('Erro ao fazer logout:', data.message);
                    window.location.href = '/admin/login?loggedOut=true';
                }
            })
            .catch(error => {
                console.error('Erro ao fazer logout:', error);
                window.location.href = '/admin/login?loggedOut=true';
            });
    }

    const timerInterval = setInterval(() => {
        timeLeft--;
        timerElement.textContent = formatTime(timeLeft);

        if (timeLeft === 300) {
            sessionExpiryModal.show();
            let modalTimeLeft = 300;
            modalTimerInterval = setInterval(() => {
                modalTimeLeft--;
                modalTimerElement.textContent = formatTime(modalTimeLeft);
                if (modalTimeLeft <= 0) clearInterval(modalTimerInterval);
            }, 1000);
        }

        if (timeLeft <= 0) {
            clearInterval(timerInterval);
            logout();
        }
    }, 1000);

    timerElement.textContent = formatTime(timeLeft);

    // Toggle Sidebar
    const sidebar = document.getElementById('sidebar');
    const toggleBtn = document.getElementById('toggle-sidebar');
    const mainContent = document.getElementById('main-content');

    toggleBtn.addEventListener('click', () => {
        sidebar.classList.toggle('active');
        mainContent.classList.toggle('shifted');
        toggleBtn.setAttribute('aria-expanded', sidebar.classList.contains('active'));
    });

    // Accordion Menu
    document.querySelectorAll('.accordion-toggle').forEach(item => {
        item.addEventListener('click', (e) => {
            e.preventDefault();
            const menu = item.nextElementSibling;
            const isActive = menu.classList.contains('active');
            document.querySelectorAll('.accordion-menu').forEach(m => m.classList.remove('active'));
            document.querySelectorAll('.accordion-toggle').forEach(t => t.classList.remove('active'));
            if (!isActive) {
                item.classList.add('active');
                menu.classList.add('active');
            }
            item.setAttribute('aria-expanded', !isActive);
        });
    });
});

const menuData = [
        {
            label: "Dashboard",
            icon: "bi-house-door",
            route: "/admin/dashboard"
        },
        {
            label: "Consultoria",
            icon: "bi-briefcase",
            submenu: [
                { label: "Cadastro", route: "/consultoria" },
                { label: "Registros", route: "/consultoria/lista" }
            ]
        },
        {
            label: "Equipe",
            icon: "bi-person-vcard-fill",
            submenu: [
                { label: "Cadastro", route: "/equipe/cadastro" },
                { label: "Registros", route: "/equipe/lista" }
            ]
        },
        {
            label: "Destão de Projetos",
            icon: "bi-tools",
            submenu: [
                {label: "Cadastros", icon:"bi-clipboard-data", route: "projetos-culturais",},
                {label: "Registros", icon: "bi-list",route: "projetos-culturais/listaProjetos",},
                {label: "Projetos Em Captação", icon: "bi-plus-circle", route: "projetos-captacao"},
            ]

        }


            
    ];

    const fabToggle = document.getElementById("fab-menu-toggle");
    const fabSidebar = document.getElementById("fab-sidebar");
    const fabIcon = document.getElementById("fab-icon");
    const menuContainer = document.getElementById("fab-menu-items");

    let isSidebarOpen = false;

    fabToggle.addEventListener("click", () => {
        isSidebarOpen = !isSidebarOpen;
        fabSidebar.classList.toggle("open", isSidebarOpen);
        fabSidebar.setAttribute("aria-hidden", !isSidebarOpen);
        fabIcon.className = isSidebarOpen ? "bi bi-x" : "bi bi-list";
    });

    function createMenu() {
        menuData.forEach(item => {
            const li = document.createElement("li");

            if (item.submenus) {
    li.innerHTML = `
      <a href="#" class="menu-item has-submenu">
        <i class="${item.icon}"></i>
        ${item.label}
        <span class="submenu-toggle">+</span>
      </a>
      <ul class="submenu">
        ${item.submenus.map(sub => `
          <li>
            <a href="${sub.link}">
              <i class="${sub.icon}"></i> ${sub.label}
            </a>
          </li>
        `).join('')}
      </ul>
    `;
  } else {
    li.innerHTML = `
      <a href="${item.link}" class="menu-item">
        <i class="${item.icon}"></i>
        ${item.label}
      </a>
    `;
  }

            menuContainer.appendChild(li);
        });
    }

    document.addEventListener("DOMContentLoaded", createMenu);