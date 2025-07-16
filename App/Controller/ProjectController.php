<?php

namespace App\Controller;


use App\Core\View\View;

class ProjectController
{

    public function index()
    {
        // Lista de projetos (simulação - substitua por um repositório real)
        $projects = $this->fetchAllProjects();

        // Projetos em destaque (os mais importantes)
        $featuredProjects = array_filter($projects, function ($project) {
            return isset($project['is_featured']) && $project['is_featured'];
        });

        // Todos os projetos (exclui duplicatas se desejar)
        $allProjects = $projects;

        $data = [
            'title' => 'Projetos e Eventos Realizados',
            'featured_projects' => $featuredProjects,
            'all_projects' => $allProjects
        ];

        $styles = ['/assets/css/all-project.min.css'];
        $scripts = []; // Para interatividade, se necessário

        return new View('site/projetos', $data, $styles);
    }


    public function show($params)
    {
        $projectOrCaptation = null;
        $slug = $params[0] ?? '';

        $captationArray = $this->fetchProjectsInCaptation($slug);

        if ($captationArray) {
            $projectOrCaptation = $this->fetchProjectsInCaptation($slug);

            $project = $projectOrCaptation;
            if (!$project) {
                http_response_code(404);
                return new View('errors/404', ['title' => 'Projeto Não Encontrado'], [], [], 'main-layout');
            }

            $data = [
                'title' => $project['title'],
                'project' => $project
            ];
            $styles = ['/assets/css/projetos.min.css'];
            $scripts = ['/assets/js/projeto-detalhe.min.js']; // Se necessário

            return new View('site/projeto-detalhe', $data, $styles, $scripts);
        } else {
            $projectOrCaptation =  $this->fetchProjectBySlug($slug);

            $project = $projectOrCaptation;
            if (!$project) {
                http_response_code(404);
                return new View('errors/404', ['title' => 'Projeto Não Encontrado'], [], [], 'main-layout');
            }

            $data = [
                'title' => $project['title'],
                'project' => $project
            ];
            $styles = ['/assets/css/project.min.css'];
            $scripts = ['/assets/js/event-carousel.min.js']; // Se necessário

            return new View('site/projects', $data, $styles, $scripts);
        }
    }


