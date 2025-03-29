<?php

namespace App\Model;

class Edital extends ModelBase
{
    protected $table = 'editais';
    protected $fillable = ['name', 'filename', 'url', 'status'];
}