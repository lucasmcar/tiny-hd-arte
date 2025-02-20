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
$router->get('/depoimentos', 'HomeController','criarDepoimento');
$router->post('/depoimentos/criar', 'DepoimentoController','criar');
    


$router->group('/admin', function($router) {
    $router->get('/list', 'HomeController', 'list');
    $router->get('/settings', 'HomeController','settings');
    $router->get('/teste/{id}', 'HomeController','teste');
    $router->get('/teste/{id}/p/{postId?}/{c?}/{commentId?}', 'HomeController','showPost');
});

