<style>
body {
    background: #141414;
    color: #fff;
    font-family: 'Montserrat', sans-serif;
}

/* Ajuste para o conteúdo ficar abaixo do navbar */
.hda-section {
    padding-top: 100px; /* Espaço para o navbar fixo - ajuste conforme a altura real */
}

/* Estilo dos cards inspirado na hda */
.service-card {
    background: #222;
    border-radius: 8px;
    padding: 15px;
    transition: transform 0.3s ease-in-out;
    cursor: pointer;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    position: relative;
    overflow: hidden;
}

.service-card:hover {
    transform: scale(1.05);
    background: #333;
}

.service-icon {
    font-size: 3rem;
    color: #e50914; /* Vermelho hda */
    margin-bottom: 15px;
}

h2 {
    font-size: 2rem;
    font-weight: 600;
    margin-bottom: 30px;
    color: #fff;
}

h5 {
    font-size: 1.2rem;
    font-weight: 500;
    color: #fff;
}

.text-muted {
    color: #aaa !important;
    font-size: 0.9rem;
}

.btn-hda {
    background-color: #e50914;
    border: none;
    padding: 8px 20px;
    font-size: 1rem;
    transition: background-color 0.3s;
}

.btn-hda:hover {
    background-color: #f40612;
}

/* Modal estilizado */
.modal-content {
    background: #222;
    color: #fff;
    border: none;
    border-radius: 8px;
}

.modal-header {
    border-bottom: 1px solid #333;
}

.modal-title {
    color: #fff;
}

.btn-close {
    filter: invert(1); /* Torna o botão de fechar branco */
}
</style>

<div class="container mt-5 text-center hda-section">
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
                    <button class="btn btn-hda mt-auto" data-bs-toggle="modal" data-bs-target="#modal<?php echo $index; ?>">Saiba Mais</button>
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