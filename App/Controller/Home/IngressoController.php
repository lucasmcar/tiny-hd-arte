<?php

namespace App\Controller\Home;

use App\Core\View\View;
use App\Repository\ProjetosRepository;
use PDOException;
use Dompdf\Dompdf;
use Efi\EfiPay;
use Endroid\QrCode\QrCode;
use Endroid\QrCode\Writer\PngWriter;
use Endroid\QrCode\Encoding\Encoding;
use Endroid\QrCode\ErrorCorrectionLevel;
use Endroid\QrCode\RoundBlockSizeMode;
use Endroid\QrCode\Color\Color;
use PHPMailer\PHPMailer\PHPMailer;
use App\Helper\JsonHelper;
use Exception;

ini_set('display_errors', 0);
ini_set('log_errors', 1);
ini_set('error_log', __DIR__ . '/error.log');

class IngressoController
{

    private $pdo;
    private $efiClientId;
    private $efiClientSecret;
    private $efiPixCert;
    private $efiPixKey;

    private $user;
    private $db;
    private $host;
    private $password;


    public function __construct()
    {
        $this->user = $_ENV['USER'] ?? 'root';
        $this->password = $_ENV['PASS'] ?? '';
        $this->host = $_ENV['HOST'] ?? 'localhost';
        $this->db = $_ENV['DATABASE'] ?? 'default_db';
        $this->efiClientId = $_ENV['HOM_CHAVE_CLIENTE_EFI']; //$_ENV['PROD_CHAVE_CLIENTE_EFI'];
        $this->efiClientSecret = $_ENV['HOM_CHAVE_SECRETA_EFI']; //$_ENV['PROD_CHAVE_SECRETA_EFI'];

        // Certificados do .env

        $this->efiPixCert = $_ENV['HOM_CERT_PATH'];  //$_ENV['PROD_CERT_PATH']
        $this->efiPixKey  = $_ENV['PIX_KEY'];

        $this->pdo = new \PDO("mysql:host=$this->host;dbname=$this->db;charset=utf8mb4", $this->user, $this->password);
    }

    public function index()
    {
        $projetoRepo = new ProjetosRepository();

        $data = [
            'title' => 'Veja nossos eventos',
            'eventos' => $projetoRepo->fetchAllProjects(),
        ];

        $styles = [
            '/assets/css/default.css',
            '/assets/css/eventos.css'
        ];

        $scripts = [];
        return new View('site/eventos', $data, $styles, $scripts);
    }

