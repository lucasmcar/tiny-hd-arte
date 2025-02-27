<?php 

namespace App\Model;

class Depoimento 
{
    private $idDepoimento;
    private $nome;
    private $profissao;
    private $depoimento;
    private $titulo;
    private $foto;
    private $dataCriacao;

    public function getIdDepoimento()
    {
        return $this->idDepoimento;
    }

    public function setIdDepoimento($idDepoimento)
    {
        $this->idDepoimento = $idDepoimento;
    }

    public function getNome()
    {
        return $this->nome;
    }

    public function setNome($nome)
    {
        $this->nome = $nome;
    }

    public function getProfissao()
    {
        return $this->profissao;
    }

    public function setProfissao($profissao)
    {
        $this->profissao = $profissao;
    }

    public function getDepoimento()
    {
        return $this->depoimento;
    }

    public function setDepoimento($depoimento)
    {
        $this->depoimento = $depoimento;
    }

    public function getTitulo()
    {
        return $this->titulo;
    }

    public function setTitulo($titulo)
    {
        $this->titulo = $titulo;
    }

    public function getFoto()
    {
        return $this->foto;
    }

    public function setFoto($foto)
    {
        $this->foto = $foto;
    }

    public function getDataCriacao()
    {
        return $this->dataCriacao;
    }

    public function setDataCriacao($dataCriacao)
    {
        $this->dataCriacao = $dataCriacao;
    }
    
}