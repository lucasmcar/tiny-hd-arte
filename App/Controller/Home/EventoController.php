<?php

namespace App\Controller\Home;

class EventoController
{
    public function eventosProximos()
    {
        $data = json_decode(file_get_contents('php://input'), true);
        $latitude = $data['latitude'] ?? null;
        $longitude = $data['longitude'] ?? null;
        $ip = $_SERVER["REMOTE_ADDR"];

        print_r(['data' => $data, 'ip' => $ip]); // Debug: Verificar os dados recebidos
        die();
        

        // Exemplo de resposta (substitua com a lógica real de obtenção dos eventos)
        $eventos = [
            ['nome' => 'Evento A', 'data' => '2024-07-15', 'local' => 'Local A'],
            ['nome' => 'Evento B', 'data' => '2024-07-20', 'local' => 'Local B'],
        ];

        header('Content-Type: application/json');
        echo json_encode($eventos);
    }
}

$controller = new EventoController();
$controller->eventosProximos();
