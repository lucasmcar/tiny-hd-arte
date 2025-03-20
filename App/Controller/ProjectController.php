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
                'extra_image' => '/assets/imgs/festa-junina-2025-extra.jpg'
            ],
            'festival-musica-2024' => [
                'title' => 'Festival de Música 2024',
                'description' => 'Evento nacional com artistas renomados.',
                'image' => '/assets/imgs/festival-musica-2024.jpg',
                'details' => 'Ocorrido em Agosto de 2024.',
                'author' => 'Maria Oliveira',
                'post_date' => '2024-09-01',
                'content' => 'O Festival de Música 2024 trouxe ao palco grandes nomes da música brasileira, como Anitta e Jorge Ben Jor. Realizado em São Paulo, o evento contou com uma produção impecável e um público de mais de 10.000 pessoas. A HD Arte foi responsável pela gestão financeira e logística, garantindo o sucesso do festival.',
                'extra_image' => '/assets/imgs/festival-musica-2024-extra.jpg'
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
        return [
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
                'status' => 'ongoing' // Em andamento
            ]
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

        $styles = ['/assets/css/projects.css'];
       

        return new View('site/projetos', $data, $styles);
    }
}