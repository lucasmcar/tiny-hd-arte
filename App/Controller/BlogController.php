<?php

namespace App\Controller;

use App\Core\View\View;

class BlogController
{
    public function novoBlog()
    {

        $data = [
            'title' => 'Novo Blog',
        ];

        return new View('admin/blog', $data, 'admin-layout');
    }
}