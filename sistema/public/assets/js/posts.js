

const mainContent = document.querySelector("#main-content");

function attachPostEvents() {
    document.querySelectorAll('.post-link').forEach(link => {
        link.addEventListener('click', function (event) {
            event.preventDefault();
            const postId = this.getAttribute('data-post-id');
            loadPostDetails(postId);
        });
    });
}


function loadPostDetails(postId) {
    document.getElementById('loading').style.display = 'block';
    fetch(`/admin/posts/${postId}`, { headers: { "X-Requested-With": "XMLHttpRequest" } })
        .then(response => response.json()) 
        .then(data => {
            mainContent.innerHTML = `
                <div class="post-details">
                    <img src="${data.image || 'https://via.placeholder.com/800x300'}" alt="${data.titulo}">
                    <h2>${data.titulo}</h2>
                    <p class="date">Publicado em: ${data.created_at}</p>
                    <a href="/admin/posts/${postId}" class="btn">Saiba Mais</a>
                </div>
            `;
            document.getElementById('loading').style.display = 'none';
        })
        .catch(error => {
            console.error('Erro ao carregar detalhes do post:', error);
            mainContent.innerHTML = '<p>Erro ao carregar o post.</p>';
            document.getElementById('loading').style.display = 'none';
        });
}



attachPostEvents();