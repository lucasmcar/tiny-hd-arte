<?php

namespace App\Controller;

use App\Controller\Controller;
use App\Core\Security\Jwt\JwtHandler;
use App\Core\View\View;
use App\Repository\UsuarioRepository;


class DashboardController implements Controller
{
    public function create()
    {
        throw new \Exception("Metódo não implementado", 1);
    }

    public function show()
    {
        if (!empty($_GET)) {
            // Redirecionar para /admin/home sem parâmetros
            header('Location: /admin/home');
            exit;
        }

        $usuarioRepository = new UsuarioRepository();

        $data = [];
        if (session_id()) {
            $data = JwtHandler::validateToken($_SESSION['jwt']);
        }


        $usuarioResultado = $usuarioRepository->findForSign($data['email']);

        $resultado = $usuarioRepository->getWhere('criado_por', '=', $usuarioResultado[0]['id']);


        $data = [
            'title' => 'Administração',
            'totalUsers' => (count($resultado) > 0 ? count($resultado) : 0),
            'totalDepoimentos' => 3,
            'totalPosts' => 4,
            'totalEventos' => 10,
            'totalProjetos' => 14,
            'totalServicos' => 8,
        ];

        $styles = [
            '/assets/css/admin-layout.min.css'
        ];
        $scripts = [
            '/assets/js/main-admin.min.js',
            'assets/js/admin/admin-layout.min.js'
        ];

        return new View('admin/dashboard', $data, $styles, $scripts, 'admin-layout');
    }

    public function showById($id)
    {
        throw new \Exception("Metódo não implementado", 1);
    }

    public function update()
    {
        throw new \Exception("Metódo não implementado", 1);
    }

    public function destroy()
    {
        throw new \Exception("Metódo não implementado", 1);
    }
}
