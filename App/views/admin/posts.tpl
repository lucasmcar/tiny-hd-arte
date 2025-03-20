
    <style>
    /* Estilo da lista de posts */
        .posts-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .posts-list {
            list-style: none;
            padding: 0;
        }

        .post-link {
            display: block;
            padding: 15px;
            color: #e0e0e0;
            font-size: 1.1rem;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.3s ease, background 0.3s ease;
            border-bottom: 1px solid #333;
        }

        .post-link:hover {
            color: #e50914;
            background: #222;
        }

        /* Estilo dos detalhes do post */
        .post-details {
            max-width: 800px;
            margin: 0 auto;
            text-align: left;
            animation: fadeIn 0.5s ease-in;
        }

        .post-details img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .post-details h2 {
            font-size: 2rem;
            font-weight: 600;
            color: #fff;
            margin-bottom: 10px;
        }

        .post-details .date {
            font-size: 1rem;
            color: #e0e0e0;
            margin-bottom: 20px;
        }

        .post-details .btn {
            background: #e50914;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            text-transform: uppercase;
            transition: background 0.3s ease;
        }

        .post-details .btn:hover {
            background: #b20710;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
    <div class="posts-container">
        <h2>{{ $title }}</h2>
        <ul class="posts-list">
            {% foreach $posts as $index => $post %}
                <li><a href="#" class="post-link" data-post-id="{{ $post['id'] }}">{{ $post['titulo'] }}</a></li>
            {% endforeach; %}
        </ul>
    </div>

    <script>
    // Função para adicionar eventos aos links de posts
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
                fetch(`/admin/post/${postId}`, { headers: { "X-Requested-With": "XMLHttpRequest" } })
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
    
        
    </script>
    
