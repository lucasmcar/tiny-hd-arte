<?php

namespace App\Controller;

use App\Core\View\View;

class BlogController
{
    public function novoBlog()
    {

        $data = [
            'title' => 'Novo Post',
        ];

        $styles = [
            '/assets/css/blog.css',
        
        ];
        $scripts = [
            
            
        ];
        if ($_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest') {
            header('Content-Type: text/html');
            return new View('admin/blog', $data, $styles, $scripts, 'admin-layout');
        }
    }

    public function posts()
    {
        $data = [
            'title' => 'Posts',
            'posts' => [
                ["id"=> 1, "titulo" => "Post 1", "conteudo" => "Conteúdo do post 1"],
                ["id"=> 2, "titulo" => "Post 2", "conteudo" => "Conteúdo do post 2"],
                ["id"=> 3, "titulo" => "Post 3", "conteudo" => "Conteúdo do post 3"],
                ["id"=> 4, "titulo" => "Post 4", "conteudo" => "Conteúdo do post 4"],
                ["id"=> 5, "titulo" => "Post 5", "conteudo" => "Conteúdo do post 5"],
                ["id"=> 6, "titulo" => "Post 6", "conteudo" => "Conteúdo do post 6"],
                ["id"=> 7, "titulo" => "Post 7", "conteudo" => "Conteúdo do post 7"],
                ["id"=> 8, "titulo" => "Post 8", "conteudo" => "Conteúdo do post 8"],
                ["id"=> 9, "titulo" => "Post 9", "conteudo" => "Conteúdo do post 9"],
                ["id"=> 10, "titulo" => "Post 10", "conteudo" => "Conteúdo do post 10"]
            ]
        ];

        $styles = [
            '/assets/css/posts.css'
        ];

        $scripts = [];

        // Verifica se é uma requisição AJAX
        if ($_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest') {
            header('Content-Type: text/html');
            return new View('admin/posts', $data, $styles, $scripts, 'admin-layout');
        }
    }
}