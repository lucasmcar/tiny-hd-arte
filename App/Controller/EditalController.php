<?php
namespace App\Controller;

use App\Core\View\View;
use App\Model\Edital;
use App\Model\Log;

class EditalController
{
    public function editais()
    {
        $data = [
            'title' => 'Gerenciar Editais'
        ];

        $styles = [
            '/assets/css/admin/edital.css'
        ];
        $scripts = ['/assets/js/edital.js'];
        return new View(view: 'admin/edital', vars: $data, styles: $styles, scripts: $scripts, layout: 'admin-layout');
    }

    public function uploadEdital()
    {
        if (!isset($_FILES['edital_file'])) {
            echo json_encode(['success' => false, 'message' => 'Nenhum arquivo enviado']);
            return;
        }

        $file = $_FILES['edital_file'];
        $filename = uniqid() . '-' . basename($file['name']);
        $uploadDir = __DIR__ . '/../../public/uploads/editais/';
        $uploadPath = $uploadDir . $filename;

        if (!is_dir($uploadDir)) {
            mkdir($uploadDir, 0777, true);
        }

        if (move_uploaded_file($file['tmp_name'], $uploadPath)) {
            $edital = new Edital();
            $jwt = $_SESSION['jwt'] ?? null;
            $usuarioId = null;
            if ($jwt) {
                $decoded = \App\Core\Security\Jwt\JwtHandler::validateToken($jwt);
                $usuarioId = $decoded->sub ?? null; // Extrai o 'sub' do token decodificado
            }

            $success = $edital->create([
                'usuario_id' => $usuarioId,
                'name' => $file['name'],
                'filename' => $filename,
                'url' => '/uploads/editais/' . $filename,
                'status' => 'Em Análise'
            ]);

            if ($success) {
                echo json_encode(['success' => true, 'filename' => $file['name']]);
            } else {
                echo json_encode(['success' => false, 'message' => 'Erro ao salvar no banco']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Erro ao salvar o arquivo']);
        }
    }

    public function listarEditais()
    {
        $edital = new Edital();
        $editais = $edital->all();
        echo json_encode(['editais' => $editais]);
    }

    public function alterarStatusEdital()
    {
        $data = json_decode(file_get_contents('php://input'), true);
        $id = $data['id'] ?? null;
        $status = $data['status'] ?? null;

        if (!$id || !$status) {
            echo json_encode(['success' => false, 'message' => 'Dados inválidos']);
            return;
        }

        $edital = new Edital();
        $editalData = $edital->find($id);
        if ($editalData) {
            $success = $edital->update($id, ['status' => $status]);
            if ($success) {
                echo json_encode(['success' => true, 'filename' => $editalData['filename']]);
            } else {
                echo json_encode(['success' => false, 'message' => 'Erro ao atualizar status']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Edital não encontrado']);
        }
    }
}