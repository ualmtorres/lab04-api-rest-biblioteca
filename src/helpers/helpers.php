<?php

use Psr\Http\Message\ResponseInterface;

function createJsonResponse(ResponseInterface $response, array $data): ResponseInterface
{
    $response = $response->withHeader('Content-Type', 'application/json; charset=utf-8');
    $response->getBody()->write(json_encode($data));
    return $response;
}
