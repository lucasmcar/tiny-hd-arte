<?php

namespace App\Controller;

use App\Core\View\View;
use App\Helper\InputFilterHelper;
use App\Model\Usuario;
use App\Core\Security\Jwt\JwtHandler;
use App\Core\Security\Csrf;
use App\Repository\UsuarioRepository;
use PhpParser\Node\Expr\Throw_;

class UserController
{
    public function login()
    {
        $data = [
            'title' => 'Login'
        ];

        $styles = [
            '/assets/css/admin/login.min.css'
        ];
        $scripts = [

            '/assets/js/main-admin.min.js',
            '/assets/js/login.min.js',
        ];


        return new View(view: 'admin/login', vars: $data, styles: $styles, scripts: $scripts, layout: 'admin-layout');
    }

    public function registrar()
    {
        $data = [
            'title' => 'Registrar'
        ];

        $styles = [
            '/assets/css/cria_conta.min.css'
        ];
        $scripts = [
            '/assets/js/cria_conta.min.js'
        ];

        return new View(view: 'admin/cria_conta', vars: $data, styles: $styles, scripts: $scripts, layout: 'admin-layout');
    }


    public function criarUsuario()
    {
        throw "Not implementend";
    }

    public function insertData()
    {
        $repository = new UsuarioRepository();

        $repository->create([
            'nome' => 'Michelle',
            'email' => 'teste@teste.com.br',
            'senha' => password_hash('123456', PASSWORD_BCRYPT),
            'foto' => '/assets/imgs/michelle.jpg',
            'usuario' => 'teste',
            'funcao' => 'admin'
        ]);
    }

    public function signIn()
    {
        if (json_decode(file_get_contents('php://input'), true)) {
            $data = json_decode(file_get_contents('php://input'), true);
        } else {
            $data = InputFilterHelper::filterInputs(INPUT_POST, [
                'email',
                'senha',
                '_csrf_token'
            ]);
        }

        // Verifica o token CSRF
        if (!Csrf::verifyToken($data['_csrf_token'])) {
            http_response_code(400);
            echo json_encode(['success' => false, 'message' => 'Token CSRF inválido.']);
            return;
        }

        $userRepository = new UsuarioRepository();
        $email = $userRepository->findForSign($data['email']);

        if ($email && password_verify($data['senha'], $email[0]['senha'])) {
            $payload = [
                'iat' => time(),
                'exp' => time() + (60 * 60),
                'sub' => $email[0]['id'],
                'name' => $email[0]['nome'],
                'email' => $email[0]['email']
            ];

            $jwt = JwtHandler::generateToken($payload);

            if (!session_id()) {
                session_start();
            }

            $_SESSION['jwt'] = $jwt;
            $_SESSION['jwt_exp'] = $payload['exp'];
            $_SESSION['foto'] = $email[0]['foto'];
            $userRepository->updateLastLogin($email[0]['id'], date('Y-m-d H:i:s'));

            // Retorna sucesso em JSON
            echo json_encode(['success' => true, 'message' => 'Login realizado com sucesso!', 'redirect' => '/admin/home']);
        } else {
            http_response_code(401);
            echo json_encode(['success' => false, 'message' => 'E-mail ou senha inválidos.', 'redirect' => '/admin/login']);
        }
    }

    public function logout()
    {
        ob_start();
        header('Content-Type: application/json');

        if (!session_id()) {
            session_start();
        }

        // Verifica se é uma requisição AJAX
        $isAjax = !empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest';

        // Obtém o CSRF token dependendo do método
        $requestMethod = $_SERVER['REQUEST_METHOD'];
        $csrfToken = null;
        if ($requestMethod === 'POST') {
            $data = json_decode(file_get_contents('php://input'), true);
            $csrfToken = $data['_csrf_token'] ?? null;
        } else {
            $csrfToken = $_GET['_csrf_token'] ?? $_SERVER['HTTP_X_CSRF_TOKEN'] ?? null;
        }

        // Valida o CSRF token
        if (!$csrfToken || !Csrf::verifyToken($csrfToken)) {
            $response = ['success' => false, 'message' => 'Token CSRF inválido'];
            if ($isAjax) {
                http_response_code(403);
                echo json_encode($response);
            } else {
                header('Location: /admin/login?error=csrf_invalid');
            }
            ob_end_flush();
            exit;
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

        // Responde de acordo com o método e tipo de requisição
        $response = ['success' => true, 'message' => 'Logout realizado com sucesso'];
        if ($isAjax) {
            ob_end_clean();
            echo json_encode($response);
        } else {
            ob_end_clean();
            header('Location: /admin/login');
        }
        ob_end_flush();
        exit;
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

    public function getCsrfToken()
    {

        header('Content-Type: application/json');

        if (!session_id()) {
            session_start();
        }

        if (empty($_SESSION['_csrf_token'])) {
            $_SESSION['_csrf_token'] = Csrf::generateToken();
        }

        echo json_encode([
            'csrfToken' => $_SESSION['_csrf_token']
        ]);
    }
}
