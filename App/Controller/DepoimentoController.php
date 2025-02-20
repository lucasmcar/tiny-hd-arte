<?php

namespace App\Controller;

use App\Helper\InputFilterHelper;

class DepoimentoController
{
    public function criar()
    {
        $data = InputFilterHelper::filterInputs(INPUT_POST, [
            'nome',
            'profissao',
            'depoimento'
        ]);
    }
}