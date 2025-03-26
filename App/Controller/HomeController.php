<?php

namespace App\Controller;

use App\Core\View\View;
use App\Helper\InputFilterHelper;
use App\Helper\JsonHelper;
use App\Helper\MailerHelper;
use App\Repository\DepoimentoRepository;

class HomeController extends Controller
{

    public function welcome()
    {
        $data = [
            'title' => 'Welcome to Tiny!',
        ];

        return new View('welcome', $data);
    }

    public function index()
    {

        $depoimentos = new DepoimentoRepository();
        $depoimentosData = $depoimentos->verDepoimentos();

        $styles = [
            'assets/css/home.css',
        ];

        $scripts = [
            '/assets/js/main.js'
        ];

        $data = [
            'title' => 'HD Arte Produtora',
            'depoimentos' => $depoimentosData,
            'artigos' => [
                ['title' => 'Como Planejar um Evento de Sucesso', 'created_at' => '2025-03-22', 'slug' => 'como-planejar-evento-sucesso'],
                ['title' => 'Dicas de Produção Cultural', 'created_at' => '2025-03-20', 'slug' => 'dicas-producao-cultural'],
                ['title' => 'A Arte de Engajar o Público', 'created_at' => '2025-03-18', 'slug' => 'arte-engajar-publico'],
            ]
        ];


        return new View('site/home',  $data, $styles, $scripts);
    }


    public function sobre()
    {
        $data = [
            'title' => 'Sobre a HD Arte',
        ];

        $styles = [
            'assets/css/sobre.css',
        ];

        $scripts = [
            '/assets/js/sobre.js'
        ];

        return new View(view: 'site/sobre', vars: $data, styles: $styles, scripts: $scripts);
    }

    public function servico()
    {
        $data = [
            'title' => 'Serviços',
            'servicos' => [
                ["icone" => "bi-file-earmark-text", "titulo" => "Análise de Propostas para Editais", "descricao" => "Revisão e análise detalhada de propostas para editais públicos e privados."],
                ["icone" => "bi-lightbulb", "titulo" => "Elaboração de Projetos", "descricao" => "Criação de projetos estratégicos e personalizados para seu negócio."],
                ["icone" => "bi-calendar-check", "titulo" => "Planejamento e Gerenciamento", "descricao" => "Organização e supervisão de projetos para garantir sua execução eficiente."],
                ["icone" => "bi-cash-coin", "titulo" => "Prestação de Contas", "descricao" => "Gestão financeira e transparência na prestação de contas."],
                ["icone" => "bi-mic", "titulo" => "Direção Artística e Produção Executiva", "descricao" => "Supervisão artística e logística para produções culturais e eventos."],
                ["icone" => "bi-megaphone", "titulo" => "Consultoria de Mídias e Redes Sociais", "descricao" => "Estratégias para crescimento orgânico e campanhas pagas eficientes."],
                ["icone" => "bi-newspaper", "titulo" => "Assessoria de Imprensa", "descricao" => "Divulgação estratégica para fortalecimento da marca na mídia."],
                ["icone" => "bi-instagram", "titulo" => "Gestão de Mídias (Instagram, etc.)", "descricao" => "Gerenciamento profissional de redes sociais para engajamento e conversão."]
            ]
        ];

        $styles = [
            '/assets/css/servicos-site.css'
        ];

        return new View(view: 'site/servicos', vars: $data, styles: $styles);
    }

