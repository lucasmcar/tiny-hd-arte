<?php

require '../vendor/autoload.php';

date_default_timezone_set('America/Sao_Paulo');

use App\Router\Route\Route;
use App\Router\Router;
use App\Utils\DotEnvUtil;

$path = dirname(__FILE__, 2);

DotEnvUtil::loadEnv($path."/.env");

header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Credentials: true");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

$routeFactory = new Route();
$router = new Router($routeFactory);

include '../routes/web.php';
include '../routes/api.php';

$router->run();

