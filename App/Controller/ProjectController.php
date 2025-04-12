<?php

namespace App\Controller;


use App\Core\View\View;

class ProjectController
{

    public function index()
    {
        // Lista de projetos (simulação - substitua por um repositório real)
        $projects = $this->fetchAllProjects();

        // Projetos em destaque (os mais importantes)
        $featuredProjects = array_filter($projects, function ($project) {
            return isset($project['is_featured']) && $project['is_featured'];
        });

        // Todos os projetos (exclui duplicatas se desejar)
        $allProjects = $projects;

        $data = [
            'title' => 'Projetos e Eventos Realizados',
            'featured_projects' => $featuredProjects,
            'all_projects' => $allProjects
        ];

        $styles = ['/assets/css/all-projects.css'];
        $scripts = []; // Para interatividade, se necessário

        return new View('site/projetos', $data, $styles);
    }
    public function show($params)
    {
        $slug = $params[0] ?? '';

        $project = $this->fetchProjectBySlug($slug);
        if (!$project) {
            http_response_code(404);
            return new View('errors/404', ['title' => 'Projeto Não Encontrado'], [], [], 'main-layout');
        }

        $data = [
            'title' => $project['title'],
            'project' => $project
        ];

        $styles = ['/assets/css/project.css'];
        $scripts = [];

        return new View('site/projects', $data, $styles, $scripts);
    }

