<style>
body {
    background: #141414;
    color: #CCC;
    font-family: Arial, sans-serif;
}

/* Mantém os cards do mesmo tamanho */
.service-card {
    background: #CCC;
    border-radius: 10px;
    padding: 20px;
    transition: 0.3s ease-in-out;
    cursor: pointer;
    box-shadow: 0 4px 10px rgba(255, 255, 255, 0.1);
    height: 100%; /* Faz todos os cards terem a mesma altura */
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.service-card:hover {
    background: #ECECEC;
    transform: scale(1.05);
}

/* Ícones dos serviços */
.service-icon {
    font-size: 2rem;
    color: #f39c12;
}
</style>

<div class="container mt-5 text-center">
    <h2 class="mb-4">Nossos Serviços</h2>
    <div class="row row-cols-1 row-cols-md-3 g-4"> 
        <?php
        $servicos = [
            ["icone" => "bi-file-earmark-text", "titulo" => "Análise de Propostas para Editais", "descricao" => "Revisão e análise detalhada de propostas para editais públicos e privados."],
            ["icone" => "bi-lightbulb", "titulo" => "Elaboração de Projetos", "descricao" => "Criação de projetos estratégicos e personalizados para seu negócio."],
            ["icone" => "bi-calendar-check", "titulo" => "Planejamento e Gerenciamento", "descricao" => "Organização e supervisão de projetos para garantir sua execução eficiente."],
            ["icone" => "bi-cash-coin", "titulo" => "Prestação de Contas", "descricao" => "Gestão financeira e transparência na prestação de contas."],
            ["icone" => "bi-mic", "titulo" => "Direção Artística e Produção Executiva", "descricao" => "Supervisão artística e logística para produções culturais e eventos."],
            ["icone" => "bi-megaphone", "titulo" => "Consultoria de Mídias e Redes Sociais", "descricao" => "Estratégias para crescimento orgânico e campanhas pagas eficientes."],
            ["icone" => "bi-newspaper", "titulo" => "Assessoria de Imprensa", "descricao" => "Divulgação estratégica para fortalecimento da marca na mídia."],
            ["icone" => "bi-instagram", "titulo" => "Gestão de Mídias (Instagram, etc.)", "descricao" => "Gerenciamento profissional de redes sociais para engajamento e conversão."]
        ];

        foreach ($servicos as $index => $servico): ?>
            <div class="col">
                <div class="card service-card p-3 text-center d-flex flex-column align-items-center">
                    <i class="bi <?php echo $servico['icone']; ?> service-icon"></i>
                    <h5 class="mt-3"><?php echo $servico['titulo']; ?></h5>
                    <p class="text-muted flex-grow-1"><?php echo $servico['descricao']; ?></p>
                    <button class="btn btn-primary mt-auto" data-bs-toggle="modal" data-bs-target="#modal<?php echo $index; ?>">Saiba Mais</button>
                </div>
            </div>

            <!-- Modal de detalhes -->
            <div class="modal fade" id="modal<?php echo $index; ?>" tabindex="-1" aria-labelledby="modalLabel<?php echo $index; ?>" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalLabel<?php echo $index; ?>"><?php echo $servico['titulo']; ?></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p><?php echo $servico['descricao']; ?></p>
                        </div>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</div>