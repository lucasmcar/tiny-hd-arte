<?php
namespace App\Model;

use App\Connection\DB;

class ModelBase
{
    protected $table;
    protected $fillable;
    protected $db;

    public function __construct()
    {
        $this->db = new DB(); // Uma única instância por modelo
    }

    protected function connect(): DB
    {
        return $this->db;
    }

    public function all(): array
    {
        $sql = "SELECT * FROM {$this->table}";
        $this->connect()->prepare($sql);
        return $this->connect()->rs();
    }

    public function find($id): ?array
    {
        $sql = "SELECT * FROM {$this->table} WHERE id = :id";
        $this->connect()->prepare($sql);
        $this->connect()->bind(':id', $id);
        return $this->connect()->one();
    }

    public function findForSign($email): array
    {
        $sql = "SELECT * FROM {$this->table} WHERE email = :email LIMIT 1";
        $this->connect()->prepare($sql);
        $this->connect()->bind(':email', $email);
        return $this->connect()->rs();
    }

    public function create($data): int
    {
        $fields = implode(',', $this->fillable);
        $values = ':' . implode(',:', $this->fillable);
        $sql = "INSERT INTO {$this->table} ({$fields}) VALUES ({$values})";
        $this->connect()->prepare($sql);
        foreach ($this->fillable as $field) {
            $this->connect()->bind(":$field", $data[$field]);
        }
        $this->connect()->execute();
        return $this->connect()->lastInsertId();
    }

    public function update($id, $data): bool
    {
        $fields = array_map(fn($field) => "$field = :$field", $this->fillable);
        $setClause = implode(',', $fields);
        $sql = "UPDATE {$this->table} SET {$setClause} WHERE id = :id";
        $this->connect()->prepare($sql);
        foreach ($this->fillable as $field) {
            $this->connect()->bind(":$field", $data[$field]);
        }
        $this->connect()->bind(':id', $id);
        return $this->connect()->execute();
    }

    public function delete($id): bool
    {
        $sql = "DELETE FROM {$this->table} WHERE id = :id";
        $this->connect()->prepare($sql);
        $this->connect()->bind(':id', $id);
        return $this->connect()->execute();
    }
}