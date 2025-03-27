<?php

namespace App\Controller;

use App\Core\View\View;
use App\Helper\InputFilterHelper;

class UserController
{
    public function login()
    {
        $data = [
            'title' => 'Login'
        ];

        $styles = [
            '/assets/css/admin/login.css'
        ];
        $scripts =[];


        return new View(view: 'admin/login', vars: $data, styles: $styles, scripts: $scripts, layout: 'admin-layout');
    }

    public function registrar()
    {
        $data = [
            'title' => 'Registrar'
        ];

        $styles = [
            '/assets/css/cria_conta.css'
        ];
        $scripts =[
            '/assets/js/cria_conta.js'
        ];

        return new View(view: 'admin/cria_conta', vars: $data, styles:  $styles, scripts: $scripts, layout: 'admin-layout');
    }

    public function criarUsuario()
    {
        $data = InputFilterHelper::filterInputs(INPUT_POST, [
            'nome',
            'email',
            'senha'
        ]);

    }
}