    private function fetchProjectBySlug($slug)
    {
        $projects = [
            'festa-junina-2025' => [
                'title' => 'Festa Junina de Porto Alegre 2025',
                'description' => 'Uma das maiores festas culturais do estado.',
                'image' => '/assets/imgs/festa-junina-2025.jpg',
                'details' => 'Realizada em Junho de 2025.',
                'author' => 'João Silva',
                'post_date' => '2025-03-15',
                'content' => 'A Festa Junina de Porto Alegre 2025 foi um marco cultural, reunindo milhares de pessoas em uma celebração vibrante. Com apresentações de quadrilhas, shows de artistas locais e uma variedade de comidas típicas, o evento destacou a riqueza da tradição gaúcha. O planejamento começou meses antes, com captação de recursos via editais culturais.',
                'extra_image' => '/assets/imgs/festa-junina-2025-extra.jpg',
                'sponsors' => [
                    ['logo' => '/assets/imgs/logo1.jpg', 'name' => 'Patrocinador 1'],
                    ['logo' => '/assets/imgs/logo1.jpg', 'name' => 'Patrocinador 2'],
                ]
            ],

            'festival-musica-2024' => [
                'title' => 'Festival de Música 2024',
                'description' => 'Evento nacional com artistas renomados.',
                'image' => '/assets/imgs/festival-musica-2024.jpg',
                'details' => 'Ocorrido em Agosto de 2024.',
                'author' => 'Maria Oliveira',
                'post_date' => '2024-09-01',
                'content' => 'O Festival de Música 2024 trouxe ao palco grandes nomes da música brasileira, como Anitta e Jorge Ben Jor. Realizado em São Paulo, o evento contou com uma produção impecável e um público de mais de 10.000 pessoas. A HD Arte foi responsável pela gestão financeira e logística, garantindo o sucesso do festival.',
                'extra_image' => '/assets/imgs/festival-musica-2024-extra.jpg',
                'sponsors' => [
                    ['logo' => '/assets/imgs/logo1.jpg', 'name' => 'Patrocinador 1'],
                    ['logo' => '/assets/imgs/logo1.jpg', 'name' => 'Patrocinador 2'],
                ]
            ],

            'show-local-2023' => [
                'title' => 'Show local 2023',
                'description' => 'Evento local de 2023 com artistas renomados.',
                'image' => '/assets/imgs/show-local-2023.jpg',
                'details' => 'Ocorrido em Agosto de 2023.',
                'author' => 'Maria Paula',
                'post_date' => '2023-10-01',
                'content' => 'O festival local que ocorreu em agosto desse mes, trouxe grandes convidados da música nacional e também mostrou ao público revelações locais.',
                'extra_image' => '/assets/imgs/festival-musica-2024-extra.jpg',
                'sponsors' => [
                    ['logo' => '/assets/imgs/logo1.jpg', 'name' => 'Patrocinador 1'],
                    ['logo' => '/assets/imgs/logo1.jpg', 'name' => 'Patrocinador 2'],
                ]
            ],

            'circuito-urbano-restinga' => [
                'title' => 'Circuito Urbano Na Restinga 2025',
                'description' => 'Projeto de Cultura Hip Hop.',
                'image' => '/assets/imgs/cur.jpg',
                'details' => 'Será realizado em Maio de 2025, nos dias 2, 3 e 4',
                'author' => 'Michelle Rodrigues',
                'post_date' => '2025-03-15',
                'content' => 'O Circuito Urbano na Restinga 2025 é um projeto que visa promover a cultura Hip Hop na região da Restinga, em Porto Alegre. Com oficinas, shows e intervenções artísticas, o evento busca valorizar a produção cultural local e incentivar a participação da comunidade. A HD Arte é parceira nessa iniciativa, contribuindo com a produção e divulgação do projeto.',
                'extra_image' => '/assets/imgs/cur-extra.jpg',
                'sponsors' => [
                    ['logo' => '/assets/imgs/logo1.jpg', 'name' => 'Patrocinador 1'],
                    ['logo' => '/assets/imgs/logo1.jpg', 'name' => 'Patrocinador 2'],
                ]
            ],
            'campanha-pre-lancamento' => [
                'title' => 'Pré-lançamento de Campanha de Financiamento Coletivo',
                'description' => 'Campanha de financiamento coletivo na plataforma Benfeitoria.',
                'image' => '/assets/imgs/otto.jpg',
                'details' => 'Será realizado, amanhã dia 12 de Abril',
                'author' => 'HD Arte',
                'post_date' => '2025-04-11',
                'content' => '
                    <div class="campaign-content">
                        <h3 class="campaign-title">🎶 A MÚSICA NÃO PARA — E VOCÊ PODE FAZER PARTE DESSA HISTÓRIA! 🎤</h3>
                        <p class="hda-text">Otto Gomes, cantor e compositor com mais de 30 anos de trajetória, está lançando seu novo EP autoral com 5 faixas inéditas e 3 videoclipes incríveis! Esse projeto marca um novo momento em sua carreira solo, e você pode ajudar a transformar esse sonho em realidade. 🙌</p>

                        <p class="hda-text">💥 Essa é uma campanha de financiamento coletivo na plataforma Benfeitoria! Otto quer expandir sua música, fortalecer sua identidade artística e levar sua arte a mais pessoas – mas para isso, ele precisa de você.</p>

                        <p class="hda-text">👨‍👧‍👦 Pai de 5 filhos e com uma história marcada por dedicação à música, Otto acredita no poder da arte para transformar vidas – inclusive a dele e a de quem ouve.</p>

                        <h4 class="campaign-subtitle">✨ Tem recompensas lindas pra quem apoiar!</h4>
                        <p class="hda-text">Ajude e ainda ganhe experiências exclusivas, conteúdos especiais e muito mais!</p>

                        <h4 class="campaign-subtitle">📲 Acesse agora e contribua:</h4>
                        <ul class="campaign-links">
                            <li><a href="https://www.benfeitoria.com/ottogomes" target="_blank" class="btn btn-hda">Apoie na Benfeitoria 👉</a></li>
                            <li><span class="link-label">📸 Siga e compartilhe:</span> <a href="https://www.instagram.com/ottogomesmusic" target="_blank" class="campaign-link">@ottogomesmusic</a></li>
                            <li><span class="link-label">🌐 Saiba mais em:</span> <a href="https://www.hdarte.com.br" target="_blank" class="campaign-link">www.hdarte.com.br</a></li>
                            <li><span class="link-label">📧 Contato:</span> <a href="mailto:hdarteprodutora@hdarte.com.br" class="campaign-link">hdarteprodutora@hdarte.com.br</a></li>
                        </ul>

                        <h4 class="campaign-subtitle">📢 Como você pode ajudar (além de contribuir):</h4>
                        <ul class="campaign-actions">
                            <li>✅ Compartilhe com seus amigos e grupos!</li>
                            <li>✅ Envie para aquela pessoa que ama música e valoriza a arte local!</li>
                            <li>✅ Poste nas suas redes com a hashtag <strong>#OttoGomesNaBenfeitoria</strong></li>
                        </ul>

                        <p class="hda-text campaign-cta">Vamos juntos fazer esse projeto acontecer? 💛</p>
                    </div>
                ',
                'extra_image' => '/assets/imgs/otto-extra.jpg',
                'sponsors' => []
            ]
        ];


        return $projects[$slug] ?? null;
    }

