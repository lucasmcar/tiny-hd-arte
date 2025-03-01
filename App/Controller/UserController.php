<?php

namespace App\Controller;

use App\Core\View\View;

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
}