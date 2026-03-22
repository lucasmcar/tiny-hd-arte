<?php

namespace App\Model;
use App\Model\ModelBase;

class Projetos extends ModelBase
{
    protected $table = 'projetos';
    protected $alias = 'pj';
    protected $fillable = [
    ];

    public function getTodosProjetos()
    {
        return $this
            ->alias('pj')
            ->join('dados_legais_rouanet d', 'pj.id = d.projeto_id')
            ->join('categorias c', 'pj.categoria_id = c.id')
            ->join('proponentes pr', 'pj.proponente_id = pr.id')
            ->get([
                'pj.*',
                'd.*',
                'c.*',
                'pr.*'
            ]);
    }

    public function getProjetoPorNome(string $nome = '')
    {
        $nome = "%{$nome}%";
        return $this
            ->alias('pj')
            ->join('dados_legais_rouanet d', 'pj.id = d.projeto_id')
            ->join('categorias c', 'pj.categoria_id = c.id')
            ->join('proponentes pr', 'pj.proponente_id = pr.id')
            ->where('pj.title', 'LIKE', $nome)
            ->get();
    }

}