<div class="consultoria-container">
    <h2>{{ $title }}</h2>
    <div class="client-list">
        {% if empty($clientes) %}
            <p class="no-clients">Nenhum cliente cadastrado.</p>
        {% else %}
            <table class="client-table">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Tipo de Cliente</th>
                        <th>Contato</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    {% foreach $clientes as $index => $cliente %}
                        <tr>
                            <td>{{ htmlspecialchars($cliente['nome']) }}</td>
                            <td>{{ htmlspecialchars($cliente['tipo_cliente']) }}</td>
                            <td>{{ htmlspecialchars($cliente['contato']) }}</td>
                            <td>
                                <a href="/admin/consultoria/clientProfile?id=<?= $cliente['id'] ?>" class="view-profile-btn">Ver Perfil</a>
                            </td>
                        </tr>
                    {% endforeach; %}
                </tbody>
            </table>
        {% endif; %}
        <a data-url="/admin/consultoria" class="back-button">Voltar para Cadastro</a>
    </div>
</div>