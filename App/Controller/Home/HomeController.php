<?php

namespace App\Controller\Home;

use App\Core\View\View;
use App\Helper\InputFilterHelper;
use App\Helper\JsonHelper;
use App\Helper\MailerHelper;
use App\Repository\DepoimentoRepository;

class HomeController
{
    public function index()
    {
        $depoimentos = new DepoimentoRepository();
        $depoimentosData = $depoimentos->verDepoimentos();

        $styles = [
            '/assets/css/default.css',
            'assets/css/home.min.css',
        ];

        $scripts = [
            '/assets/js/main.min.js'
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
            '/assets/css/default.css',
            'assets/css/sobre.min.css',
        ];

        $scripts = [
            '/assets/js/sobre.min.js'
        ];

        return new View(view: 'site/sobre', vars: $data, styles: $styles, scripts: $scripts);
    }

    public function contato()
    {
        $data = [
            'title' => 'Contato',
        ];

        $styles = [
            '/assets/css/default.css',
            '/assets/css/contato.min.css',
        ];

        $script = [
            'assets/js/contato.min.js'
        ];

        return new View(view: 'site/contato', vars: $data, styles: $styles, scripts: $script);
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
