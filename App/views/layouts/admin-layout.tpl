<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Compiled and minified CSS -->
    @css(https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css)
    @css(https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css)
    @css(https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css)
    @css(/assets/css/main.css)
    @css(https://fonts.googleapis.com/icon?family=Material+Icons)
    @css(/assets/ckeditor/ckeditor5.css)
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
  
    <title>{{ $title }}</title>
    <style>
    .main-content {
    flex: 1;
}

/* Estiliza o footer */
.footer {
    background-color: #222;
    color: white;
    text-align: center;
    padding: 20px;
    width: 100%;
}
    </style>
</head>
<body>

    <main class="main-content">
        {{ $content }}
    </main>


    @js( 'https://code.jquery.com/jquery-3.6.0.min.js')
    @js( 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js' )
    @js( '/assets/ckeditor/ckeditor5.js' )

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Captura todos os links do sidenavbar
            const links = document.querySelectorAll('.nav-link');


            // Adiciona o evento de clique a cada link
            links.forEach(link => {
                link.addEventListener('click', function(event) {
                    event.preventDefault();
                    const page = this.getAttribute('data-page');

                    console.log(page)

                    // Faz a requisição AJAX para carregar o conteúdo
                    fetch(`/admin/${page}`, {
                        headers: {
                            'X-Requested-With': 'XMLHttpRequest'
                        }
                    })
                    .then(response => response.text())
                    .then(html => {
                        // Insere o conteúdo retornado no container principal
                        document.getElementById('main-content').innerHTML = html;
                    })
                    .catch(error => console.error('Erro ao carregar a página:', error));
                });
            });
        });
    </script>
    
</body>
</html>