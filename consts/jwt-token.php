<?php 


require '../vendor/autoload.php';

use App\Utils\DotEnvUtil;
require_once  '../app/Utils/DotEnvUtil.php';

DotEnvUtil::loadEnv('../.env');

define('JWT_TOKEN', $_ENV['JWT_TOKEN']);