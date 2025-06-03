<?php 

namespace App\Model;
use App\Model\ModelBase;


class User extends ModelBase
{

    protected $table = 'usuarios';
    protected $alias = 'u';
    protected $fillable = [
        'nome',
        'email',
        'senha',
        'nome_exibicao',
        'usuario',
        'funcao',
        'criado_por'
    ];

    /**
     * Update register of last login
     * @param $id | int
     * @param $lastLogin | date
     * @return true || null
     */
    public function updateLastLogin($id, $lastLogin)
    {
        $sql = "UPDATE usuarios as u SET u.ultimo_login = :ultimo_login WHERE u.id = :id";
        $this->db->prepare($sql);
        $this->db->bind(':ultimo_login', $lastLogin);
        $this->db->bind(':id', $id, null);
        $result = $this->db->execute([]);
        return $result;
    }

    public function deleteByRole($roleName)
    {
        $sql = "DELETE FROM usuarios WHERE funcao = :funcao";
        $this->db->prepare($sql);
        $this->db->bind(':funcao', $roleName);
        return $this->db->execute([]);
    }

    
}