    public function approved()
    {
        $projects = $this->fetchAllProjects();
        $approvedProjects = array_filter($projects, function ($project) {
            return $project['status'] === 'approved';
        });
        return $this->renderProjects('Projetos Aprovados', $approvedProjects);
    }

    public function ongoing()
    {
        $projects = $this->fetchAllProjects();
        $ongoingProjects = array_filter($projects, function ($project) {
            return $project['status'] === 'ongoing';
        });
        return $this->renderProjects('Projetos em Andamento', $ongoingProjects);
    }

    private function fetchAllProjects()
    {

        /* 'Territórios Criativos - SEDAC RS 2025
RS - Seguro Circuito Urbano na Restinga - Projeto de Cultura Hip Hop
Projeto PNAB 32/RS Música - Memória Popular 4 Edições
Festival Zumbi PNAB RS - Festivais e Mostras
PNAB POA - LIGA dos Blocos de Carnaval de Rua Descentralizados de Porto Alegre e RS
Nossa Arte Circula RS 2024 - 2 Projetos Contemplados
Especial Luiz Melodia de Paulo Dionísio e Gilberto Oliveira
Meu Canto de Luciara Batista
Arte Negra do Sul Edição 2025 - Roaunet';*/

        return [
            'circuito-urbano-restinga' => [
                'title' => 'Circuito Urbano na Restinga 2025',
                'slug' => 'circuito-urbano-restinga',
                'description' => 'Projeto de Cultura Hip Hop.',
                'short_description' => 'Rio Grande do Sul, 2025 - Público: a estimar',
                'image' => '/assets/imgs/cur-extra.jpg',
                'video' => '/assets/imgs/cur.mp4',
                'is_featured' => true,
                'status' => 'ongoing' // Aprovado
            ],
            'festa-junina-2025' => [
                'title' => 'Festa Junina de Porto Alegre 2025',
                'slug' => 'festa-junina-2025',
                'description' => 'Uma das maiores festas culturais do estado.',
                'short_description' => 'Porto Alegre, 2025 - Público: 5.000',
                'image' => '/assets/imgs/festa-junina-2025.jpg',
                'video' => '/assets/videos/festa-junina-2025-trailer.mp4',
                'is_featured' => true,
                'status' => 'approved' // Aprovado
            ],
            'festival-musica-2024' => [
                'title' => 'Festival de Música 2024',
                'slug' => 'festival-musica-2024',
                'description' => 'Evento nacional com artistas renomados.',
                'short_description' => 'São Paulo, 2024 - Público: 10.000',
                'image' => '/assets/imgs/festival-musica-2024.jpg',
                'video' => null,
                'is_featured' => true,
                'status' => 'approved' // Aprovado
            ],
            'show-local-2023' => [
                'title' => 'Show Local 2023',
                'slug' => 'show-local-2023',
                'description' => 'Evento comunitário com artistas locais.',
                'short_description' => 'Curitiba, 2023 - Público: 2.000',
                'image' => '/assets/imgs/show-local-2023.jpg',
                'video' => null,
                'is_featured' => false,
                'status' => 'approved' // Em andamento
            ],
            'campanha-pre-lancamento' => [
                'title' => 'Campanha de Benfeitoria',
                'slug' => 'campanha-pre-lancamento',
                'description' => 'Campanha de financiamento coletivo na plataforma Benfeitoria.',
                'short_description' => 'Online, 2025 - Objetivo: 1.500',
                'image' => '/assets/imgs/otto.jpg',
                'video' => null,
                'is_featured' => false,
                'status' => 'ongoing'
            ] // Em andamento
        ];
    }

    private function renderProjects($title, $projects)
    {
        $featuredProjects = array_filter($projects, function ($project) {
            return isset($project['is_featured']) && $project['is_featured'];
        });

        $data = [
            'title' => $title,
            'featured_projects' => $featuredProjects,
            'all_projects' => $projects
        ];

        $styles = ['/assets/css/project.css'];


        return new View('site/projetos', $data, $styles);
    }
}
