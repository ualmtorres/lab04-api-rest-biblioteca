# API REST Biblioteca - Proyecto Base

Este proyecto proporciona una estructura base para desarrollar una API REST utilizando Slim Framework para gestionar una biblioteca.

## Características

- Implementación base con Slim Framework 4
- Arquitectura en capas:
  - Rutas (Routes): Definen los endpoints de la API
  - Controladores (Controllers): Manejan la lógica de negocio
  - Modelos (Models): Gestionan el acceso a datos
- Configuración de base de datos MySQL incluida
- Script de inicialización de base de datos con datos de ejemplo
- Endpoints base implementados (test y documentación)
- Soporte para Docker

## Estructura del Proyecto

```
.
├── src/
│   ├── controllers/    # Controladores para la lógica de negocio
│   ├── models/        # Modelos para acceso a datos
│   ├── routes/        # Definición de endpoints de la API
│   ├── helpers/       # Funciones auxiliares
│   └── docs/          # Documentación de la API
├── public/            # Punto de entrada de la aplicación
├── docker/           # Configuración de Docker
├── composer.json      # Dependencias del proyecto
├── config.php        # Configuración de la aplicación
├── db.php          # Conexión a la base de datos
├── docker-compose.yml # Configuración de Docker Compose
└── setup-biblioteca-db.sql # Script para crear la base de datos y tablas

```

## Requisitos

- PHP 8.1 o superior
- Composer
- MySQL
- O alternativamente: Docker y Docker Compose

## Instalación

### Opción 1: Usando XAMPP

1. Instalar XAMPP con PHP 8.1 o superior
2. Clonar el repositorio en la carpeta `htdocs` de XAMPP
3. Instalar dependencias:
   ```bash
   composer install
   ```
4. Iniciar los servicios Apache y MySQL desde el panel de control de XAMPP
5. Importar la base de datos:
   1. Desde MySQL Workbench:
       - Conectar a la base de datos
       - Ejecutar el script `setup-biblioteca-db.sql` para crear la base de datos y tablas necesarias
   2. Desde phpMyAdmin:
       - Abrir http://localhost/phpmyadmin
       - Crear base de datos "PrestamosBiblioteca"
       - Importar el archivo setup-biblioteca-db.sql
6. Configurar `config.php`:
   ```php
   $config = [
       'host' => 'localhost',
       'username' => 'root',
       'password' => '',
       'database' => 'PrestamosBiblioteca'
   ];
   ```
7. La API estará disponible en http://localhost/lab04-api-rest-biblioteca

### Opción 2: Usando Docker

1. Clonar el repositorio
2. Ejecutar:
   ```bash
   docker-compose up -d
   ```
3. Acceder a la aplicación en `http://localhost`

### Opción 3: Instalación Local

1. Clonar el repositorio
2. Instalar dependencias:
   ```bash
   composer install
   ```
3. Configurar la base de datos en `config.php`
4. Importar la base de datos:
   ```bash
   mysql -u usuario -p < setup-biblioteca-db.sql
   ```
5. Iniciar el servidor:
   ```bash
   composer run server
   ```
6. Acceder a la aplicación en `http://localhost:8000`

## Endpoints Disponibles

- `GET /test`: Ruta de prueba
- `GET /docs`: Documentación de la API

## Pendiente de Implementación

El código contiene bloques marcados con `YOUR CODE HERE` que deben completarse:

- Implementación de modelos (Book, Loan)
- Controladores (BookController, LoanController)
- Rutas para libros y préstamos
- Conexión a base de datos en `db.php`

## Estructura Base de Datos

La base de datos incluye tablas para:
- Libros
- Ejemplares
- Usuarios
- Préstamos
- Categorías
- Estados
- Historial de préstamos
- Reseñas
- Reservas
- Sanciones

## Configuración

1. Copiar `config.php` y ajustar los parámetros de conexión:
```php
$config = [
    'host' => 'tu_host',
    'username' => 'tu_usuario',
    'password' => 'tu_contraseña',
    'database' => 'PrestamosBiblioteca'
];
```

## Docker

El proyecto incluye:
- `docker-compose.yml` con servicios para PHP, MySQL y Nginx
- Dockerfile para PHP 8.1
- Configuración de Nginx

Para usar Docker:
1. Asegurarse de tener Docker y Docker Compose instalados
2. Ejecutar `docker-compose up -d`
3. La aplicación estará disponible en `http://localhost`
