<?php
namespace App\Model;

use App\Connection\DB;

class ModelBase
{
    protected $table;
    protected $fillable;
    protected $db;
    private $conditions = [];
    private $bindings = [];

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

    public function create($data)
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

        // Adiciona uma cláusula WHERE
    public function where($column, $operator, $value)
    {
        $paramName = ":param_" . count($this->bindings); // Gera um nome único para o binding
        $column = "LOWER($column)"; // Adiciona LOWER para tornar a comparação insensível a maiúsculas/minúsculas
        $value = strtolower($value); // Garante que o valor também seja convertido para minúsculas
        $this->conditions[] = ['AND', "$column $operator $paramName"];
        $this->bindings[$paramName] = $value;
        return $this;
    }

    // Adiciona uma cláusula OR WHERE
    public function orWhere($column, $operator, $value)
    {
        $paramName = ":param_" . count($this->bindings); // Gera um nome único para o binding
        $column = "LOWER($column)"; // Adiciona LOWER para tornar a comparação insensível a maiúsculas/minúsculas
        $value = strtolower($value); // Garante que o valor também seja convertido para minúsculas
        $this->conditions[] = ['OR', "$column $operator $paramName"];
        $this->bindings[$paramName] = $value;
        return $this;
    }

    // Executa a consulta com as condições
    public function get()
    {
        if (empty($this->conditions)) {
            return $this->all();
        }

        $sql = "SELECT * FROM {$this->table} WHERE ";
        $conditionsStr = '';
        foreach ($this->conditions as $index => [$logic, $condition]) {
            if ($index === 0) {
                $conditionsStr .= $condition;
            } else {
                $conditionsStr .= " $logic $condition";
            }
        }
        $sql .= $conditionsStr;

        $stmt = $this->connect()->prepare($sql);
        foreach ($this->bindings as $param => $value) {
            $stmt->bindValue($param, $value, is_int($value) ? \PDO::PARAM_INT : \PDO::PARAM_STR);
        }
        $stmt->execute();
        $results = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        // Reseta as condições e bindings para a próxima consulta
        $this->conditions = [];
        $this->bindings = [];

        return $results;
    }
}