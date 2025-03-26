<?php

use App\Middleware\AuthMiddleware;


$router->notFound(function(){
    include '../App/views/not-found/not-found.tpl';
});

$router->get('/', 'HomeController', 'index');
$router->get('/sobre', 'HomeController', 'sobre');   
$router->get('/contato', 'HomeController','contato');
$router->get('/depoimentos/todos', 'HomeController','depoimentos');
$router->get('/servicos', 'HomeController','servico');
$router->get('/equipe', 'HomeController','equipe');
$router->get('/novo/depoimento', 'HomeController','criaDepoimento');
$router->post('/depoimentos/criar', 'DepoimentoController','criar');
$router->get('/search', 'SearchController','search');
$router->get('/projetos', 'ProjectController', 'index');
$router->get('/projetos/aprovados', 'ProjectController', 'approved'); // Projetos aprovados
$router->get('/projetos/em-andamento', 'ProjectController', 'ongoing');
$router->get('/projetos/{slug}', 'ProjectController', 'show');
$router->get('/artigo/{created_at}/{slug}', 'BlogController', 'mostrarArtigo');
$router->post('/contato/email', 'HomeController','enviarEmail');


$router->group('/admin', function($router) {
    $router->get('/perfil', 'PerfilController', 'perfil');
    $router->get('/novo/blog', 'BlogController', 'novoBlog');
    $router->get('/lista/blogs', 'BlogController', 'listaBlogs');
    $router->get('/nova/conta', 'UserController', 'registrar');
    $router->get('/login', 'UserController','login');
    $router->get('/home', 'HomeAdminController','home');
    $router->get('/todos/servicos', 'HomeAdminController','todosServicos');
    $router->get('/parceiros/todos', 'ParceiroController','todosParceiros');
    $router->get('/parceiros/gerenciar', 'ParceiroController','gerenciar');
    $router->get('/todos/depoimentos', 'DepoimentoController','todosDepoimentos');
    $router->get('/depoimentos/gerenciar', 'DepoimentoController','gerenciarDepoimentos');
    $router->get('/posts', 'BlogController','posts');
    $router->get('/posts/{id}', 'BlogController','post');
    $router->get('/teste/{id}', 'HomeController','teste');
    $router->get('/teste/{id}/p/{postId?}/{c?}/{commentId?}', 'HomeController','showPost');
});


$router->domain('localhost:8000', function($router) {
    $router->get('/admin', 'HomeAdminController', 'home');

});
       