    public function equipe()
    {

        $equipe = [
            ['nome' => 'Heloisa Peres', 'cargo' => 'Direção Artística e Produção Executiva', 'resumo' => 'Lidera a visão criativa da HD Arte, com anos de experiência em produção de eventos e direção artística.', 'foto' => '/assets/imgs/heloisa.jpg', 'redes' => ['instagram' => '#', 'facebook' => '#', 'linkedin' => '#'], 'destaque' => true],
            ['nome' => 'Michelle Rodrigues', 'cargo' => 'Produção Cultural, Elaboração de Projetos', 'resumo' => 'Especialista em projetos culturais, Michelle traz inovação e paixão para a HD Arte.', 'foto' => '/assets/imgs/michelle.jpg', 'redes' => ['instagram' => '#', 'facebook' => '#', 'linkedin' => '#'], 'destaque' => true],
            ['nome' => 'Lucas Carvalho', 'cargo' => 'CEO da Code Experts', 'resumo' => 'Desenvolvimento de sites, consultoria e gestão de redes.', 'foto' => 'lucas.jpg', 'redes' => ['instagram' => 'https://instagram.com/hej.lucasmcar', 'facebook' => 'https://www.facebook.com/lmcarvalho90', 'linkedin' => 'https://linkedin.com/in/lucas-m-carvalho'], 'destaque' => false],
            ['nome' => 'Carla Castro', 'cargo' => 'Assessoria de Imprensa', 'resumo' => 'Jornalista com mais de 20 anos de experiência, foca em comunicação estratégica para a cultura.', 'foto' => '/assets/imgs/carla-castro.jpg', 'redes' => ['instagram' => '#', 'facebook' => '#', 'linkedin' => '#'], 'destaque' => false],
            ['nome' => 'Eduardo Raupp', 'cargo' => 'Comercial e Consultoria SC', 'resumo' => 'Responsável por estratégias comerciais e consultoria em SC.', 'foto' => '/assets/imgs/eduardo-raupp.jpg', 'redes' => ['instagram' => '#', 'facebook' => '#', 'linkedin' => '#'], 'destaque' => false],
            ['nome' => 'Regina Retzel', 'cargo' => 'Assessoria e Produção Cultural', 'resumo' => 'Foco em projetos culturais para o 3º setor.', 'foto' => '/assets/imgs/regina-ritzel.jpg', 'redes' => ['instagram' => '#', 'facebook' => '#', 'linkedin' => '#'], 'destaque' => false],
            
        ];



        $data = [
            'title' => 'Conheça nossa Equipe',
            'equipe' => $equipe
        ];

        $styles = [
            '/assets/css/equipe.css'
        ];

        return new View(view: 'site/equipe', vars: $data, styles: $styles);
    }

    public function depoimentos()
    {

        $depoimentos = new DepoimentoRepository();
        $depoimentosData = $depoimentos->verDepoimentos();




        $data = [
            'title' => 'Depoimentos',
            //Retornar depoimentos do banco de dados
            'depoimentos' =>  $depoimentosData,

        ];

        
        $styles = [
            '/assets/css/depoimentos-site.css'
        ];


        return new View(view: 'site/depoimento', vars: $data, styles: $styles);
    }

    public function contato()
    {
        $data = [
            'title' => 'Contato',
        ];

        $styles = [
            'assets/css/contato.css',
        ];

        $script = [
            'assets/js/contato.js'
        ];

        return new View(view: 'site/contato', vars: $data, styles: $styles, scripts: $script);
    }

    public function criaDepoimento()
    {
        $data = [
            'title' => 'Cria Depoimento',
        ];

        return new View(view: 'site/cria-depoimento', vars: $data);
    }

    public function enviarEmail()
    {
      
        header('Content-Type: application/json'); // Garante o tipo de conteúdo
        $data = InputFilterHelper::filterInputs(INPUT_POST, [
            'nome',
            'email',
            'assunto',
            'mensagem'
        ]);

        $emailHelper = new MailerHelper(
            $_ENV['E_HOST'],
            $_ENV['E_PORT'],
            $_ENV['E_USER'],
            $_ENV['E_PASS'],
            $_ENV['EF_EMAIL'],
            $_ENV['EF_NAME']
        );

        $emailHelper->addRecipient($_ENV['EF_EMAIL'], $_ENV['EF_NAME']);
        $emailHelper->setSubject($data['assunto']);
        $emailHelper->setBody($data['mensagem']);
        if($emailHelper->send()){
            echo JsonHelper::toJson(['success' => true]);
        } else {
            echo JsonHelper::toJson(['success' => false]);
        }
    }
}
