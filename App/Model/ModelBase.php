<?php 

namespace App\Model;

use App\Connection\DB;

class ModelBase
{
    protected $table;
    protected $fillable;

    protected function connect()
    {
        return new DB();
    }

    public function all()
    {
        $sql = "SELECT * FROM {$this->table}";
        $stmt = $this->connect()->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public function find($id)
    {
        $sql = "SELECT * FROM {$this->table} WHERE id = :id";
        $stmt = $this->connect()->prepare($sql);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        return $stmt->fetch();
    }

    public function findForSign($email)
    {
        $sql = "SELECT * FROM {$this->table} WHERE email = :email LIMIT 1";
        $stmt = $this->connect()->prepare($sql);
        $stmt->bindParam(':email', $email);
        $stmt->execute();
        return $stmt->fetch();
    }

    public function create($data)
    {
        $fields = implode(',', $this->fillable);
        $values = ':' . implode(',:', $this->fillable);
        $sql = "INSERT INTO {$this->table} ({$fields}) VALUES ({$values})";
        $stmt = $this->connect()->prepare($sql);
        foreach ($this->fillable as $field) {
            $stmt->bindParam(":$field", $data[$field]);
        }
        return $stmt->execute();
    }

    public function update($id, $data)
    {
        $fields = implode(' = :', $this->fillable) . ' = :';
        $sql = "UPDATE {$this->table} SET {$fields} WHERE id = :id";
        $stmt = $this->connect()->prepare($sql);
        foreach ($this->fillable as $field) {
            $stmt->bindParam(":$field", $data[$field]);
        }
        $stmt->bindParam(':id', $id);
        return $stmt->execute();
    }

    public function delete($id)
    {
        $sql = "DELETE FROM {$this->table} WHERE id = :id";
        $stmt = $this->connect()->prepare($sql);
        $stmt->bindParam(':id', $id);
        return $stmt->execute();
    }

    
}