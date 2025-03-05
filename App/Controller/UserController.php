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

        $styles = [];
        $scripts =[];


        return new View('admin/login', $data, $styles, $scripts, 'admin-layout');
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

        return new View('admin/cria_conta', $data, $styles, $scripts, 'admin-layout');
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