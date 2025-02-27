<?php 

namespace App\Model;

class Blog
{
    public $id;
    public $titulo;
    public $conteudo;
    public $imagem;
    public $data_publicacao;
    public $autor;

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;
    }

    public function getTitulo()
    {
        return $this->titulo;
    }

    public function setTitulo($titulo)
    {
        $this->titulo = $titulo;
    }

    public function getConteudo()
    {
        return $this->conteudo;
    }

    public function setConteudo($conteudo)
    {
        $this->conteudo = $conteudo;
    }

    public function getImagem()
    {
        return $this->imagem;
    }

    public function setImagem($imagem)
    {
        $this->imagem = $imagem;
    }

    public function getDataPublicacao()
    {
        return $this->data_publicacao;
    }

    public function setDataPublicacao($data_publicacao)
    {
        $this->data_publicacao = $data_publicacao;
    }

    public function getAutor()
    {
        return $this->autor;
    }

    public function setAutor($autor)
    {
        $this->autor = $autor;
    }
}