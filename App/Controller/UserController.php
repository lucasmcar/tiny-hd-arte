<?php

namespace App\Controller;

use App\Core\View\View;
use App\Helper\InputFilterHelper;
use App\Model\User;
use App\Core\Security\Jwt\JwtHandler;
use App\Core\Security\Csrf;

class UserController
{
    public function login()
    {
        $data = [
            'title' => 'Login'
        ];

        $styles = [
            '/assets/css/admin/login.css'
        ];
        $scripts = [
            '/assets/js/main-admin.js'
        ];


        return new View(view: 'admin/login', vars: $data, styles: $styles, scripts: $scripts, layout: 'admin-layout');
    }

    public function registrar()
    {
        $data = [
            'title' => 'Registrar'
        ];

        $styles = [
            '/assets/css/cria_conta.css'
        ];
        $scripts = [
            '/assets/js/cria_conta.js'
        ];

        return new View(view: 'admin/cria_conta', vars: $data, styles: $styles, scripts: $scripts, layout: 'admin-layout');
    }

    public function criarUsuario()
    {
        $data = InputFilterHelper::filterInputs(INPUT_POST, [
            'nome',
            'email',
            'senha'
        ]);
    }

    public function insertData()
    {
        $usuario = new User();

        $usuario->create([
            'nome' => 'Teste',
            'email' => 'teste@teste.com.br',
            'senha' => password_hash('123456', PASSWORD_BCRYPT),
            'usuario' => 'teste',
        ]);
    }

    public function signIn()
    {
        $data = InputFilterHelper::filterInputs(INPUT_POST, [
            'email',
            'senha',
            '_csrf_token'
        ]);

        if (!Csrf::verifyToken($data['_csrf_token'])) {
            header('location: /admin/login');
            return;
        }

        $user = new User();
        $email = $user->findForSign($data['email']);


        if ($email && password_verify($data['senha'], $email[0]['senha'])) {

            $payload = [
                'iat' => time(),              // Issued at
                'exp' => time() + (60 * 60),  // Expira em 1 hora
                'sub' => $email[0]['id'],         // Subject (ID do usuário)
                'name' => $email[0]['nome'],      // Nome do usuário
                'email' => $email[0]['email']     // E-mail do usuário
            ];

            // Gera o token com JwtHandler
            $jwt = JwtHandler::generateToken($payload);

            // Inicia a sessão se não estiver ativa
            if (!session_id()) {
                session_start();
            }
            $_SESSION['jwt'] = $jwt; // Armazena o token na sessão
            $_SESSION['jwt_exp'] = $payload['exp']; // Armazena a expiração do token na sessão

            $user->updateLastLogin($email[0]['id'], date('Y-m-d H:i:s'));

            // Redireciona para /admin/home
            header('Location: /admin/home');
        } else {
            header('location: /admin/login');
        }
    }

    public function logout()
    {
        ob_start();
        header('Content-Type: application/json');

        if (!session_id()) {
            session_start();
        }

        // Verifica o CSRF token
        /*$data = json_decode(file_get_contents('php://input'), true);
        $csrfToken = $data['_csrf_token'] ?? null;
        if (!Csrf::verifyToken($csrfToken)) {
            http_response_code(403);
            echo json_encode(['success' => false, 'message' => 'Token CSRF inválido']);
            ob_end_flush();
            return;
        }*/

        // Determina o método da requisição
        $requestMethod = $_SERVER['REQUEST_METHOD'];

        // Obtém o CSRF token dependendo do método
        $csrfToken = null;
        if ($requestMethod === 'POST') {
            // Para requisições POST (contador regressivo), o token vem no corpo JSON
            $data = json_decode(file_get_contents('php://input'), true);
            $csrfToken = $data['_csrf_token'] ?? null;
        } else {
            // Para requisições GET (sidebar), o token pode vir como parâmetro de query ou cabeçalho
            $csrfToken = $_GET['_csrf_token'] ?? $_SERVER['HTTP_X_CSRF_TOKEN'] ?? null;
        }

        // Valida o CSRF token
        if (!$csrfToken || !Csrf::verifyToken($csrfToken)) {
            if ($requestMethod === 'POST') {
                // Resposta JSON para o contador regressivo
                header('Content-Type: application/json');
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'Token CSRF inválido']);
                ob_end_flush();
                return;
            } else {
                // Redireciona com erro para o sidebar
                header('Location: /admin/login?error=csrf_invalid');
                ob_end_flush();
                exit;
            }
        }

        // Limpa todas as variáveis de sessão relacionadas
        if (isset($_SESSION['jwt'])) {
            unset($_SESSION['jwt']);
        }
        if (isset($_SESSION['jwt_exp'])) {
            unset($_SESSION['jwt_exp']);
        }

        // Destrói a sessão completamente
        session_unset();
        session_destroy();

        // Limpa cookies de sessão
        if (ini_get("session.use_cookies")) {
            $params = session_get_cookie_params();
            setcookie(
                session_name(),
                '',
                time() - 42000,
                $params["path"],
                $params["domain"],
                $params["secure"],
                $params["httponly"]
            );
        }

        // Responde de acordo com o método da requisição
        if ($requestMethod === 'POST') {
            // Resposta JSON para o contador regressivo
            header('Content-Type: application/json');
            ob_end_clean();
            echo json_encode(['success' => true, 'message' => 'Logout realizado com sucesso']);
        } else {
            // Redireciona para o sidebar
            ob_end_clean();
            header('Location: /admin/login');
            exit;
        }
        /*if($_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest'){
            header('location: admin/login');
            exit;
        }

        ob_end_clean();
        echo json_encode(['success' => true, 'message' => 'Logout realizado com sucesso']);*/
    }

    public function logoutBySidebar()
    {

        if (!session_id()) {
            session_start();
        }

        // Limpa o JWT da sessão
        unset($_SESSION['jwt']);

        // Opcional: Destroi completamente a sessão
        session_destroy();

        // Redireciona para a página de login

        header('Location: /admin/login');
        exit;
    }
}
