<h2 class="mb-4">Todos os Serviços</h2>

<table class="table table-striped">
    <thead>
        <tr>
            <th>Ícone</th>
            <th>Título</th>
            <th>Descrição</th>
        </tr>
    </thead>
    <tbody>
        {% foreach $servicos as $index => $item %}
            <tr>
                <td><i class="bi {{ $item['icone'] }}"></i></td>
                <td>{{ $item['titulo'] }}</td>
                <td>{{ $item['descricao'] }} </td>
            </tr>
        {% endforeach; %}
    </tbody>
</table>
