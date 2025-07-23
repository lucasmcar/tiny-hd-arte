<?php

namespace App\Controller\Home;
use App\Core\View\View;

class ServicoController
{

    public function index()
    {
        $data = [
            'title' => 'Serviços',
            'servicos' => [
                [
                    "icone" => "bi-briefcase",
                    "titulo" => "Consultoria e Assessoria de Projetos",
                    "descricao" => "Atuamos no planejamento e desenvolvimento de projetos culturais, artísticos e esportivos, com foco em soluções criativas e estratégicas."
                ],
                [
                    "icone" => "bi-mic-fill",
                    "titulo" => "Palestras e Workshops",
                    "descricao" => "Ministramos palestras e workshops especializados em diversas áreas culturais e de gestão de eventos."
                ],
                [
                    "icone" => "bi-brush",
                    "titulo" => "Elaboração de Projetos Culturais e Artísticos",
                    "descricao" => "Criamos propostas para editais, elaboramos leis de incentivo e desenvolvemos projetos para diversas áreas culturais."
                ],
                [
                    "icone" => "bi-building",
                    "titulo" => "Eventos Corporativos",
                    "descricao" => "Planejamos e executamos eventos e propostas para empresas, garantindo uma experiência personalizada e impactante."
                ],
                [
                    "icone" => "bi-check-circle",
                    "titulo" => "Avaliação e Submissão de Propostas",
                    "descricao" => "Avaliamos e submetemos projetos em editais, maximizando as chances de aprovação."
                ],
                [
                    "icone" => "bi-cash-stack",
                    "titulo" => "Captação de Recursos",
                    "descricao" => "Nosso foco é sempre fortalecer a rede de recursos disponíveis para os projetos, garantindo viabilidade e sucesso."
                ],
                [
                    "icone" => "bi-music-note",
                    "titulo" => "Produção Artística e Executiva",
                    "descricao" => "Gerenciamos e realizamos a produção artística e executiva de eventos, desde a criação até a execução."
                ],
                [
                    "icone" => "bi-kanban",
                    "titulo" => "Gestão Completa de Projetos",
                    "descricao" => "Oferecemos gerenciamento completo de projetos, garantindo que todas as etapas sejam realizadas com excelência e dentro do prazo."
                ],
                [
                    "icone" => "bi-instagram",
                    "titulo" => "Gestão de Mídias (Instagram, etc.)",
                    "descricao" => "Gerenciamento profissional de redes sociais para engajamento e conversão.",
                    "mais" => "Na HD Arte Produções e Eventos, oferecemos gestão estratégica de redes sociais, com foco no engajamento e conversão de seu público. Atuamos com parceiros e influencers, recomendando sempre aqueles que melhor se alinham com a identidade do seu projeto, ampliando sua presença digital e fortalecendo sua conexão com o público. A parceria com influenciadores é uma ferramenta poderosa para expandir o alcance e gerar resultados reais, trazendo uma abordagem autêntica e impactante para suas campanhas nas redes sociais.
"
                ]
            ]
        ];

        $styles = [
            '/assets/css/servicos-site.min.css'
        ];

        return new View(view: 'site/servicos', vars: $data, styles: $styles);
    }
}
