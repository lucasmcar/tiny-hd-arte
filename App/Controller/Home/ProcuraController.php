<?php

namespace App\Controller\Home;

use App\Repository\ProjetosRepository;

class ProcuraController
{
    public function procurar($params = [])
    {
        

        // Obtém o termo bruto
        $rawQ = $params['q'] ?? $_GET['q'] ?? '';
        
        // Sanitiza o termo (remove tags HTML e caracteres especiais perigosos)
        $q = filter_var($rawQ, FILTER_DEFAULT, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);
        
        // Valida o termo (permite letras, números, espaços e hífens)
        if (!preg_match('/^[\p{L}\p{N}\s-]*$/u', $q) || strlen($q) > 100) {
            $q = ''; // Rejeita termos inválidos ou muito longos
        }

        // Simulação de busca (substitua por sua lógica real, ex.: consulta ao banco)
        $results = [];

        $projetosRepository = new ProjetosRepository();
        $projetosEncontrados = $projetosRepository->getProjetosPorNome($q);
        
        foreach($projetosEncontrados as $projeto) {
            $results[] = [
                'title' => $projeto['title'],
                'url' => '/projetos/' . $projeto['slug']
            ];
        }

        // Retorna os resultados em JSON
        header('Content-Type: application/json');
        echo json_encode($results);
        exit;
    }
}