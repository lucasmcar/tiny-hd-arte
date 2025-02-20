<?php

namespace App\Controller;

use App\Core\Security\Csrf;
use App\Core\View\View;


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
            //Retornar depoimentos do banco de dados
            'depoimentos' =>  [
                ["nome" => "Ana Souza", "profissao" => "Designer", "foto" => "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", "texto" => "Ótimo serviço! Recomendo a todos."],
                ["nome" => "Carlos Lima", "profissao" => "Desenvolvedor", "foto" => "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", "texto" => "Equipe muito profissional e atenciosa."],
                ["nome" => "Mariana Santos", "profissao" => "Gerente de Projetos", "foto" => "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", "texto" => "Uma experiência incrível, superou minhas expectativas!"],
                ["nome" => "Roberto Alves", "profissao" => "Empresário", "foto" => "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", "texto" => "Serviço de alta qualidade e atendimento nota 10!"]
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