    private function fetchProjectBySlug($slug)
    {
        $projects = [

            'circuito-urbano-restinga' => [
                'title' => 'Circuito Urbano Na Restinga 2025',
                'description' => 'Projeto de Cultura Hip Hop.',
                'image' => '/assets/imgs/cur.jpg',
                'details' => 'Será realizado em Maio de 2025, nos dias 2, 3 e 4',
                'author' => 'Michelle Rodrigues',
                'post_date' => '2025-03-15',
                'content' => 'O Circuito Urbano na Restinga 2025 é um projeto que visa promover a cultura Hip Hop na região da Restinga, em Porto Alegre. Com oficinas, shows e intervenções artísticas, o evento busca valorizar a produção cultural local e incentivar a participação da comunidade. A HD Arte é parceira nessa iniciativa, contribuindo com a produção e divulgação do projeto.',
                'extra_image' => '/assets/imgs/cur-extra.jpg',
                'sponsors' => [
                    /*['logo' => '/assets/imgs/logo1.jpg', 'name' => 'Patrocinador 1'],
                    ['logo' => '/assets/imgs/logo1.jpg', 'name' => 'Patrocinador 2'],*/],
                'shows' => [
                    [
                        'title' => 'Atração Confirmada',
                        'image' => '/assets/imgs/cur/show1.jpeg',
                        'description' => '',
                        'slug' => 'show1',
                        'participants' => 'DJ N1ngu3m'
                    ],
                    [
                        'title' => 'Atração Confirmada',
                        'image' => '/assets/imgs/cur/show2.jpeg',
                        'description' => '',
                        'slug' => 'show2',
                        'participants' => 'DJ Caramão'
                    ],
                    [
                        'title' => 'Atração Confirmada',
                        'image' => '/assets/imgs/cur/show3.jpeg',
                        'description' => '',
                        'slug' => 'show2',
                        'participants' => 'DJ Nezzo'
                    ],
                    [
                        'title' => 'Atração Confirmada',
                        'image' => '/assets/imgs/cur/show4.jpeg',
                        'description' => '',
                        'slug' => 'show2',
                        'participants' => 'DJ JB'
                    ],
                    [
                        'title' => 'Atração Confirmada',
                        'image' => '/assets/imgs/cur/show5.jpeg',
                        'description' => '',
                        'slug' => 'show2',
                        'participants' => 'DJ Serginho'
                    ],
                    [
                        'title' => 'Atração Confirmada',
                        'image' => '/assets/imgs/cur/show6.jpeg',
                        'description' => '',
                        'slug' => 'show2',
                        'participants' => 'Jeff Conex'
                    ],
                    [
                        'title' => 'Atração Confirmada',
                        'image' => '/assets/imgs/cur/show7.jpeg',
                        'description' => '',
                        'slug' => 'show2',
                        'participants' => 'Restinga Crew'
                    ],
                    [
                        'title' => 'Atração Confirmada',
                        'image' => '/assets/imgs/cur/show8.jpeg',
                        'description' => '',
                        'slug' => 'show2',
                        'participants' => 'Família Preto Bom'
                    ],


                ],
                'attractions' => [
                    [
                        'title' => 'Ana Scarceli',
                        'description' => 'Ana, artesã e artista autodidata há 23 anos, começou em 2012 a se expressar pelas ruas através do grafitti. Ao longo de sua trajetória, 
                        pintando e estudando, também tem se dedicado ao muralismo.
                            Dentre os diversos temas de seus trabalhos, nota-se um carinho especial à fauna e à flora, preservação do meio ambiente, luta pelos direitos das mulheres, 
                            valorização dos povos originários e muitos outros.
                            Tem participado de diversos eventos de arte urbana importantes e tem suas artes espalhadas pelas ruas, periferias, comércios, casas e locais influentes, como por exemplo, o Museu do Hip Hop RS, 
                            Casa da Cultura do Hip Hop de Esteio, Casa do Hip Hop Rubem Berta.
                            Acredita que a arte transforma não só os lugares como também a vida das pessoas.',
                        'image' => '/assets/imgs/cur/cur1.jpeg'
                    ],
                    [
                        'title' => 'Marcus Gorga',
                        'description' => 'Marcus Gorga é um artista autodidata que iniciou
                            a desenhar em 1997 com referências em desenho
                            animado, história em quadrinhos, skate, cultura
                            de rua e a cultura indígena brasileira. 

                            Cria livremente, buscando o primitivo do homem e suas origens, o inconsciente inquieto do multiartista que nos
                            revela uma transição em torno de um caminho
                            trilhado por suas intervenções urbanas com graffiti desde 2011, estêncil e incansáveis adesivos, demarcando suas
                            novas experiências e linguagens experimentais.

                            Criador da oficina ateliê urbano onde fala sobre a
                            cultura hip hop e ensina técnicas com spray.',
                        'image' => '/assets/imgs/cur/cur2.jpeg'
                    ],
                    [
                        'title' => 'Sabrina Brum',
                        'description' => 'Sabrina  Brum nascida em Tupanciretã RS em 1984,conheceu o Graffiti no ano de 2000  é mãe, Oficineira, arte educadora, educadora social, artesã , grafiteira ,horticultura e mediadora no Museu Hip Hop RS, residente no bairro Restinga é protagonista e ativista de sua comunidade ,tem seu estilo próprio, técnicas e ações ,ativista da cultura Hip Hop a muitos anos ,foi uma das pesquisadoras do Museu do Hip Hop do RS, é uma das fundadoras do Coletivo Ação Mulher cujo intuito é promover a igualdade de gênero ,Co- fundadora do coletivo Gurias do Graffiti que  visa formar novas escritoras urbanas, já participou de diversos encontros nacionais e internacionais de Graffiti, atualmente é oficineira  de arte e cultura, educadora social  e Mediadora do Museu do Hip Hop RS, cultiva plantas , universo pelo qual é sua inspiração na arte e na vida.
                            Traz em suas obras o traço lúdico e colorido  ao mesmo tempo a representação feminina de diversas formas, raças e gêneros, valorizando sempre  o poder de transformação social que a arte reflete.',
                        'image' => '/assets/imgs/cur/cur3.jpeg'
                    ],
                    /*[
                        'title' => 'Jaque Vieira',
                        'description' => 'Sem informações adicionais',
                        'image' => '/assets/imgs/cur/cur4.jpeg'
                    ],*/
                    [
                        'title' => 'Allan Vieira',
                        'description' => 'Allan Vieira é grafiteiro, nascido em Porto Alegre, usa arte urbana commo ferramenta de transformação social.
                            Seu trabalho valoriza a cultura negra e busca fortalecer o empoderamento do povo preto, levando cor, identidade e resistência para as ruas.
                            Através do graffiti, expressa narrativas de luta, orgulho e ancestralidade, criando conexões e inspirando mudanças.',
                        'image' => '/assets/imgs/cur/cur5.jpeg'
                    ],
                    [
                        'title' => 'Felipe Reis',
                        'description' => 'Felipe Reis, natural de Porto Alegre, desde criança um apaixonado pela arte do desenho, conheceu o graffiti em 1992, através das revistas de skate. Residiu em 98 na cidade do Rio de janeiro por 16 anos onde se  desenvolveu como arte educador por toda sua trajetória em projetos sociais na Rocinha e Complexo da Maré. Retornou a Porto Alegre em 2014, em trabalhos comerciais, curadorias de exposições e seu projeto de estudos de abordagem antropológica da cultura HIP HOP num todo. Seu estilo traz um histórico retratando a velha escola e seus estilos, a origem sendo mantida em suas pinturas de quem construiu os pilares dessa ancestralidade que carregamos.',
                        'image' => '/assets/imgs/cur/cur6.jpeg'
                    ],
                    [
                        'title' => 'Adalberto Reis',
                        'description' => 'Adalberto Reis dos Santos, 39 anos, é pai, grafiteiro, arte-educador e assistente social. Há 18 anos usa a rua como suporte para suas manifestações urbanas, criando uma identidade estética com personagens e stencil. Atua também como educador em oficinas de graffiti em eventos como o Seminário Juventudes Negras e Políticas Públicas (PUCRS) e participou da exposição coletiva Presença Negra no MARGS em 2022.
                            Sua escolha pela rua como suporte se conecta à cultura hip hop e à democratização da arte. Sua produção é marcada pelo ativismo político, afirmando a negritude e combatendo racismo, discriminação e guetofobia. Assinando como Triafu, além das ruas, o artista também trabalha com telas, roupas, tênis e garrafas customizadas. Sua arte é uma forma de luta pela diversidade, pela cidadania e pelo respeito à vida.',
                        'image' => '/assets/imgs/cur/cur7.jpeg'
                    ],
                    [
                        'title' => 'Leandro Alves',
                        'description' => 'Natural de Rosário do Sul, 
                            Leandro Alves é um artista visual autodidata e atua na Arte Urbana há 20 anos.
                            Na sua trajetória experimentou diversos segmentos artísticos, dentre eles a pixação, o graffiti, a pintura mural, a pintura em telas, os artesanatos e as esculturas. Atualmente vem se dedicando a pintura e aos estudos do realismo e surrealismo, atuando tanto em murais públicos, na rua, ao alcance e acesso de todos, 
                            quanto em trabalhos comerciais, privados, em empresas, comércios e residências. 
                            Sempre na busca de transformar os espaços através da arte, dando uma vida, uma cara nova, levando cores, trazendo diálogos, reflexões, questionamentos, dialogando ou as vezes contrastando com o
                            contexto local. 
                            Nas suas obras, questões sociais, culturais e
                            ambientais são grandes fontes de inspiração.
                            Tem trabalhos e já participou de eventos e festivais em várias cidades, como Porto Alegre, Caxias do Sul, além de
                            Florianópolis, Rio de Janeiro e São Paulo.',
                        'image' => '/assets/imgs/cur/cur8.jpeg'
                    ],
                    [
                        'title' => 'Marcinha Dark',
                        'description' => 'Nascida em Porto Alegre, RS, Marcinha Dark é uma artista e empreendedora atuante desde 2018.
                            Ilustradora e graffiteira, consolidou-se na cena da arte urbana gaúcha a partir de 2021. Como
                            autodidata, desenvolveu uma assinatura artística autêntica e autoral, pautada na liberdade de
                            expressão e no empoderamento feminino.
                            Marcinha participou de diversos festivais, incluindo Resistinta 2024 (RS),Santa jam 2024 (RS)
                            Colorindo o bairro 2024 (RS), Rolezada das gurias 2024 (RS), Hip Hop Sul Regional 2024 (RS) Nest
                            Support Sala Hip Hop 2024 (RS), 3º Válvula de Escape 2024 (SC), Festival Agenda Urbana: Graffiti
                            Delas 2024 (SC), Origraffes 2023 (ES), Santa Jam 10 Anos AVU – Ateliê Vivências Urbanas 2023
                            (RS), 1° Festival Elas na Rua 2023 (RS), Pimp My Carroça 2023 (RS), Quebrada Virou Postal 2023
                            (RS) e Museu Mais Cores: Museu do Hip Hop 2022 (RS), entre outros.
                            Como educadora, atuou na ACHE: Casa de Cultura Hip Hop de Esteio durante o ano letivo de 2022.
                            Além disso, ministrou palestras e workshops, como o Workshop de Empreendedorismo – RS Criativo
                            e Projovem 2023 (RS), a Oficina de Artes: Conceito Arte e Viva Elizabeth 2023 (RS) e a Oficina na
                            31ª Porto Alegre em Cena 2024 (RS).
                            Sua personagem icônica, "Fridinha", é inspirada na artista mexicana Frida Kahlo. Com um estilo em
                            cartoon, a personagem celebra a feminilidade, destacando a beleza, força e coragem das mulheres.
                            Fridinha simboliza a presença feminina como protagonista nos trabalhos de Marcinha, reforçando a
                            mensagem de empoderamento e representatividade.',
                        'image' => '/assets/imgs/cur/cur9.jpeg'

                    ],
                    [
                        'title' => 'Paulo Ice',
                        'description' => 'Paulo ice natural de Porto Alegre,
                            Comecei a pintar graffiti em 1997 por curiosidade e hobb, me apaixonei pela cultura e pela técnica.
                            Em 2003 me aperfeiçoei e comecei a ministrar oficinas e workshop pela cidade e estado. Sou autodidata há mais de 20 anos.
                            Nos dia de hoje minha principal renda é o graffiti de  oficinas e trabalhos comerciais.',
                        'image' => '/assets/imgs/cur/cur10.jpeg'
                    ],
                    [
                        'title' =>  'Lisi',
                        'description' => 'Desde 2015 participa de feiras gráficas e exposições, 
                            em 2017 começou a levar seus desenhos do papel para a rua e 
                            desde então segue realizando trabalhos comerciais, pintando fachadas e fazendo parte de eventos de graffiti em POA e outras cidades. Suas personagens buscam representar as mulheres e celebrar as diversidades. Por meio de traços lúdicos, suas pinturas também se conectam muito com as crianças. Atualmente cursa Licenciatura em Artes Visuais na UFRGS e atua também como arte educadora ministrando oficinas de graffiti, utilizando essa ferramenta como uma forma de diálogo e empoderamento das comunidades através da arte.',
                        'image' => '/assets/imgs/cur/cur11.jpeg'
                    ],
                    [
                        'title' =>  'Taina Moxa',
                        'description' => 'Taina Moxa é artista urbana em expansão, há 10 anos leva a arte pelas ruas. Suaa expressão tem características de um ritual qye vai desde as cores ao traço, além de elementos 
                            que compõem suas artes e que acompanham em sua busca por autoconhecimento, 
                            para que se desperte todas as mulheres.',
                        'image' => '/assets/imgs/cur/cur12.jpeg'
                    ],
                    [
                        'title' =>  'Rikardo Dias',
                        'description' => 'Rikardo Diasm conhecido na cena do graffiti como Riko, é professor da rede pública de ensino, artista visual e escritor de graffiti.
                            Sua relação com a arte urbana começou em 2004, e desde então, o escritor faz intervenções pela cidade.
                            Em meados de 2011, sua carreira como arte-educador começou a se consolidar, bem como seu trabalho autoral,
                            reconhecidos pelas letras e o personagem, geralmente na cor rosa e com traços retilíneos.
                            Ministrou oficinas na Casa de Cultura Mario Quintana, Centros Comunitários e escolas. 
                            Também participou de exposições no Museu de Arte Contemporânea do RS, Gasômetro e Assembléia Legislativa do RS.
                            Atualmente segue ativo na cena gaúcha de graffiti, focado em realizar pintura em locais descentralizados,
                            principalmente no extremo sul de Porto Alegre.',
                        'image' => '/assets/imgs/cur/cur13.jpeg'
                    ],





                    // Adicione mais atrações aqui, se necessário
                ]
            ],
            'campanha-pre-lancamento' => [
                'title' => 'Pré-lançamento de Campanha de Financiamento Coletivo',
                'description' => 'Campanha de financiamento coletivo na plataforma Benfeitoria.',
                'image' => '/assets/imgs/otto.jpg',
                'details' => 'Será realizado, amanhã dia 12 de Abril',
                'author' => 'HD Arte',
                'post_date' => '2025-04-11',
                'content' => '
                    <div class="campaign-content">
                        <h3 class="campaign-title">🎶 A MÚSICA NÃO PARA — E VOCÊ PODE FAZER PARTE DESSA HISTÓRIA! 🎤</h3>
                        <p class="hda-text">Otto Gomes, cantor e compositor com mais de 30 anos de trajetória, está lançando seu novo EP autoral com 5 faixas inéditas e 3 videoclipes incríveis! Esse projeto marca um novo momento em sua carreira solo, e você pode ajudar a transformar esse sonho em realidade. 🙌</p>

                        <p class="hda-text">💥 Essa é uma campanha de financiamento coletivo na plataforma Benfeitoria! Otto quer expandir sua música, fortalecer sua identidade artística e levar sua arte a mais pessoas – mas para isso, ele precisa de você.</p>

                        <p class="hda-text">👨‍👧‍👦 Pai de 5 filhos e com uma história marcada por dedicação à música, Otto acredita no poder da arte para transformar vidas – inclusive a dele e a de quem ouve.</p>

                        <h4 class="campaign-subtitle">✨ Tem recompensas lindas pra quem apoiar!</h4>
                        <p class="hda-text">Ajude e ainda ganhe experiências exclusivas, conteúdos especiais e muito mais!</p>

                        <h4 class="campaign-subtitle">📲 Acesse agora e contribua:</h4>
                        <ul class="campaign-links">
                            <li><a href="https://www.benfeitoria.com/ottogomes" target="_blank" class="btn btn-hda">Apoie na Benfeitoria 👉</a></li>
                            <li><span class="link-label">📸 Siga e compartilhe:</span> <a href="https://www.instagram.com/ottogomesmusic" target="_blank" class="campaign-link">@ottogomesmusic</a></li>
                            <li><span class="link-label">🌐 Saiba mais em:</span> <a href="https://www.hdarte.com.br" target="_blank" class="campaign-link">www.hdarte.com.br</a></li>
                            <li><span class="link-label">📧 Contato:</span> <a href="mailto:hdarteprodutora@hdarte.com.br" class="campaign-link">hdarteprodutora@hdarte.com.br</a></li>
                        </ul>

                        <h4 class="campaign-subtitle">📢 Como você pode ajudar (além de contribuir):</h4>
                        <ul class="campaign-actions">
                            <li>✅ Compartilhe com seus amigos e grupos!</li>
                            <li>✅ Envie para aquela pessoa que ama música e valoriza a arte local!</li>
                            <li>✅ Poste nas suas redes com a hashtag <strong>#OttoGomesNaBenfeitoria</strong></li>
                        </ul>

                        <p class="hda-text campaign-cta">Vamos juntos fazer esse projeto acontecer? 💛</p>
                    </div>
                ',
                'extra_image' => '/assets/imgs/otto-extra.jpg',
                'sponsors' => []
            ]
        ];


        return $projects[$slug] ?? null;
    }

