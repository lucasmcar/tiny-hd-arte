<?php 

namespace App\Model;

class User
{
    private $id;
    private $nome;
    private $email;
    private $senha;
    private $foto;
    private $usuario;
    private $data_criacao;
    private $data_atualizacao;

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;
    }

    public function getNome()
    {
        return $this->nome;
    }   

    public function setNome($nome)
    {
        $this->nome = $nome;
    }

    public function getEmail()
    {
        return $this->email;
    }

    public function setEmail($email)
    {
        $this->email = $email;
    }

    public function getSenha()
    {
        return $this->senha;
    }

    public function setSenha($senha)
    {
        $this->senha = $senha;
    }

    public function getFoto()
    {
        return $this->foto;
    }

    public function setFoto($foto)
    {
        $this->foto = $foto;
    }

    public function getUsuario()
    {
        return $this->usuario;
    }

    public function setUsuario($usuario)
    {
        $this->usuario = $usuario;
    }

    public function getDataCriacao()
    {
        return $this->data_criacao;
    }

    public function setDataCriacao($data_criacao)
    {
        $this->data_criacao = $data_criacao;
    }

    public function getDataAtualizacao()
    {
        return $this->data_atualizacao;
    }

    public function setDataAtualizacao($data_atualizacao)
    {
        $this->data_atualizacao = $data_atualizacao;
    }
}