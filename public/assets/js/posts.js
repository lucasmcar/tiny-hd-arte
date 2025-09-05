

// Evita redeclaração de mainContent
if (typeof window.mainContent === 'undefined') {
    window.mainContent = document.querySelector("#main-content");
}

// Função para carregar a lista de posts
function loadPostList() {
    if (!window.mainContent) {
        console.error('Elemento #main-content não encontrado!');
        return;
    }

    document.getElementById('loading').style.display = 'block';
    fetch('/admin/posts', { headers: { "X-Requested-With": "XMLHttpRequest" } })
        .then(response => response.text()) // Assume HTML da lista
        .then(html => {
            window.mainContent.innerHTML = html;
            document.getElementById('loading').style.display = 'none';
        })
        .catch(error => {
            console.error('Erro ao carregar a lista de posts:', error);
            window.mainContent.innerHTML = '<p>Erro ao carregar a lista.</p>';
            document.getElementById('loading').style.display = 'none';
        });
}

// Função para carregar detalhes do post
function loadPostDetails(postId) {
    if (!window.mainContent) {
        console.error('Elemento #main-content não encontrado!');
        return;
    }

    document.getElementById('loading').style.display = 'block';
    fetch(`/admin/posts/${postId}`, { headers: { "X-Requested-With": "XMLHttpRequest" } })
        .then(response => response.json())
        .then(data => {
            window.mainContent.innerHTML = `
                <div class="post-details">
                    <img src="${data.image || 'https://via.placeholder.com/800x300'}" alt="${data.titulo}">
                    <h2>${data.titulo}</h2>
                    <p class="date">Publicado em: ${data.created_at}</p>
                    <a href="/admin/posts" class="btn back-btn">Voltar à Lista</a>
                </div>
            `;
            document.getElementById('loading').style.display = 'none';
        })
        .catch(error => {
            console.error('Erro ao carregar detalhes do post:', error);
            window.mainContent.innerHTML = '<p>Erro ao carregar o post.</p>';
            document.getElementById('loading').style.display = 'none';
        });
}

// Configura delegação de eventos uma única vez
function setupEventDelegation() {
    if (!window.postsEventsSetup) {
        window.mainContent.addEventListener('click', (event) => {
            // Verifica se o clique é em um elemento relevante
            const postLink = event.target.closest('.post-link');
            const backBtn = event.target.closest('.back-btn');

            if (postLink) {
                event.preventDefault();
                const postId = postLink.getAttribute('data-post-id');
             
                loadPostDetails(postId);
            } else if (backBtn) {
                event.preventDefault();
             
                loadPostList();
            }
        });
        window.postsEventsSetup = true;
    }
}

// Inicializa apenas se ainda não foi inicializado
if (!window.postsInitialized) {
    if (window.mainContent) {
        setupEventDelegation();
        window.postsInitialized = true;
    } else {
        console.error('Elemento #main-content não encontrado na inicialização!');
    }
}