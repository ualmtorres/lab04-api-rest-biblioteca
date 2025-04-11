<?php

require dirname(__DIR__) . '/vendor/autoload.php';
require dirname(__DIR__) . '/db.php';

use Slim\Factory\AppFactory;

// Create a new Slim app instance
$app = AppFactory::create();

// Setup Slim to handle JSON requests
$app->addBodyParsingMiddleware();

// Load routes from different files
/**********
 *** YOUR CODE HERE
 **********/

require dirname(__DIR__) . '/src/routes/generalRoutes.php';

// Run the app
$app->run();
