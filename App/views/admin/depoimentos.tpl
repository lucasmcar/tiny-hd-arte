<h2 class="mb-4">Todos os Depoimentos</h2>

<table class="table table-striped">
    <thead>
        <tr>
            <th>Foto</th>
            <th>Nome</th>
            <th>Título</th>
            <th>Depoimento</th>
        </tr>
    </thead>
    <tbody>
        {% foreach $depoimentos as $index => $item %}
            <tr>
                <td><img src="{{ $item['foto'] }}" width="64" height="64"></i></td>
                <td>{{ $item['nome'] }}</td>
                <td>{{ $item['titulo'] }}</td>
                <td>{{ $item['depoimento'] }} </td>
            </tr>
        {% endforeach; %}
    </tbody>
</table>
