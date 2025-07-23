<?php

namespace App\Controller\Home;

use App\Core\View\View;
use App\Helper\JsonHelper;
use App\Repository\EquipeRepository;

class EquipeController
{

    private EquipeRepository $repository;

    public function __construct()
    {
        $this->repository = new EquipeRepository();
    }
    
    public function index()
    {


        $equipe = $this->repository->retornaTodaEquipe();

        $data = [
            'title' => 'Conheça nossa Equipe',
            'equipe' => $equipe
        ];

        $styles = [
            '/assets/css/equipe.min.css'
        ];

        return new View(view: 'site/equipe', vars: $data, styles: $styles);
    }

    /**
     * Cadastro da Equipe
     */
    public function cadastroEquipe()
    {
        $data = [];

        $scripts = [
            '/assets/js/cadastro-equipe.min.js'
        ];
        $styles = [
            '/assets/css/admin/cadastro-equipe.min.css'
        ];

        return new View(
            view: 'admin/equipe/cadastro-equipe', 
            vars: $data, 
            styles: $styles, 
            scripts: $scripts, 
            layout: 'admin-layout'
        );
    }

    public function listaEquipe()
    {
        $equipe = $this->repository->retornaTodaEquipe();
        $data = [
            'title' => 'Equipe HD\'arte',
            'equipe' => json_encode($equipe)
        ];

        $scripts = [
            '/assets/js/lista-equipe.min.js'
        ];

        $styles = [
            'assets/css/admin/lista-equipe.min.css'
        ];

        return new View(
            view: 'admin/equipe/lista-equipe', 
            vars: $data, 
            scripts: $scripts, 
            styles: $styles,
            layout: 'admin-layout'
        );
    }

    public function salvarEquipe()
    {

    }

}