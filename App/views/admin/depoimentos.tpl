<section class="depoimentos-section">
    <div class="container">
        <div class="header-info">
            <h2 class="hda-title">{{ $title }}</h2>
            <p class="total-count">Total: {{ $totalDepoimentos }} depoimentos</p>
        </div>
        @csrf
        {% if $totalDepoimentos > 0 %}
            <div class="edital-table">
                <table>
                    <thead>
                        <tr>
                            <th>Foto</th>
                            <th>Nome</th>
                            <th>Título</th>
                            <th>Depoimento</th>
                            <th>Ação</th>
                        </tr>
                    </thead>
                    <tbody id="depoimento-list">
                        {% foreach $depoimentos as $index => $item %}
                            <tr data-id="{{ $item['id'] }}">
                                <td><img src="{{ $item['foto'] }}" width="64" height="64" class="rounded-circle"></td>
                                <td>{{ $item['nome'] }}</td>
                                <td>{{ $item['titulo'] }}</td>
                                <td>{{ $item['depoimento'] }}</td>
                                <td>
                                    <a href="#" class="action-btn delete-btn" data-id="{{ $item['id'] }}"><i class="bi bi-trash"></i> Excluir</a>
                                </td>
                            </tr>
                        {% endforeach; %}
                    </tbody>
                </table>
                <div id="no-depoimentos" style="display: none;">Nenhum depoimento disponível.</div>
            </div>
            {% if $totalPaginas > 1 %}
                <div class="pagination-netflix">
                    {% if $paginaAtual > 1 %}
                        <a href="#pagina={{ $paginaAtual - 1 }}" class="pagination-btn">Anterior</a>
                    {% endif; %}
                    @for( 1, $totalPaginas, $i ) 
                        <a href="#pagina={{ $i }}" class="pagination-btn {% if $i == $paginaAtual %}active{% endif; %}">{{ $i }}</a>
                    @endfor()
                    {% if $paginaAtual < $totalPaginas %}
                        <a href="#pagina={{ $paginaAtual + 1 }}" class="pagination-btn">Próximo</a>
                    {% endif; %}
                </div>
            {% endif; %}
        {% else %}
            <p class="empty-list">Nenhum depoimento encontrado.</p>
        {% endif; %}
    </div>
</section>