<?php

namespace App\Controller;

use App\Core\View\View;
use App\Model\Edital;
use App\Model\Log;

use App\Helper\InputFilterHelper;
use App\Core\Security\Csrf;

class EditalController
{
    public function editais()
    {
        $editaisData = new Edital();

        $data = [
            'title' => 'Gerenciar Editais',
            'editais' => $editaisData->all(),
        ];

        $styles = [

            '/assets/css/admin/edital.css'
        ];
        $scripts = [
            '/assets/js/edital.js'
        ];
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
        header('Content-Type: application/json');
        if (!isset($_SESSION['jwt']) || !\App\Core\Security\Jwt\JwtHandler::validateToken($_SESSION['jwt'])) {
            http_response_code(401);
            echo json_encode(['success' => false, 'message' => 'Não autenticado']);
            return;
        }
        $edital = new Edital();
        $editais = $edital->all();
        echo json_encode(['editais' => $editais]);
    }

    /*public function alterarStatusEdital()
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
    }*/

    public function alterarStatusEdital()
    {
        ob_start();
        header('Content-Type: application/json');
        session_start();

        // Verificar autenticação
        if (!isset($_SESSION['jwt']) || !\App\Core\Security\Jwt\JwtHandler::validateToken($_SESSION['jwt'])) {
            http_response_code(403);
            echo json_encode(['success' => false, 'message' => 'Não autenticado']);
            return;
        }

        $data = json_decode(file_get_contents('php://input'), true);
        $id = $data['id'] ?? null;
        $status = $data['status'] ?? null;
        $csrfToken = $data['_csrf_token'] ?? null;



        if (!Csrf::verifyToken($csrfToken)) {
            http_response_code(403);
            return;
        }

        if (!$id || !in_array($status, ['em_analise', 'aprovado', 'reprovado'])) {
            http_response_code(400);
            echo json_encode(['success' => false, 'message' => 'Dados inválidos']);
            return;
        }

        try {
            $editalModel = new Edital();
            $edital = $editalModel->find($id);
            if (!$edital) {
                http_response_code(404);
                echo json_encode(['success' => false, 'message' => 'Edital não encontrado']);
                return;
            }

            $oldStatus = $edital['status'];
            $editalModel->update($id, ['status' => $status, 'name' => $edital['name'], 'filename' => $edital['filename'], 'url' => $edital['url']]);

            $logModel = new Log();
            $logModel->create([
                'acao' => 'alteracao_status_edital',
                'tabela_afetada' => 'editais',
                'id_registro' => $id,
                'detalhes' => json_encode(['status_antigo' => $oldStatus, 'status_novo' => $status]),
                'data_acao' => date('Y-m-d H:i:s')
            ]);
            ob_end_clean(); 
            echo json_encode([
                'id' => $id,
                'status' => ucfirst($status),
                'name' => $edital['name'],
                'data_upload' => $edital['data_upload'],
                'filename' => $edital['filename'],
                'url' => $edital['url'],
                'success' => true,
                'message' => 'Status atualizado'
            ]);
        } catch (\Exception $e) {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Erro ao atualizar status: ' . $e->getMessage()]);
        }
    }
}