    public function telaCompraIngresso($params)
    {
        $slug = $params[0] ?? '';
        $projetoRepo = new ProjetosRepository();
        $evento = $projetoRepo->fetchProjectBySlug($slug);

        // 🔹 Busca lote válido
        $stmt = $this->pdo->prepare("
        SELECT * FROM lotes
        WHERE id_evento = :eventoId
        AND qtd_vendida < qtd_total
        AND NOW() BETWEEN inicio AND fim
        ORDER BY preco ASC
        LIMIT 1
    ");
        $stmt->execute([":eventoId" => $evento['id']]);
        $lote = $stmt->fetch(\PDO::FETCH_ASSOC);

        // 🔹 Caso não tenha lote, aplica preço na hora (30,00)
        $hoje = date('Y-m-d');
        $dataEvento = date('Y-m-d', strtotime($evento['periodo_execucao']));

        if (!$lote || $hoje == $dataEvento) {
            $lote = [
                "id_lote" => null,
                "preco" => 30.00,
                "qtd_total" => 9999,
                "qtd_vendida" => 0
            ];
        }

        $data = [
            'title' => 'Detalhes do evento',
            'evento' => $evento,
            'lote'   => $lote
        ];

        $styles = [
            '/assets/css/evento-ingresso.css'
        ];

        $scripts = [
            '/assets/js/evento-ingresso.js',
            '/assets/js/venda-ingresso.js'
        ];

        return new View('site/evento-ingresso', $data, $styles, $scripts);
    }




    /*public function comprarIngresso($eventoId, $clienteNome, $clienteEmail, $quantidade)
    {
        try {
            $this->pdo->beginTransaction();

            // 🔹 Busca o lote disponível
            $stmt = $this->pdo->prepare("
                SELECT * FROM lotes 
                WHERE evento_id = :eventoId 
                  AND ingressos_vendidos < quantidade_total 
                  AND NOW() BETWEEN inicio_vendas AND fim_vendas
                ORDER BY preco ASC 
                LIMIT 1
            ");
            $stmt->execute([":eventoId" => $eventoId]);
            $lote = $stmt->fetch(\PDO::FETCH_ASSOC);

            if (!$lote) {
                throw new \PDOException("Não há lotes disponíveis para este evento.");
            }

            $precoUnitario = $lote['preco'];
            $valorSemTaxa = $precoUnitario * $quantidade;

            // aplica taxa de 1,19% (Efi)
            $taxaEfi = 0.0119;
            $valorFinal = round($valorSemTaxa / (1 - $taxaEfi), 2);

            // 🔹 Atualiza ingressos vendidos no lote
            $stmt = $this->pdo->prepare("
                UPDATE lotes 
                SET ingressos_vendidos = ingressos_vendidos + :qtd 
                WHERE id = :loteId
            ");
            $stmt->execute([":qtd" => $quantidade, ":loteId" => $lote['id']]);

            // 🔹 Cria cobrança PIX (Efi/Gerencianet)
            $pixData = $this->gerarPix($valorFinal, $clienteNome, $clienteEmail, $clienteCpf);

            // 🔹 Salva compra no banco
            $stmt = $this->pdo->prepare("
                INSERT INTO ingressos (evento_id, cliente_nome, cliente_email, quantidade, valor_total, status_pagamento, txid, qr_code)
                VALUES (:eventoId, :nome, :email, :quantidade, :valor, 'pending', :txid, :qrCode)
            ");
            $stmt->execute([
                ":eventoId"   => $eventoId,
                ":nome"       => $clienteNome,
                ":email"      => $clienteEmail,
                ":quantidade" => $quantidade,
                ":valor"      => $valorFinal,
                ":txid"       => $pixData['txid'],
                ":qrCode"     => $pixData['qrcode']
            ]);

            $this->pdo->commit();

            // 🔹 Gera PDF com ingresso e QRCode PIX
            //$this->gerarPdfIngresso($clienteNome, $eventoId, $quantidade, $valorFinal, $pixData['qrcode'], $pixData['copiaECola']);

        } catch (\PDOException $e) {
            $this->pdo->rollBack();
            echo "Erro: " . $e->getMessage();
        }
    }*/

    private function gerarPix($valor, $nome, $email, $cpf)
    {

        $certPath = realpath(__DIR__ . '/../../../storage/cert/efi/certificado.pem');
        // troca \ por /
        $certPath = str_replace('\\', '/', $certPath);

        $keyPath = realpath(__DIR__ . '/../../../storage/cert/efi/chave.key');
        $keyPath = str_replace('\\', '/', $keyPath);
        $options = [
            'client_id' => $this->efiClientId,
            'client_secret' => $this->efiClientSecret,
             //$this->efiPixCert
            'certificate' => realpath(__DIR__ . '/../../../storage/cert/efi/full_cert.pem'),
            'sandbox' => true
        ];

        $api = EfiPay::getInstance($options);

        $body = [
            'calendario' => ['expiracao' => 3600],
            'devedor' => [
                'nome' => $nome,
                'cpf' => $cpf
            ],
            'valor' => [
                'original' => number_format($valor, 2, '.', '')
            ],
            'chave' => $this->efiPixKey,
            'solicitacaoPagador' => 'Pagamento ingresso'
        ];

        $pix = $api->pixCreateImmediateCharge([], $body);
        $qrcode = $api->pixGenerateQRCode(['id' => $pix['loc']['id']]);

        return [
            'txid'      => $pix['txid'],
            'qrcode'    => $qrcode['imagemQrcode'],
            'copiaECola' => $qrcode['qrcode']
        ];
    }

    private function geraPdfIngresso($evento, $ingresso)
    {
        // 🔹 Gera QRCode com o código do ingresso
        $qrCode = new QrCode(
            data: $ingresso['codigo_ingresso']."-".$ingresso['status_pagamento'],
            encoding: new Encoding('UTF-8'),
            errorCorrectionLevel: ErrorCorrectionLevel::Low,
            size: 200,
            margin: 10,
            roundBlockSizeMode: RoundBlockSizeMode::Margin,
            foregroundColor: new Color(0, 0, 0),
            backgroundColor: new Color(255, 255, 255)


        );

        $writer = new PngWriter();
        $qrImage = $writer->write($qrCode);
        $qrDataUri = $qrImage->getDataUri();

        // 🔹 Layout HTML do ingresso
        $html = "
    <html>
    <head>
        <style>
            body { font-family: DejaVu Sans, sans-serif; }
            .ticket {
                border: 2px solid #000;
                border-radius: 10px;
                padding: 20px;
                width: 500px;
                margin: auto;
                text-align: center;
            }
            h2 { margin-bottom: 5px; }
            .evento { font-size: 18px; font-weight: bold; margin-bottom: 10px; }
            .dados { margin: 15px 0; font-size: 14px; }
            .qr { margin-top: 20px; }
        </style>
    </head>
    <body>
        <div class='ticket'>
            <h2>🎟 Ingresso Oficial</h2>
            <div class='evento'>{$evento['nome']}</div>
            <div class='dados'>
                <h1>{$evento['nome']}</h1>
                <p><strong>Data:</strong> " . date('d/m/Y', strtotime($evento['data_evento'])) . "</p>
                <p><strong>Local:</strong> {$evento['local']}</p>
                <p><strong>Cliente:</strong> {$ingresso['cliente_nome']}</p>
                <p><strong>Código:</strong> {$ingresso['codigo_ingresso']}</p>
                <p><strong>Status:</strong> {$ingresso['status_pagamento']}</p>
                <img src='/imgs/assets/logo.png'>
            </div>
            <div class='qr'>
                <img src='{$qrDataUri}' alt='QR Code'/>
            </div>
        </div>
    </body>
    </html>
    ";

        // 🔹 Gera o PDF
        $dompdf = new Dompdf();
        $dompdf->loadHtml($html);
        $dompdf->setPaper('A4', 'portrait');
        $dompdf->render();

        // 🔹 Salva PDF em pasta /uploads/ingressos/
        $output = $dompdf->output();
        $filePath = realpath(__DIR__ . "/../../../public/uploads/ingressos/");
        $fileName = "ingresso_{$ingresso['codigo_ingresso']}.pdf";

        $pdfFile = $filePath . DIRECTORY_SEPARATOR . $fileName;

        file_put_contents($pdfFile, $output);

        return $filePath;
    }

    public function criarPagamento()
    {
        header('Content-Type: application/json; charset=utf-8');
        $input = json_decode(file_get_contents('php://input'), true);

        $eventoId   = $input['event_id'] ?? null;
        $quantidade = (int)($input['quantity'] ?? 1);
        $clienteNome  = $input['cliente_nome'];  // depois pega de sessão / formulário
        $clienteEmail = $input['cliente_email'];
        $clienteCpf = $input['cliente_cpf'];

        if (!$eventoId || $quantidade < 1) {
            http_response_code(400);
            echo json_encode(['error' => 'Dados inválidos']);
            return;
        }

        /*$eventoStmt = $this->pdo->prepare("SELECT * FROM EVENTOS WHERE id_evento = :id_evento ");
        $eventoStmt->execute([':id_evento' => $eventoId]);
        $evento = $eventoStmt->fetch(\PDO::FETCH_ASSOC);*/

        try {
            $this->pdo->beginTransaction();

            $stmt = $this->pdo->prepare("
                SELECT l.*, e.nome as evento_nome, e.data_evento, e.local 
                FROM lotes l
                INNER JOIN eventos e ON l.id_evento = e.id_evento
                WHERE l.id_evento = :eventoId 
                AND l.qtd_vendida < l.qtd_total 
                AND NOW() BETWEEN l.inicio AND l.fim
                ORDER BY l.inicio ASC, l.preco ASC
                LIMIT 1
            ");
            $stmt->execute([":eventoId" => $eventoId]);
            $lote = $stmt->fetch(\PDO::FETCH_ASSOC);

            $hoje = date('Y-m-d');
            $dataEvento = date('Y-m-d', strtotime($lote['data_evento'] ?? '1970-01-01'));

            if (!$lote) {
                if ($hoje == $dataEvento) {
                    // 🔹 Regra: ingresso "na hora"
                    $lote = [
                        "id_lote"     => null,
                        "preco"       => $lote['preco'],
                        "qtd_total"   => $lote['qtd_total'],
                        "qtd_vendida" => 0,
                        "evento_nome" => $lote['evento_nome'] ?? "Evento",
                        "data_evento" => $dataEvento,
                        "local"       => $lote['local'] ?? "Local não definido"
                    ];
                } else {
                    throw new \Exception("Não há mais lotes disponíveis para este evento.");
                }
            }
            $precoUnitario = (float) $lote['preco'];
            $valorSemTaxa  = $precoUnitario * $quantidade;

            // aplica taxa de 1,19% (Efi)
            $taxaEfi   = 0.0119;
            $valorFinal = round($valorSemTaxa / (1 - $taxaEfi), 2);

            // 🔹 Atualiza ingressos vendidos
            $stmt = $this->pdo->prepare("
                UPDATE lotes 
                SET qtd_vendida = qtd_vendida + :qtd 
                WHERE id_lote = :loteId
            ");
            $stmt->execute([":qtd" => $quantidade, ":loteId" => $lote['id_lote']]);

            // 🔹 Gera PIX
            $pixData = $this->gerarPix($valorFinal, $clienteNome, $clienteEmail, $clienteCpf);

            $tmpFile = tempnam(sys_get_temp_dir(), 'qrcode') . ".png";
            file_put_contents($tmpFile, file_get_contents($pixData['qrcode']));


            $mail = new PHPMailer(true);

            try {
                $cid = md5(uniqid());
                $mail->addEmbeddedImage($tmpFile, $cid, 'qrcode.png');
                $mail->isSMTP();
                $mail->CharSet = "UTF-8";
                $mail->Host = $_ENV['E_HOST']; // ex: smtp.gmail.com
                $mail->SMTPAuth = true;
                $mail->Username = $_ENV['E_USER'];
                $mail->Password = $_ENV['E_PASS'];
                $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
                $mail->Mailer = 'smtp';


                $mail->Port = $_ENV['E_PORT'];

                $mail->setFrom($mail->Username, 'Ingressos HD\'Arte');
                $mail->addAddress($clienteEmail, $clienteNome);

                $mail->isHTML(true);
                $mail->Subject = "Pagamento PIX - {$input['event_title']}";
                $mail->Body = "
        <h2>Olá {$clienteNome},</h2>
        <p>Seu ingresso está quase garantido!</p>
        <p>Faça o pagamento via PIX para confirmar:</p>
        <p><b>Copia e Cola:</b></p>
        <p>{$pixData['copiaECola']}</p>
        <p><img src='cid:{$cid}' alt='QRCode PIX'/></p>
    ";

                $mail->send();
            } catch (\Exception $e) {
                error_log("Erro ao enviar email PIX: " . $mail->ErrorInfo);
            }



            // 🔹 Insere um registro para cada ingresso
            $stmt = $this->pdo->prepare("
                INSERT INTO ingressos (id_evento, cliente_nome, cliente_email, codigo_ingresso, valor_unitario, status_pagamento, txid, qr_code)
                VALUES (:eventoId, :nome, :email, :codigo, :valorUnit, 'pending', :txid, :qrCode)
            ");

            for ($i = 0; $i < $quantidade; $i++) {
                $codigoIngresso = bin2hex(random_bytes(8)); // código único para validação/QR
                $stmt->execute([
                    ":eventoId"   => $eventoId,
                    ":nome"       => $clienteNome,
                    ":email"      => $clienteEmail,
                    ":codigo"     => $codigoIngresso,
                    ":valorUnit"  => $precoUnitario,
                    ":txid"       => $pixData['txid'],
                    ":qrCode"     => $pixData['qrcode']
                ]);


                $pdfPath = $this->geraPdfIngresso(
                    [
                        "nome" => $lote['nome'] ?? "Evento",
                        "data_evento" => $lote['data_evento'] ?? date('Y-m-d'),
                        "local" => $lote['local'] ?? "Local não definido"
                    ],
                    [
                        "cliente_nome" => $clienteNome,
                        "codigo_ingresso" => $codigoIngresso,
                        "status_pagamento" => "pendente"
                    ]
                );
            }

            $this->pdo->commit();

            // 🔹 Retorna PIX + quantidade em JSON para o frontend
            echo json_encode([
                "status"      => "success",
                "quantidade"  => $quantidade,
                "valor_total" => $valorFinal,
                "pix"         => $pixData,
                "pdf" => realpath(__DIR__ . $pdfPath . "/ingresso_{$codigoIngresso}.pdf")
            ]);
        } catch (\Exception $e) {
            $this->pdo->rollBack();
            http_response_code(500);
            header('Content-Type: application/json');
            echo json_encode([
                'error' => true,
                'message' => $e->getMessage()
            ]);
            return;
        }
    }


    public function notificacaoPix()
    {
        $input = json_decode(file_get_contents('php://input'), true);
        $txid = $input['pix'][0]['txid'] ?? null;

        if ($txid) {
            // Atualiza no banco como "paid"
            $stmt = $this->pdo->prepare("UPDATE ingressos SET status_pagamento = 'paid' WHERE txid = :txid");
            $stmt->execute([":txid" => $txid]);

            // Busca dados do ingresso + evento
            $stmt = $this->pdo->prepare("SELECT * FROM ingressos WHERE txid = :txid LIMIT 1");
            $stmt->execute([":txid" => $txid]);
            $ingresso = $stmt->fetch(\PDO::FETCH_ASSOC);

            // 🔹 Gera PDF
            $pdfPath = $this->geraPdfIngresso($ingresso['evento_nome'], $ingresso);

            // 🔹 Envia por e-mail com PHPMailer
            $mail = new PHPMailer(true);
            try {

                $mail->isSMTP();
                $mail->Host = $_ENV['E_HOST']; // ex: smtp.gmail.com
                $mail->SMTPAuth = true;
                $mail->CharSet = "UTF-8";
                $mail->Username = $_ENV['E_USER'];
                $mail->Password = $_ENV['E_PASS'];
                $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
                $mail->Mailer = 'smtp';


                $mail->Port = $_ENV['E_PORT'];

                $mail->setFrom($mail->Username, 'Ingressos HD\'Arte');
                $mail->addAddress($ingresso['cliente_email'], $ingresso['cliente_nome']);
                $mail->isHTML(true);
                $mail->Subject = "🎟 Ingresso confirmado - {$ingresso['evento_nome']}";
                $mail->Body = "Parabéns {$ingresso['cliente_nome']}! Seu ingresso está confirmado.<br>Segue em anexo.";
                $mail->addAttachment($pdfPath);

                $mail->send();
            } catch (Exception $e) {
                echo $e->getMessage();
            }
        }
    }
}
