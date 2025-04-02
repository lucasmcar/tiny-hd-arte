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
        $scripts =[
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
        $scripts =[
            '/assets/js/cria_conta.js'
        ];

        return new View(view: 'admin/cria_conta', vars: $data, styles:  $styles, scripts: $scripts, layout: 'admin-layout');
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


        if($email && password_verify($data['senha'], $email[0]['senha'])) {
           
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
        } 
        else{
            header('location: /admin/login');
        }

    }

    public function logout()
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