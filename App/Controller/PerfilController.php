<?php

namespace App\Controller;

use App\Core\View\View;
use App\Model\User;
use App\Model\Administrador;
use App\Core\Security\Jwt\JwtHandler;
use App\Helper\InputFilterHelper;
use App\Core\Security\Csrf;
use App\Model\EmailsEmpresa;
use App\Helper\JsonHelper;

class PerfilController
{
    public function perfil()
    {
        $data = [];
        if(session_id()){
            $data = JwtHandler::validateToken($_SESSION['jwt']);
        }

        $user = new User();
        $admin = new Administrador();
        $emailsEmpresa = new EmailsEmpresa();

        $result = $user->get();
        $admins = $admin->join('usuarios as u','a.usuario_id = u.id')
        ->get(['a.id','a.nome', 'a.email']);
        $emails = $emailsEmpresa->join('usuarios as u', 'emp.usuario_id = u.id')
        ->get(['emp.id','emp.email']);
        
        $adminData = 
        [
            'title' => 'Perfil Administrativo',
            'adminData' => $result[0],
            'admins' => $admins,
            'emails_empresa' => $emails
        ];
        

        $styles = ['/assets/css/perfil.min.css'];
        $scripts = ['/assets/js/perfil.min.js'];

        return new View('admin/perfil', $adminData, $styles, $scripts, 'admin-layout');
    }

    public function updateProfile()
    {
        try {
            $data = json_decode(file_get_contents('php://input'), true) ?? [];

            // Verificar CSRF
            if (!isset($data['_csrf_token']) || !Csrf::verifyToken($data['_csrf_token'])) {
                return $this->jsonResponse(['success' => false, 'message' => 'Token CSRF inválido.'], 403);
            }

            // Verificar sessão
            if (!session_id()) {
                return $this->jsonResponse(['success' => false, 'message' => 'Usuário não autenticado.'], 401);
            }

            $adminData = new Administrador();
            $emailEmpresaData = new EmailsEmpresa();
            $dados = JwtHandler::validateToken($_SESSION['jwt']);
            $userData = new User();

            $userResult = $userData->findForSign($dados['email']);
            if (!$userResult || empty($userResult)) {
                return $this->jsonResponse(['success' => false, 'message' => 'Usuário não encontrado.'], 404);
            }

            $userId = $userResult[0]['id'];

            // Inicializar os arrays
            $admins = [];
            $emails = [];

            // Atualizar administradores
            $adminData->deleteByUserId($userId);
            if (isset($data['admins']) && is_array($data['admins'])) {
                foreach ($data['admins'] as $admin) {
                    $lastId = $adminData->create([
                        'usuario_id' => $userId,
                        'nome' => $admin['nome'],
                        'email' => $admin['email'],
                        'funcao' => 'admin'
                    ]);
                    if ($lastId > 0) {
                        $admins[] = ['id' => $lastId, 'nome' => $admin['nome'], 'email' => $admin['email']];
                    }
                }
            }

            // Atualizar e-mails da empresa
            $emailEmpresaData->deleteByUserId($userId);
            if (isset($data['emails_empresa']) && is_array($data['emails_empresa'])) {
                foreach ($data['emails_empresa'] as $email) {
                    $lastId = $emailEmpresaData->create([
                        'usuario_id' => $userId,
                        'email' => $email['email']
                    ]);
                    if ($lastId > 0) {
                        $emails[] = ['id' => $lastId, 'email' => $email['email']];
                    }
                }
            }

            // Retornar resposta JSON
            return $this->jsonResponse([
                'success' => true,
                'message' => 'Perfil atualizado com sucesso!',
                'data' => [
                    'admins' => $admins,
                    'emails_empresa' => $emails // Corrigido para corresponder ao esperado pelo frontend
                ]
            ]);
        } catch (\Exception $e) {
            error_log("Erro no updateProfile: " . $e->getMessage() . "\n" . $e->getTraceAsString());
            return $this->jsonResponse([
                'success' => false,
                'message' => 'Erro interno: ' . $e->getMessage()
            ], 500);
        }
    }

    private function jsonResponse($data, $statusCode = 200)
    {
        header('Content-Type: application/json');
        http_response_code($statusCode);
        echo json_encode($data);
        exit;
    }
}