    public function approved()
    {
        $projects = $this->fetchAllProjects();
        $approvedProjects = array_filter($projects, function ($project) {
            return $project['status'] === 'approved';
        });
        return $this->renderProjects('Projetos Aprovados', $approvedProjects);
    }

    public function ongoing()
    {
        $projects = $this->fetchAllProjects();
        $ongoingProjects = array_filter($projects, function ($project) {
            return $project['status'] === 'ongoing';
        });
        return $this->renderProjects('Projetos em Andamento', $ongoingProjects);
    }

    private function fetchAllProjects()
    {
        return [
            'circuito-urbano-restinga' => [
                'title' => 'Circuito Urbano na Restinga 2025',
                'slug' => 'circuito-urbano-restinga',
                'description' => 'Projeto de Cultura Hip Hop.',
                'short_description' => 'Rio Grande do Sul, 2025 - Público: a estimar',
                'image' => '/assets/imgs/cur.jpg',
                'video' => '',
                'is_featured' => true,
                'status' => 'completed' // Alterado de 'ongoing' para 'completed'
            ],

            'campanha-pre-lancamento' => [
                'title' => 'Campanha de Benfeitoria',
                'slug' => 'campanha-pre-lancamento',
                'description' => 'Campanha de financiamento coletivo na plataforma Benfeitoria.',
                'short_description' => 'Online, 2025 - Objetivo: 1.500',
                'image' => '/assets/imgs/otto.jpg',
                'video' => null,
                'is_featured' => false,
                'status' => 'ongoing'
            ] // Em andamento
        ];
    }

