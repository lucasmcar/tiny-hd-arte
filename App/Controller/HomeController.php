<?php

namespace App\Controller;

use App\Core\Security\Csrf;
use App\Core\View\View;
use App\Repository\TesteRepository;

class HomeController extends Controller
{

    public function welcome()
    {
        $data = [
            'title' => 'Welcome to Tiny!',
        ];

        return new View('welcome', $data);
    }

    public function index()
    {
        $data = [
            'title' => 'HD Arte Produtora',
        ];

        return new View('site/home', $data);
    }


    public function sobre()
    {
        $data = [
            'title' => 'Sobre a HD Arte',
        ];

        return new View('site/sobre', $data);
    }

    public function servico()
    {
        $data = [
            'title' => 'Serviços',
        ];

        return new View('site/servicos', $data);
    }

    public function equipe()
    {
        $data = [
            'title' => 'Conheça nossa Equipe',
        ];

        return new View('site/equipe', $data);
    }

    public function depoimentos()
    {
        $data = [
            'title' => 'Depoimentos',
            'depoimentos' => [
                ["nome" => "Ana Souza", "profissao" => "Designer", "foto" => "ana.jpg", "texto" => "Ótimo serviço! Recomendo a todos."],
                ["nome" => "Carlos Lima", "profissao" => "Desenvolvedor", "foto" => "carlos.jpg", "texto" => "Equipe muito profissional e atenciosa."],
                ["nome" => "Mariana Santos", "profissao" => "Gerente de Projetos", "foto" => "mariana.jpg", "texto" => "Uma experiência incrível, superou minhas expectativas!"],
                ["nome" => "Roberto Alves", "profissao" => "Empresário", "foto" => "roberto.jpg", "texto" => "Serviço de alta qualidade e atendimento nota 10!"]
            ]
        ];

        return new View('site/depoimento', $data);
    }

    public function contato()
    {
        $data = [
            'title' => 'Contato',
        ];

        return new View('site/contato', $data);
    }
}
