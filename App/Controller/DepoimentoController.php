<?php

namespace App\Controller;

use App\Helper\InputFilterHelper;
use App\Model\Depoimento;
use App\Repository\DepoimentoRepository;
use App\Core\View\View;

class DepoimentoController
{
    public function criar()
    {
        $data = InputFilterHelper::filterInputs(INPUT_POST, [
            'nome',
            'profissao',
            'titulo',
            'depoimento'
        ]);

        $depoimento = new Depoimento();

        $depoimento->setNome($data['nome']);
        $depoimento->setProfissao($data['profissao']);
        $depoimento->setTitulo($data['titulo']);
        $depoimento->setDepoimento($data['depoimento']);

        $depoimentoRepository = new DepoimentoRepository();
        $depoimentoRepository->criaDepoimento($depoimento);

        header('location: /depoimentos/todos');
    }

    public function todosDepoimentos()
    {
        $depoimentoRepository = new DepoimentoRepository();
        $depoimentos = $depoimentoRepository->verDepoimentos();

        $data = [
            'title' => 'Todos os Depoimentos',
            'depoimentos' => $depoimentos
        ];

        return new View('admin/depoimentos', $data, 'admin-layout');
    }
}