    private function renderProjects($title, $projects)
    {
        $featuredProjects = array_filter($projects, function ($project) {
            return isset($project['is_featured']) && $project['is_featured'];
        });

        $data = [
            'title' => $title,
            'featured_projects' => $featuredProjects,
            'all_projects' => $projects
        ];

        $styles = ['/assets/css/project.min.css'];


        return new View('site/projetos', $data, $styles);
    }

    public function emCaptacao()
    {

        $projects = $this->fetchProjectsInCaptation();
        $data = [

            'title' => 'Projetos Em Captação',
            'all_projects' => $projects
        ];
        $styles = ['/assets/css/projetos.min.css'];
      
        return new View('site/em-captacao', $data, $styles);
    }

    public function projetosOcorridos()
    {

        $projects = $this->fetchAllProjects();
        $completedProjects = array_filter($projects, function ($project) {
            return $project['status'] === 'completed';
        });

        $data = [
            'title' => 'Projetos Ocorridos',
            'all_projects' => $completedProjects
        ];

        $styles = ['/assets/css/projetos-ocorridos.min.css']; // Novo arquivo CSS, ajuste conforme necessário

        return new View('site/projetos-ocorridos', $data, $styles);
    }

    private function fetchProjectsInCaptation($slug = null)
    {
        $inCaptatiion = [
            [
                'title' => 'Nazari Estúdio: Uma História de Música e Transformação',
                'slug' => 'nazari-estudio',
                'description' => 'Produção de minidocumentário e oficinas de música.',
                'short_description' => 'Porto Alegre, RS, 2025 - Público: a estimar',
                'image' => '/assets/imgs/nazari-estudio.jpg',
                'video' => '',
                'is_featured' => true,
                'status' => 'ongoing',
                'pronac' => '2413782',
                'proponente' => 'Marco Antonio Nazari',
                'cnpj_cpf' => 'CNPJ: 22.291.782/0001-06 / CPF: 302.749.580-15',
                'uf' => 'RS',
                'mecanismo' => 'Mecenato (Art. 18)',
                'area_cultural' => 'Música',
                'segmento' => 'Empreendimentos, Ações Educacionais e Culturais / Capacitação / Treinamento',
                'tipologia' => 'Projetos Normais',
                'tipicidade' => 'Mescla',
                'processo' => '01400.034343/2024-11',
                'portaria' => 'Nº 0001/25 – Publicada em 03/01/2025',
                'valor_captacao' => 'R$ 149.910,75',
                'periodo_captacao' => '01/01/2025 a 31/12/2025',
                'periodo_execucao' => '31/12/2024 a 31/12/2025',
                'situacao' => 'Captação total autorizada (desde 14/02/2025)',
                'resumo' => 'Produção de um minidocumentário de 20 minutos sobre o Nazari Estúdio e sua importância para a cena musical de Porto Alegre. O projeto inclui oficinas gratuitas de música para jovens do bairro Menino Deus afetados por enchentes...',
                'plano_imediato' => 'Não disponível',
                'post_date' => '2025-01-03',
                'content' => 'Produção de um minidocumentário de 20 minutos sobre o Nazari Estúdio e sua importância para a cena musical de Porto Alegre. O projeto inclui oficinas gratuitas de música para jovens do bairro Menino Deus afetados por enchentes, com aulas de bateria, violão, guitarra, cavaquinho, piano e percussão ministradas por músicos renomados. Contrapartidas incluem workshops e apresentações em escolas locais, promovendo acesso, inclusão e continuidade cultural.',
                'extra_image' => '/assets/imgs/nazari-estudio-extra.jpg',
            ],
            [
                'title' => 'O espetáculo infantil O Urso com Música na Barriga – Atimonautas circula pelo RS',
                'slug' => 'urso-com-musica',
                'description' => 'Apresentações de teatro de bonecos.',
                'short_description' => 'Regiões dos rios RS, 2025 - Público: a estimar',
                'image' => '/assets/imgs/urso-com-musica.jpg',
                'video' => '',
                'is_featured' => true,
                'status' => 'ongoing',
                'pronac' => '2414593',
                'proponente' => 'Denis Moreira de Sousa',
                'cnpj_cpf' => 'CNPJ: 23.735.636/0001-87',
                'uf' => 'RS',
                'mecanismo' => 'Mecenato (Art. 18)',
                'area_cultural' => 'Artes Cênicas',
                'segmento' => 'Teatro de Formas Animadas / Mamulengo / Bonecos / Congada',
                'tipologia' => 'Programa Rouanet Emergencial RS',
                'tipicidade' => 'Editais Compartilhados',
                'processo' => '01400.035197/2024-33',
                'portaria' => 'Nº 0245/25 – Publicada em 08/04/2025',
                'valor_captacao' => 'Não disponível',
                'periodo_captacao' => '01/01/2025 a 31/12/2025',
                'periodo_execucao' => '31/12/2024 a 31/12/2025',
                'situacao' => 'Captação total autorizada (desde 09/04/2025)',
                'resumo' => 'Realização de 14 apresentações gratuitas do espetáculo de bonecos O Urso com Música na Barriga, baseado em obra de Erico Veríssimo...',
                'plano_imediato' => 'Não disponível',
                'post_date' => '2025-04-08',
                'content' => 'Realização de 14 apresentações gratuitas do espetáculo de bonecos O Urso com Música na Barriga, baseado em obra de Erico Veríssimo, em 7 cidades das regiões dos rios Taquari, Jacuí, Antas, Sinos e Lago Guaíba. A peça aborda preconceito e bullying contra crianças especiais e neurodivergentes, promovendo cultura, inclusão e empatia para alunos do ensino fundamental público.',
                'extra_image' => '/assets/imgs/urso-com-musica-extra.jpg',
            ],
            [
                'title' => 'Arte Negra do Sul – Tributo a Compositores Negros Brasileiros',
                'slug' => 'arte-negra-sul',
                'description' => 'Espetáculo multimídia afro-brasileiro.',
                'short_description' => 'Porto Alegre, RS, 2025 - Público: a estimar',
                'image' => '/assets/imgs/arte-negra-sul.jpg',
                'video' => '',
                'is_featured' => true,
                'status' => 'ongoing',
                'pronac' => '245671',
                'proponente' => 'HD\'Arte Produção e Eventos LTDA',
                'cnpj_cpf' => 'CNPJ: 91.467.126/0001-26',
                'uf' => 'RS',
                'mecanismo' => 'Mecenato (Art. 18)',
                'area_cultural' => 'Artes Cênicas',
                'segmento' => 'Teatro Musical (com dramaturgia, danças e canções)',
                'tipologia' => 'Samba',
                'tipicidade' => 'Cultura Afro-brasileira',
                'processo' => '01400.018545/2024-16',
                'portaria' => 'Nº 0001/25 – Publicada em 03/01/2025',
                'valor_captacao' => 'R$ 540.020,00',
                'periodo_captacao' => '01/01/2025 a 30/09/2025',
                'periodo_execucao' => '01/09/2024 a 30/09/2025',
                'situacao' => 'Captação total autorizada',
                'resumo' => 'Espetáculo multimídia com 25 artistas e profissionais negros, celebrando o legado afro-brasileiro...',
                'plano_imediato' => 'Sim – Projeto com contrato de patrocínio',
                'post_date' => '2025-01-03',
                'content' => 'Espetáculo multimídia com 25 artistas e profissionais negros, celebrando o legado afro-brasileiro por meio da dança, música, poesia e imagem. Homenageia compositores negros brasileiros e atua como instrumento de retomada cultural pós-tragédia climática no RS, promovendo inclusão, memória e resistência cultural.',
                'extra_image' => '/assets/imgs/arte-negra-sul-extra.jpg',
            ],
            [
                'title' => 'Preta Poesia Feminina – Circulação Nacional e Estadual (RS)',
                'slug' => 'preta-poesia-feminina',
                'description' => 'Espetáculo cênico homenageando poetisas negras.',
                'short_description' => 'Nacional e RS, 2025 - Público: a estimar',
                'image' => '/assets/imgs/preta-poesia-feminina.jpg',
                'video' => '',
                'is_featured' => true,
                'status' => 'ongoing',
                'pronac' => '238461 / 2414581',
                'proponente' => 'Silvia Maria da Silva Duarte LTDA',
                'cnpj_cpf' => 'CNPJ: 12.270.754/0001-40',
                'uf' => 'RS',
                'mecanismo' => 'Mecenato (Art. 18)',
                'area_cultural' => 'Artes Cênicas',
                'segmento' => 'Circulação Nacional: Apresentação ou Performance de Teatro / Circulação RS: Teatro Musical',
                'tipologia' => 'Projetos Normais / Programa Rouanet Emergencial RS',
                'tipicidade' => 'Projetos Normais / Editais Compartilhados',
                'processo' => '01400.027023/2023-16 (Nacional) / 01400.035185/2024-17 (RS)',
                'portaria' => 'Nº 0242/25 – 07/04/2025 (Nacional) / Nº 0246/25 – 08/04/2025 (RS)',
                'valor_captacao' => 'R$ 477.307,91 (Nacional) / R$ 170.640,00 (RS)',
                'periodo_captacao' => '01/01/2025 a 31/12/2025',
                'periodo_execucao' => 'Nacional: 10/10/2023 a 31/12/2025 / RS: 31/12/2024 a 31/12/2025',
                'situacao' => 'Captação total autorizada para ambos os projetos',
                'resumo' => 'Espetáculo cênico que homenageia cinco poetisas negras gaúchas (Ana dos Santos, Delma Gonçalves, Isabete Fagundes Almeida, Fátima Farias e Lilian Rocha)...',
                'plano_imediato' => 'Não disponível',
                'post_date' => '2025-04-07',
                'content' => 'Espetáculo cênico que homenageia cinco poetisas negras gaúchas (Ana dos Santos, Delma Gonçalves, Isabete Fagundes Almeida, Fátima Farias e Lilian Rocha). A atriz e encenadora Silvia Duarte dramatiza 30 poemas numa montagem dirigida por Silvana Rodrigues, transformando poesia em literatura falada no palco. O projeto atua em duas frentes: Circulação Nacional com apresentações em várias regiões do país, e Circulação RS em 4 municípios gaúchos afetados pelas enchentes (Porto Alegre, Canoas, São Leopoldo e Pelotas), contribuindo para a reconstrução simbólica e cultural.',
                'extra_image' => '/assets/imgs/preta-poesia-feminina-extra.jpg',
            ],
            [
                'title' => 'Retomada Terreirão do Samba – Ancestralidade e Cultura Afro-Brasileira em Canoas',
                'slug' => 'retomada-terreirao',
                'description' => 'Oficinas e eventos culturais afro-brasileiros.',
                'short_description' => 'Canoas, RS, 2025 - Público: a estimar',
                'image' => '/assets/imgs/retomada-terreirao.jpg',
                'video' => '',
                'is_featured' => true,
                'status' => 'ongoing',
                'pronac' => '2414843',
                'proponente' => 'Luciara Batista Bento – MEI',
                'cnpj_cpf' => 'CNPJ: 43.748.434/0001-87',
                'uf' => 'RS',
                'mecanismo' => 'Mecenato (Art. 18)',
                'area_cultural' => 'Artes Cênicas',
                'segmento' => 'Ações Educativo-Culturais / Capacitação / Treinamento',
                'tipologia' => 'Samba',
                'tipicidade' => 'Cultura Afro-brasileira',
                'processo' => '01400.035463/2024-28',
                'portaria' => 'Nº 0001/25 – Publicada em 03/01/2025',
                'valor_captacao' => 'R$ 249.628,50',
                'periodo_captacao' => '01/01/2025 a 31/12/2025',
                'periodo_execucao' => '31/01/2025 a 31/01/2026',
                'situacao' => 'Captação total autorizada',
                'resumo' => 'Fortalecimento da identidade afro-brasileira em Canoas (RS) por meio de oficinas, atividades formativas e eventos culturais...',
                'plano_imediato' => 'Sim – Evento de grande porte planejado',
                'post_date' => '2025-01-03',
                'content' => 'Fortalecimento da identidade afro-brasileira em Canoas (RS) por meio de oficinas, atividades formativas e eventos culturais, incluindo saraus, aulas de capoeira, exposições, workshops de dança afro e encontros musicais. Destaque para encontro no Museu e Arquivo Histórico de Canoas com feira de empreendedorismo cultural, oficinas da cadeia produtiva do carnaval e ações sustentáveis. O projeto culmina em evento de grande porte, reafirmando o Terreirão como espaço de memória, resistência e celebração da cultura negra local.',
                'extra_image' => '/assets/imgs/retomada-terreirao-extra.jpg',
            ],
            [
                'title' => '35ª Winter Fest 2025 – Festival 75 anos Jaraguá do Sul – Sociedade Alvorada',
                'slug' => 'winter-fest-2025',
                'description' => 'Festival celebrando tradições germânicas.',
                'short_description' => 'Jaraguá do Sul, SC, 2025 - Público: 10.000',
                'image' => '/assets/imgs/winter-fest-2025.jpg',
                'video' => '',
                'is_featured' => true,
                'status' => 'ongoing',
                'pronac' => '252271',
                'proponente' => 'Sociedade Recreativa Alvorada',
                'cnpj_cpf' => 'CNPJ: 83.784.546/0001-08',
                'uf' => 'SC',
                'mecanismo' => 'Mecenato (Art. 18)',
                'area_cultural' => 'Música',
                'segmento' => 'Apresentação / Gravação de Música Regional',
                'tipologia' => 'Festival, Bienal, Festa ou Feira',
                'tipicidade' => 'Projetos Especiais',
                'processo' => '01400.010264/2025-98',
                'portaria' => 'Nº 0344/25 – Publicada em 20/05/2025',
                'valor_captacao' => 'R$ 672.185,25',
                'periodo_captacao' => '20/05/2025 a 31/12/2025',
                'periodo_execucao' => '26/04/2025 a 31/12/2025',
                'situacao' => 'Captação autorizada (projeto com limite de 10% inicial)',
                'resumo' => 'Edição especial do festival em comemoração aos 75 anos da Sociedade Recreativa Alvorada, enaltecendo tradições germânicas...',
                'plano_imediato' => 'Não disponível',
                'post_date' => '2025-05-20',
                'content' => 'Edição especial do festival em comemoração aos 75 anos da Sociedade Recreativa Alvorada, enaltecendo tradições germânicas e identidade cultural de Jaraguá do Sul (SC). Programação com danças tradicionais (CTG e folclore alemão), desfiles de trajes típicos, apresentações étnicas, gastronomia regional, coroação do rei e rainha, shows musicais e competições culturais. Público esperado de até 10 mil pessoas, promovendo integração comunitária e fortalecimento cultural da região Sul do Brasil.',
                'extra_image' => '/assets/imgs/winter-fest-2025-extra.jpg',
            ],
        ];

        if ($slug == null) {

            return $inCaptatiion;
        } else if ($this->getArraKey($slug, $inCaptatiion) !== null) {

            $idx = $this->getArraKey($slug, $inCaptatiion);
            return $inCaptatiion[$idx];
        } else {

            return null;
        }
    }


    private function getArraKey(string $slug, array $array)
    {
        if (is_array($array) && $slug !== null) {
            foreach ($array as $key => $item) {
                if (isset($item['slug']) && $item['slug'] === $slug) {
                    return $key;
                }
            }
        }

        return null;
    }
}
