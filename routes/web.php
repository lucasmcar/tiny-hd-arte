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
    $router->get('/login', 'UserController','login');
    $router->get('/logout', 'UserController', 'logout');
    $router->post('/signIn', 'UserController','signIn');
    $router->group('', function($router){
        $router->get('/home', 'HomeAdminController','home');
        $router->get('/perfil', 'PerfilController', 'perfil');
        
        //Blog
        $router->get('/novo/blog', 'BlogController', 'novoBlog');
        $router->get('/lista/blogs', 'BlogController', 'listaBlogs');
        //$router->get('/nova/conta', 'UserController', 'registrar');

        
        //Eventos
        $router->get('/evento', 'EventoController','index');
        $router->get('/evento/participantes', 'EventoController','participantes');

        //Editais
        $router->get('/editais', 'EditalController','editais');
        $router->post('/upload-edital', 'EditalController','uploadEdital');
        $router->get('/listar-editais', 'EditalController','listarEditais');
        $router->put('/alterar-status-edital', 'EditalController','alterarStatusEdital');

        //LOGS
        $router->get('/configuracoes/log', 'LogController','index');
        $router->get('/configuracoes/list-logs', 'LogController','listLogs');
        $router->post('/configuracoes/clear-logs', 'LogController','clearLogs');

        $router->get('/todos/servicos', 'HomeAdminController','todosServicos');
        $router->get('/parceiros/todos', 'ParceiroController','todosParceiros');
        $router->get('/parceiros/gerenciar', 'ParceiroController','gerenciar');
        $router->get('/todos/depoimentos', 'DepoimentoController','todosDepoimentos');
        $router->get('/depoimentos/gerenciar', 'DepoimentoController','gerenciarDepoimentos');
        
        $router->post('/configuracoes/log/export', 'LogController','exportPdf');
        
        $router->get('/posts', 'BlogController','posts');
        $router->get('/posts/{id}', 'BlogController','post');
        $router->get('/teste/{id}', 'HomeController','teste');
        $router->get('/teste/{id}/p/{postId?}/{c?}/{commentId?}', 'HomeController','showPost');
    },[AuthMiddleware::class]);
});


$router->domain('localhost:8000', function($router) {
    $router->get('/admin', 'HomeAdminController', 'home');

});
       