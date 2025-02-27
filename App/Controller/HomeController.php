<?php

namespace App\Controller;

use App\Core\View\View;

use App\Repository\DepoimentoRepository;

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

        $depoimentos = new DepoimentoRepository();
        $depoimentosData = $depoimentos->verDepoimentos();

        


        $data = [
            'title' => 'Depoimentos',
            //Retornar depoimentos do banco de dados
            'depoimentos' =>  $depoimentosData,

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

    public function criaDepoimento()
    {
        $data = [
            'title' => 'Cria Depoimento',
        ];

        return new View('site/cria-depoimento', $data);
    }
}
