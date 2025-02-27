<?php 

namespace App\Controller;

use App\Core\View\View;

class HomeAdminController
{
    public function home()
    {
        $data = [
            'title' => 'Administração',
        ];

        return new View('admin/home', $data, 'admin-layout');
    }

    public function todosServicos()
    {
        $data = [
            'title' => 'Todos os Serviços',
            'servicos' => [
                ["icone" => "bi-file-earmark-text", "titulo" => "Análise de Propostas para Editais", "descricao" => "Revisão e análise detalhada de propostas para editais públicos e privados."],
                ["icone" => "bi-lightbulb", "titulo" => "Elaboração de Projetos", "descricao" => "Criação de projetos estratégicos e personalizados para seu negócio."],
                ["icone" => "bi-calendar-check", "titulo" => "Planejamento e Gerenciamento", "descricao" => "Organização e supervisão de projetos para garantir sua execução eficiente."],
                ["icone" => "bi-cash-coin", "titulo" => "Prestação de Contas", "descricao" => "Gestão financeira e transparência na prestação de contas."],
                ["icone" => "bi-mic", "titulo" => "Direção Artística e Produção Executiva", "descricao" => "Supervisão artística e logística para produções culturais e eventos."],
                ["icone" => "bi-megaphone", "titulo" => "Consultoria de Mídias e Redes Sociais", "descricao" => "Estratégias para crescimento orgânico e campanhas pagas eficientes."],
                ["icone" => "bi-newspaper", "titulo" => "Assessoria de Imprensa", "descricao" => "Divulgação estratégica para fortalecimento da marca na mídia."],
                ["icone" => "bi-instagram", "titulo" => "Gestão de Mídias (Instagram, etc.)", "descricao" => "Gerenciamento profissional de redes sociais para engajamento e conversão."]
            ]
            ];

        // Verifica se é uma requisição AJAX
        if ($_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest') {
            header('Content-Type: application/json');
            return new View('admin/servicos', $data, 'admin-layout');
            
        }

    }

    public function createServico()
    {
        $data = [
            'title' => 'Criar Serviço',
        ];

        
    }
}