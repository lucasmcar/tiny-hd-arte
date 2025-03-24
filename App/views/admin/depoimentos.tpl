<section class="depoimentos-section">
    <div class="container">
        <div class="header-info">
            <h2 class="hda-title">Todos os Depoimentos</h2>
            <p class="total-count">Total: {{ $totalDepoimentos }} depoimentos</p>
        </div>
        {% if $totalDepoimentos > 0 %}
            <div class="custom-table">
                <div class="table-header">
                    <div class="table-cell">Foto</div>
                    <div class="table-cell">Nome</div>
                    <div class="table-cell">Título</div>
                    <div class="table-cell">Depoimento</div>
                    <div class="table-cell">Ação</div>
                </div>
                {% foreach $depoimentos as $index => $item %}
                    <div class="table-row">
                        <div class="table-cell"><img src="{{ $item['foto'] }}" width="64" height="64" class="rounded-circle"></div>
                        <div class="table-cell">{{ $item['nome'] }}</div>
                        <div class="table-cell">{{ $item['titulo'] }}</div>
                        <div class="table-cell">{{ $item['depoimento'] }}</div>
                        <div class="table-cell">
                            <a href="/admin/excluir/depoimento/{{ $item['id'] }}" class="action-btn delete-btn"><i class="bi bi-trash"></i> Excluir</a>
                        </div>
                    </div>
                {% endforeach; %}
            </div>

            {% if $totalPaginas > 1 %}
                <div class="pagination-netflix">
                    {% if $paginaAtual > 1 %}
                        <a href="/admin/todos/depoimentos?pagina={{ $paginaAtual - 1 }}" class="pagination-btn">Anterior</a>
                    {% endif; %}
                    @for( 1, $totalPaginas, $i ) 
                        <a href="/admin/todos/depoimentos?pagina={{ $i }}" class="pagination-btn {% if $i == $paginaAtual %}active{% endif; %}">{{ $i }}</a>
                    @endfor()
                    {% if $paginaAtual < $totalPaginas %}
                        <a href="/admin/todos/depoimentos?pagina={{ $paginaAtual + 1 }}" class="pagination-btn">Próximo</a>
                    {% endif; %}
                </div>
            {% endif; %}
        {% else %}
            <p class="empty-list">Nenhum depoimento encontrado.</p>
        {% endif; %}
    </div>
</section>