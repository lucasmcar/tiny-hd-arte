<?php

namespace App\Controller;

use App\Core\View\View;
use Dompdf\Dompdf;

class LogController
{
    public function index()
    {
        $filter = $_GET['filter'] ?? '';
        $logs = $this->fetchLogs($filter);

        $data = [
            'title' => 'Logs de Alterações',
            'logs' => $logs,
            'filter' => $filter
        ];

        $styles = [
            '/assets/css/admin/logs.css'
        ];

        $scripts = [
            '/assets/js/logs.js'
        ];



        return new View(view: 'admin/logs', vars: $data, styles: $styles, scripts: $scripts, layout: 'admin-layout');
    }

    private function fetchLogs($filter = '')
    {
        // Dados fictícios de logs
        $logs = [
            [
                'id' => 1,
                'testimony_id' => 1,
                'user_id' => 1,
                'action' => 'accepted',
                'details' => json_encode(['nome' => 'João Silva', 'titulo' => 'Ótimo evento', 'data' => '2025-03-20'] , JSON_UNESCAPED_UNICODE),
                'created_at' => '2025-03-26 10:30:00'
            ],
            [
                'id' => 2,
                'testimony_id' => 2,
                'user_id' => 1,
                'action' => 'rejected',
                'details' => json_encode(['nome' => 'Maria Oliveira', 'titulo' => 'Não gostei', 'motivo' => 'Conteúdo inadequado'], JSON_UNESCAPED_UNICODE),
                'created_at' => '2025-03-26 11:15:00'
            ],
            [
                'id' => 3,
                'testimony_id' => 3,
                'user_id' => 2,
                'action' => 'accepted',
                'details' => json_encode(['nome' => 'Pedro Souza', 'titulo' => 'Experiência incrível', 'data' => '2025-03-25'], JSON_UNESCAPED_UNICODE),
                'created_at' => '2025-03-26 14:00:00'
            ],
            [
                'id' => 4,
                'testimony_id' => 4,
                'user_id' => 2,
                'action' => 'rejected',
                'details' => json_encode(['nome' => 'Ana Costa', 'titulo' => 'Regular', 'motivo' => 'Falta de clareza'], JSON_UNESCAPED_UNICODE),
                'created_at' => '2025-03-26 15:45:00'
            ]
        ];

        // Aplicar filtro fictício
        if ($filter) {
            $logs = array_filter($logs, function ($log) use ($filter) {
                return stripos($log['action'], $filter) !== false || stripos($log['details'], $filter) !== false;
            });
        }

        return array_values($logs); // Reindexar array após filtro
    }

    public function exportPdf()
    {
        $logs = json_decode($_POST['logs'] ?? '[]', true); // Recebe os logs filtrados do frontend

        $dompdf = new Dompdf();
        $html = '<h1>Logs de Alterações</h1>';
        $html .= '<table border="1" width="100%">';
        $html .= '<thead><tr><th>Data</th><th>Ação</th><th>ID do Depoimento</th><th>Detalhes</th></tr></thead>';
        $html .= '<tbody>';
        foreach ($logs as $log) {
            $html .= sprintf(
                '<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>',
                date('d/m/Y H:i', strtotime($log['created_at'])),
                htmlspecialchars($log['action']),
                $log['testimony_id'] ?? 'N/A',
                htmlspecialchars($log['details'] ?? '-')
            );
        }
        $html .= '</tbody></table>';

        $dompdf->loadHtml($html);
        $dompdf->setPaper('A4', 'portrait');
        $dompdf->render();
        $dompdf->stream('logs_' . date('YmdHis') . '.pdf', ['Attachment' => true]);
        exit;
    }
}
