<?php

namespace App\Controller;


use App\Core\View\View;
use App\Repository\ProjetosRepository;

class ProjetoController
{

    public function index()
    {
        $projetosRepository = new ProjetosRepository();
        // Lista de projetos (simulação - substitua por um repositório real)
        $projects = $projetosRepository->fetchAllProjects();

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

        $styles = ['/assets/css/all-project.min.css'];
        $scripts = []; // Para interatividade, se necessário

        return new View('site/projetos', $data, $styles);
    }


    public function show($params)
    {
        $projetosRepository = new ProjetosRepository();
        $projectOrCaptation = null;
        $slug = $params[0] ?? '';

        $captationArray = $projetosRepository->fetchProjectsInCaptation($slug);

        if ($captationArray) {
            $projectOrCaptation = $projetosRepository->fetchProjectsInCaptation($slug);

            $project = $projectOrCaptation;
            if (!$project) {
                http_response_code(404);
                return new View('not-found/not-found', ['title' => 'Projeto Não Encontrado'], [], [] );
            }

            $data = [
                'title' => $project['title'],
                'project' => $project
            ];
            $styles = ['/assets/css/projetos.min.css'];
            $scripts = ['/assets/js/projeto-detalhe.min.js']; // Se necessário

            return new View('site/projeto-detalhe', $data, $styles, $scripts);
        } else {
            $projectOrCaptation =  $projetosRepository->fetchProjectBySlug($slug);

            $project = $projectOrCaptation;
            if (!$project) {
                http_response_code(404);
                return new View('not-found/not-found', ['title' => 'Projeto Não Encontrado'], [], [], '');
            }

            $data = [
                'title' => $project['title'],
                'project' => $project
            ];
            $styles = ['/assets/css/project.min.css'];
            $scripts = ['/assets/js/event-carousel.min.js']; // Se necessário

            return new View('site/projects', $data, $styles, $scripts);
        }
    }


    

    public function approved()
    {
        $projetosRepository = new ProjetosRepository();
        $projects = $projetosRepository->fetchAllProjects();
        $approvedProjects = array_filter($projects, function ($project) {
            return $project['status'] === 'approved';
        });
        return $this->renderProjects('Projetos Aprovados', $approvedProjects);
    }

    public function ongoing()
    {
        $projetosRepository = new ProjetosRepository();
        $projects = $projetosRepository->fetchAllProjects();
        $ongoingProjects = array_filter($projects, function ($project) {
            return $project['status'] === 'ongoing';
        });
        return $this->renderProjects('Projetos em Andamento', $ongoingProjects);
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

        $styles = ['/assets/css/project.min.css'];


        return new View('site/projetos', $data, $styles);
    }

    public function emCaptacao()
    {

        $projetosRepository = new ProjetosRepository();

        $projects = $projetosRepository->fetchProjectsInCaptation();
        $data = [

            'title' => 'Projetos Em Captação',
            'all_projects' => $projects
        ];
        $styles = ['/assets/css/projetos.min.css'];
      
        return new View('site/em-captacao', $data, $styles);
    }

    public function projetosOcorridos()
    {

        $projetosRepository = new ProjetosRepository();
        $projects = $projetosRepository->fetchAllProjects();

        $completedProjects = array_filter($projects, function ($project) {
            return $project['status'] === 'completed';
        });

        $data = [
            'title' => 'Projetos Ocorridos',
            'all_projects' => $completedProjects
        ];

        $styles = ['/assets/css/projetos-ocorridos.min.css']; // Novo arquivo CSS, ajuste conforme necessário

        return new View('site/projetos-ocorridos', $data, $styles);
    }

    
}
