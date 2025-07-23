<?php

namespace App\Repository;

class EquipeRepository
{
    public function retornaTodaEquipe()
    {
        return [
            ['nome' => 'Heloisa Peres', 'cargo' => 'Direção Artística e Produção Executiva', 'resumo' => 'Lidera a visão criativa da HD Arte, com anos de experiência em produção de eventos e direção artística.', 'foto' => '/assets/imgs/heloisa.jpg', 'redes' => ['instagram' => '#', 'facebook' => '#', 'linkedin' => '#'], 'destaque' => true],
            ['nome' => 'Michelle Rodrigues', 'cargo' => 'Produção Cultural, Elaboração de Projetos', 'resumo' => 'Especialista em projetos culturais, Michelle traz inovação e paixão para a HD Arte.', 'foto' => '/assets/imgs/michelle.jpg', 'redes' => ['instagram' => '#', 'facebook' => '#', 'linkedin' => '#'], 'destaque' => true],
            ['nome' => 'Regina Retzel', 'cargo' => 'Assessoria e Produção Cultural', 'resumo' => 'Foco em projetos culturais para o 3º setor.', 'foto' => '/assets/imgs/regina-ritzel.jpg', 'redes' => ['instagram' => '#', 'facebook' => '#', 'linkedin' => '#'], 'destaque' => false],
            ['nome' => 'Lucas Carvalho', 'cargo' => 'CEO da Code Experts', 'resumo' => 'Desenvolvimento de sites, consultoria e gestão de redes.', 'foto' => 'lucas.jpg', 'redes' => ['instagram' => 'https://instagram.com/hej.lucasmcar', 'facebook' => 'https://www.facebook.com/lmcarvalho90', 'linkedin' => 'https://linkedin.com/in/lucas-m-carvalho'], 'destaque' => false],
            ['nome' => 'Eduardo Raupp', 'cargo' => 'Comercial e Consultoria SC', 'resumo' => 'Responsável por estratégias comerciais e consultoria em SC.', 'foto' => '/assets/imgs/eduardo-raupp.jpg', 'redes' => ['instagram' => '#', 'facebook' => '#', 'linkedin' => '#'], 'destaque' => false],
            ['nome' => 'Carla Castro', 'cargo' => 'Assessoria de Imprensa', 'resumo' => 'Jornalista com mais de 20 anos de experiência, foca em comunicação estratégica para a cultura.', 'foto' => '/assets/imgs/carla-castro.jpg', 'redes' => ['instagram' => '#', 'facebook' => '#', 'linkedin' => '#'], 'destaque' => false],
        ];
    }
}
