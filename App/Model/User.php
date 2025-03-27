<?php 

namespace App\Model;
use App\Model\ModelBase;


class User extends ModelBase
{

    protected $table = 'usuarios';
    protected $fillable = [
        'nome',
        'email',
        'senha',
        'foto',
        'usuario',
        'funcao'
    ];
    
}