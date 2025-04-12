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

        //Clinte
        $router->get('/clientes', 'ClienteController', 'index');
        $router->post('/cliente/novo', 'ClienteController', 'novoCliente');
        
        //Blog
        $router->get('/novo/blog', 'BlogController', 'novoBlog');
        $router->get('/lista/blogs', 'BlogController', 'listaBlogs');
        //$router->get('/nova/conta', 'UserController', 'registrar');


        //Consultoria
        $router->get('/consultoria', 'ConsultoriaController','index');
        $router->get('/consultoria/lista', 'ConsultoriaController', 'listaClientes');
        $router->get('/consultoria/perfil-cliente', 'ConsultoriaController', 'perfilCliente');
        
        //Gestão de projetos culturais
        $router->get('/projetos-culturais', 'ProjetosCulturaisController', 'index');
        $router->get('/projetos-culturais/listaProjetos', 'ProjetosCulturaisController','listaProjetos');
        $router->get('/projetos-culturais/detalhesProjeto', 'ProjetosCulturaisController','detalhesProjeto');
        $router->post('/projetos-culturais/salvarProjeto', 'ProjetosCulturaisController','salvarProjeto');
        $router->put('/projetos-culturais/atualizaProjetoStatus', 'ProjetosCulturaisController','atualizarStatusProjeto');
        $router->post('/projetos-culturais/salvarPlanejamento', 'ProjetosCulturaisController','salvarPlanejamento');
        $router->post('/projetos-culturais/salvarIncentivo', 'ProjetosCulturaisController','salvarIncentivo');
        $router->post('/projetos-culturais/salvarResultados', 'ProjetosCulturaisController','salvarResultados');


        //Eventos culturais
        $router->get('/eventos-culturais', 'EventosCulturaisController', 'index');
        $router->get('/eventos-culturais/listaEventos', 'EventosCulturaisController', 'listaEventos');
        $router->get('/eventos-culturais/detalhesEvento', 'EventosCulturaisController', 'detalhesEvento');
        $router->post('/eventos-culturais/salvarEvento', 'EventosCulturaisController', 'salvarEvent');
        $router->post('/eventos-culturais/salvarTarefa', 'EventosCulturaisController', 'salvarTarefa');
        $router->post('/eventos-culturais/salvarChecklist', 'EventosCulturaisController', 'salvarChecklist');
        $router->post('/eventos-culturais/salvarFinancas', 'EventosCulturaisController', 'salvarFinancas');

        //Agenciamento
        $router->get('/agenciamento-artistas', 'AgenciamentoArtistasController', 'index');
        $router->post('/agenciamento-artistas/salvarArtista', 'AgenciamentoArtistasController', 'salvarArtista');
        $router->get('/agenciamento-artistas/listaArtistas', 'AgenciamentoArtistasController','listaArtistas');
        $router->get('/agenciamento-artistas/detalhesArtista', 'AgenciamentoArtistasController', 'detalhesArtista');

        $router->get('/agenciamento-artistas/contratos', 'AgenciamentoArtistasController', 'contratos');
        $router->post('/agenciamento-artistas/salvarContrato', 'AgenciamentoArtistasController', 'salvarContrato');
        $router->get('/agenciamento-artistas/listaContratos', 'AgenciamentoArtistasController', 'listaContratos');
        $router->get('/agenciamento-artistas/detalhesContrato', 'AgenciamentoArtistasController', 'detalhesContrato');

        $router->get('/agenciamento-artistas/agenda', 'AgenciamentoArtistasController', 'agenda');
        $router->post('/agenciamento-artistas/salvarEvento', 'AgenciamentoArtistasController', 'salvarEvento');
        $router->get('/agenciamento-artistas/listaAgenda', 'AgenciamentoArtistasController', 'listaAgenda');
        $router->get('/agenciamento-artistas/detalhesEvento', 'AgenciamentoArtistasController', 'detalhesEvento');

        $router->get('/agenciamento-artistas/historico', 'AgenciamentoArtistasController', 'historico');
        $router->post('/agenciamento-artistas/salvarAvaliacaoEvento', 'AgenciamentoArtistasController', 'salvarAvaliacaoEvento');
        $router->get('/agenciamento-artistas/listaHistorico', 'AgenciamentoArtistasController', 'listaHistorico');
        $router->get('/agenciamento-artistas/detalhesHistorico', 'AgenciamentoArtistasController', 'detalhesHistorico');

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
        $router->get('/listar-depoimentos', 'DepoimentoController','listarDepoimentos');
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
       