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
    @css(https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0)
    
    {{ $styles }}

    @js( 'https://cdn.tiny.cloud/1/e2ef7lxoq8ldecctbgxoj7caqa6wetrp2dve7j1z1h52b5j9/tinymce/7/tinymce.min.js' )
    <script>
  tinymce.init({
    selector: 'textarea',
    plugins: [
      // Core editing features
      'anchor', 'autolink', 'charmap', 'codesample', 'emoticons', 'image', 'link', 'lists', 'media', 'searchreplace', 'table', 'visualblocks', 'wordcount',
      // Your account includes a free trial of TinyMCE premium features
      // Try the most popular premium features until Mar 15, 2025:
      'checklist', 'mediaembed', 'casechange', 'export', 'formatpainter', 'pageembed', 'a11ychecker', 'tinymcespellchecker', 'permanentpen', 'powerpaste', 'advtable', 'advcode', 'editimage', 'advtemplate', 'ai', 'mentions', 'tinycomments', 'tableofcontents', 'footnotes', 'mergetags', 'autocorrect', 'typography', 'inlinecss', 'markdown','importword', 'exportword', 'exportpdf'
    ],
    toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | addcomment showcomments | spellcheckdialog a11ycheck typography | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
    tinycomments_mode: 'embedded',
    tinycomments_author: 'Author name',
    mergetags_list: [
      { value: 'First.Name', title: 'First Name' },
      { value: 'Email', title: 'Email' },
    ],
    ai_request: (request, respondWith) => respondWith.string(() => Promise.reject('See docs to implement AI Assistant')),
  });
</script>

    <title>{{ $title }}</title>
    <style>
    .main-content {
    flex: 1;
}

    </style>
</head>
<body>

    <main class="main-content">
        {{ $content }}
    </main>


    @js( 'https://code.jquery.com/jquery-3.6.0.min.js')
    @js( 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js' )
   
    
    {{ $scripts }}

    <script>
      
function loadPage(url) {
    fetch(url, {
        headers: { "X-Requested-With": "XMLHttpRequest" }
    })
    .then(response => response.text())
    .then(html => {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');

    

        // Atualiza o conteúdo do <main>
        const mainContent = doc.querySelector('main');
        if (mainContent) {
            document.getElementById('main-content').innerHTML = mainContent.innerHTML;
        }

        // Adicionar estilos sem duplicar
        doc.querySelectorAll("link[rel='stylesheet']").forEach(style => {
            if (!document.querySelector(`link[href="${style.href}"]`)) {
                document.head.appendChild(style.cloneNode(true));
            }
        });

        // Adicionar scripts sem duplicar
        doc.querySelectorAll("script").forEach(script => {
            if (script.src && !document.querySelector(`script[src="${script.src}"]`)) {
                const newScript = document.createElement("script");
                newScript.src = script.src;
                newScript.async = false;
                document.body.appendChild(newScript);
            } else if (!script.src) {
                eval(script.textContent);
            }
        });
    })
    .catch(error => console.error('Erro ao carregar a página:', error));
}

document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', function (event) {
            event.preventDefault();
            loadPage(`/admin/${this.getAttribute('data-page')}`);
        });
    });
});
    </script>
</body>
</html>