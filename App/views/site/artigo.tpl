<main class="article-page">
    <div class="article-container">
        <header class="article-header">
            <h1 class="article-title">{{ $article['title'] }}</h1>
            <p class="article-meta">Publicado em {{ $article['created_at'] }}</p>
        </header>
        <section class="article-content">
            {{ $article['content'] }}
        </section>
        <footer class="article-footer">
            <a href="/" class="btn btn-hda">Voltar para Home</a>
        </footer>
    </div>
</main>