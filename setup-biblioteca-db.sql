SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET NAMES utf8mb4;

DROP SCHEMA IF EXISTS `PrestamosBiblioteca` ;
CREATE SCHEMA IF NOT EXISTS `PrestamosBiblioteca` CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
USE `PrestamosBiblioteca` ;

-- -----------------------------------------------------
-- Table `PrestamosBiblioteca`.`Categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PrestamosBiblioteca`.`Categoria` ;

CREATE  TABLE IF NOT EXISTS `PrestamosBiblioteca`.`Categoria` (
  `categoria` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`categoria`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrestamosBiblioteca`.`Estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PrestamosBiblioteca`.`Estado` ;

CREATE  TABLE IF NOT EXISTS `PrestamosBiblioteca`.`Estado` (
  `estado` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`estado`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrestamosBiblioteca`.`Libro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PrestamosBiblioteca`.`Libro` ;

CREATE  TABLE IF NOT EXISTS `PrestamosBiblioteca`.`Libro` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `titulo` VARCHAR(255) NULL DEFAULT NULL ,
  `autor` VARCHAR(255) NULL DEFAULT NULL ,
  `editorial` VARCHAR(255) NULL DEFAULT NULL ,
  `publicadoEn` SMALLINT(5) NULL DEFAULT NULL ,
  `categoria` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `CategoriaLibro` (`categoria` ASC) ,
  INDEX `id` (`id` ASC) ,
  CONSTRAINT `fk_Libro_Categoria`
    FOREIGN KEY (`categoria` )
    REFERENCES `PrestamosBiblioteca`.`Categoria` (`categoria` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrestamosBiblioteca`.`Ejemplar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PrestamosBiblioteca`.`Ejemplar` ;

CREATE  TABLE IF NOT EXISTS `PrestamosBiblioteca`.`Ejemplar` (
  `numeroInventario` VARCHAR(255) NOT NULL ,
  `estado` VARCHAR(255) NULL DEFAULT NULL ,
  `idLibro` INT(10) NULL DEFAULT NULL ,
  PRIMARY KEY (`numeroInventario`) ,
  INDEX `EstadoEjemplar` (`estado` ASC) ,
  INDEX `id` (`numeroInventario` ASC) ,
  INDEX `idLibro` (`idLibro` ASC) ,
  INDEX `LibroEjemplar` (`idLibro` ASC) ,
  CONSTRAINT `fk_Ejemplar_Estado1`
    FOREIGN KEY (`estado` )
    REFERENCES `PrestamosBiblioteca`.`Estado` (`estado` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ejemplar_Libro1`
    FOREIGN KEY (`idLibro` )
    REFERENCES `PrestamosBiblioteca`.`Libro` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrestamosBiblioteca`.`TipoUsuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PrestamosBiblioteca`.`TipoUsuario` ;

CREATE  TABLE IF NOT EXISTS `PrestamosBiblioteca`.`TipoUsuario` (
  `tipoUsuario` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`tipoUsuario`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrestamosBiblioteca`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PrestamosBiblioteca`.`Usuario` ;

CREATE  TABLE IF NOT EXISTS `PrestamosBiblioteca`.`Usuario` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(255) NULL DEFAULT NULL ,
  `apellidos` VARCHAR(255) NULL DEFAULT NULL ,
  `email` VARCHAR(255) NULL DEFAULT NULL ,
  `telefono` VARCHAR(255) NULL DEFAULT NULL ,
  `sancionadoHasta` DATETIME NULL ,
  `tipoUsuario` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `id` (`id` ASC) ,
  INDEX `TipoUsuarioUsuario` (`tipoUsuario` ASC) ,
  CONSTRAINT `fk_Usuario_TipoUsuario1`
    FOREIGN KEY (`tipoUsuario` )
    REFERENCES `PrestamosBiblioteca`.`TipoUsuario` (`tipoUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrestamosBiblioteca`.`HistorialPrestamos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PrestamosBiblioteca`.`HistorialPrestamos` ;

CREATE  TABLE IF NOT EXISTS `PrestamosBiblioteca`.`HistorialPrestamos` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `numeroInventario` VARCHAR(255) NULL DEFAULT NULL ,
  `idUsuario` INT(10) NULL DEFAULT NULL ,
  `fechaPrestamo` DATETIME NULL DEFAULT NULL ,
  `fechaDevolucion` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `EjemplarHistorialPrestamos` (`numeroInventario` ASC) ,
  INDEX `id` (`id` ASC) ,
  INDEX `idEjemplar` (`numeroInventario` ASC) ,
  INDEX `idUsuario` (`idUsuario` ASC) ,
  INDEX `UsuarioHistorialPrestamos` (`idUsuario` ASC) ,
  CONSTRAINT `fk_HistorialPrestamos_Ejemplar1`
    FOREIGN KEY (`numeroInventario` )
    REFERENCES `PrestamosBiblioteca`.`Ejemplar` (`numeroInventario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HistorialPrestamos_Usuario1`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `PrestamosBiblioteca`.`Usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrestamosBiblioteca`.`Prestamo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PrestamosBiblioteca`.`Prestamo` ;

CREATE  TABLE IF NOT EXISTS `PrestamosBiblioteca`.`Prestamo` (
  `id` INT(10) NOT NULL AUTO_INCREMENT ,
  `numeroInventario` VARCHAR(255) NOT NULL ,
  `idUsuario` INT(10) NULL DEFAULT NULL ,
  `fechaPrestamo` DATETIME NULL DEFAULT NULL ,
  `fechaLimite` DATETIME NULL DEFAULT NULL ,
  `fechaDevolucion` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `EjemplarPrestamo` (`numeroInventario` ASC) ,
  UNIQUE INDEX `id` (`numeroInventario` ASC) ,
  INDEX `id1` (`id` ASC) ,
  INDEX `idUsuario` (`idUsuario` ASC) ,
  INDEX `UsuarioPrestamo` (`idUsuario` ASC) ,
  CONSTRAINT `fk_Prestamo_Ejemplar1`
    FOREIGN KEY (`numeroInventario` )
    REFERENCES `PrestamosBiblioteca`.`Ejemplar` (`numeroInventario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prestamo_Usuario1`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `PrestamosBiblioteca`.`Usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrestamosBiblioteca`.`Reseña`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PrestamosBiblioteca`.`Reseña` ;

CREATE  TABLE IF NOT EXISTS `PrestamosBiblioteca`.`Reseña` (
  `idUsuario` INT(10) NOT NULL ,
  `idLibro` INT(10) NOT NULL ,
  `valoracion` TINYINT NULL ,
  `opinion` VARCHAR(255) NULL ,
  PRIMARY KEY (`idUsuario`, `idLibro`) ,
  INDEX `fk_Usuario_has_Libro_Libro1_idx` (`idLibro` ASC) ,
  INDEX `fk_Usuario_has_Libro_Usuario1_idx` (`idUsuario` ASC) ,
  CONSTRAINT `fk_Usuario_has_Libro_Usuario1`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `PrestamosBiblioteca`.`Usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Libro_Libro1`
    FOREIGN KEY (`idLibro` )
    REFERENCES `PrestamosBiblioteca`.`Libro` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrestamosBiblioteca`.`Reserva`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PrestamosBiblioteca`.`Reserva` ;

CREATE  TABLE IF NOT EXISTS `PrestamosBiblioteca`.`Reserva` (
  `idUsuario` INT(10) NOT NULL ,
  `idLibro` INT(10) NOT NULL ,
  `fechaReserva` DATETIME NULL ,
  PRIMARY KEY (`idUsuario`, `idLibro`) ,
  INDEX `fk_Usuario_has_Libro_Libro2_idx` (`idLibro` ASC) ,
  INDEX `fk_Usuario_has_Libro_Usuario2_idx` (`idUsuario` ASC) ,
  CONSTRAINT `fk_Usuario_has_Libro_Usuario2`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `PrestamosBiblioteca`.`Usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Libro_Libro2`
    FOREIGN KEY (`idLibro` )
    REFERENCES `PrestamosBiblioteca`.`Libro` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrestamosBiblioteca`.`Sancion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PrestamosBiblioteca`.`Sancion` ;

CREATE  TABLE IF NOT EXISTS `PrestamosBiblioteca`.`Sancion` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `fechaInicio` DATETIME NULL ,
  `fechaFin` DATETIME NULL ,
  `numeroInventario` VARCHAR(255) NOT NULL ,
  `idUsuario` INT(10) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Sancion_Ejemplar1_idx` (`numeroInventario` ASC) ,
  INDEX `fk_Sancion_Usuario1_idx` (`idUsuario` ASC) ,
  CONSTRAINT `fk_Sancion_Ejemplar1`
    FOREIGN KEY (`numeroInventario` )
    REFERENCES `PrestamosBiblioteca`.`Ejemplar` (`numeroInventario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sancion_Usuario1`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `PrestamosBiblioteca`.`Usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `PrestamosBiblioteca` ;

-- Datos para la tabla Categoria
INSERT INTO `Categoria` (`categoria`) VALUES
('Ficción'), ('No Ficción'), ('Ciencia'), ('Historia'), ('Biografía'),
('Fantasía'), ('Misterio'), ('Romance'), ('Terror'), ('Aventura'),
('Infantil'), ('Juvenil'), ('Educación'), ('Arte'), ('Cómics'),
('Cocina'), ('Deportes'), ('Tecnología'), ('Salud'), ('Viajes');

-- Datos adicionales para la tabla Categoria
INSERT INTO `Categoria` (`categoria`) VALUES
('Psicología'), ('Negocios'), ('Autoayuda'), ('Religión'), ('Filosofía');

-- Datos para la tabla Estado
INSERT INTO `Estado` (`estado`) VALUES
('Disponible'), ('Prestado'), ('Reservado'), ('Dañado'), ('Extraviado'),
('En reparación'), ('Nuevo'), ('Usado'), ('En espera'), ('Retirado'),
('En tránsito'), ('En revisión'), ('En inventario'), ('En cuarentena'), ('En limpieza'),
('En restauración'), ('En proceso'), ('En evaluación'), ('En archivo'), ('En reserva');

-- Datos adicionales para la tabla Estado
INSERT INTO `Estado` (`estado`) VALUES
('En exhibición'), ('En préstamo interbibliotecario'), ('En digitalización'), ('En almacenamiento'), ('En conservación');

-- Datos para la tabla Libro
INSERT INTO `Libro` (`titulo`, `autor`, `editorial`, `publicadoEn`, `categoria`) VALUES
('El Quijote', 'Miguel de Cervantes', 'Editorial A', 1605, 'Ficción'),
('Cien años de soledad', 'Gabriel García Márquez', 'Editorial B', 1967, 'Ficción'),
('1984', 'George Orwell', 'Editorial C', 1949, 'Ciencia'),
('La Odisea', 'Homero', 'Editorial D', -800, 'Historia'),
('El Principito', 'Antoine de Saint-Exupéry', 'Editorial E', 1943, 'Infantil'),
('La sombra del viento', 'Carlos Ruiz Zafón', 'Editorial F', 2001, 'Misterio'),
('El amor en los tiempos del cólera', 'Gabriel García Márquez', 'Editorial G', 1985, 'Romance'),
('Brave New World', 'Aldous Huxley', 'Editorial H', 1932, 'Ciencia'),
('La Ilíada', 'Homero', 'Editorial I', -750, 'Historia'),
('Harry Potter y la piedra filosofal', 'J.K. Rowling', 'Editorial J', 1997, 'Fantasía');

-- Datos para la tabla Ejemplar
INSERT INTO `Ejemplar` (`numeroInventario`, `estado`, `idLibro`) VALUES
('INV001', 'Disponible', 1),
('INV002', 'Disponible', 2),
('INV003', 'Disponible', 3),
('INV004', 'Dañado', 4),
('INV005', 'Disponible', 5),
('INV006', 'Disponible', 6),
('INV007', 'Disponible', 7),
('INV008', 'Disponible', 8),
('INV009', null, 8),
('INV010', null, 8);

-- Datos para la tabla TipoUsuario
INSERT INTO `TipoUsuario` (`tipoUsuario`) VALUES
('Estudiante'), ('Profesor'), ('Investigador'), ('Administrativo'), ('Visitante'),
('Externo'), ('Alumno'), ('Docente'), ('Bibliotecario'), ('Invitado'),
('Socio'), ('Miembro'), ('Colaborador'), ('Asistente'), ('Voluntario'),
('Supervisor'), ('Director'), ('Coordinador'), ('Consultor'), ('Editor'),
('Investigador Senior'), ('Estudiante de Posgrado'), ('Profesor Visitante'), ('Bibliotecario Jefe'), ('Voluntario Externo');

-- Datos para la tabla Usuario
INSERT INTO `Usuario` (`nombre`, `apellidos`, `email`, `telefono`, `sancionadoHasta`, `tipoUsuario`) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', '123456789', NULL, 'Estudiante'),
('María', 'Gómez', 'maria.gomez@example.com', '987654321', NULL, 'Profesor'),
('Luis', 'Martínez', 'luis.martinez@example.com', '456123789', NULL, 'Investigador'),
('Ana', 'López', 'ana.lopez@example.com', '789456123', NULL, 'Administrativo'),
('Carlos', 'Hernández', 'carlos.hernandez@example.com', '321654987', NULL, 'Visitante'),
('Sofía', 'Ramírez', 'sofia.ramirez@example.com', '654987321', NULL, 'Investigador Senior'),
('Diego', 'Torres', 'diego.torres@example.com', '789123456', NULL, 'Estudiante de Posgrado'),
('Laura', 'Morales', 'laura.morales@example.com', '321789654', NULL, 'Profesor Visitante'),
('Jorge', 'Vargas', 'jorge.vargas@example.com', '987321654', NULL, 'Bibliotecario Jefe'),
('Elena', 'Castro', 'elena.castro@example.com', '123789456', NULL, 'Voluntario Externo');

-- Datos para la tabla HistorialPrestamos
INSERT INTO `HistorialPrestamos` (`numeroInventario`, `idUsuario`, `fechaPrestamo`, `fechaDevolucion`) VALUES
('INV001', 1, '2023-01-01 10:00:00', '2023-01-15 10:00:00'),
('INV002', 2, '2023-01-01 11:00:00', '2023-01-12 11:00:00'),
('INV003', 3, '2023-01-01 12:00:00', '2023-01-09 12:00:00'),
('INV004', 4, '2023-04-01 13:00:00', '2023-04-15 13:00:00'),
('INV005', 5, '2023-05-01 14:00:00', '2023-05-15 14:00:00'),
('INV006', 6, '2023-06-01 10:00:00', '2023-06-15 10:00:00'),
('INV007', 2, '2023-07-01 11:00:00', '2023-07-15 11:00:00'),
('INV001', 8, '2023-08-01 12:00:00', '2023-08-15 12:00:00'),
('INV002', 9, '2023-09-01 13:00:00', '2023-09-15 13:00:00'),
('INV003', 10, '2023-10-01 14:00:00', '2023-10-15 14:00:00');

-- Datos para la tabla Prestamo

-- Datos para la tabla Reseña
INSERT INTO `Reseña` (`idUsuario`, `idLibro`, `valoracion`, `opinion`) VALUES
(1, 1, 5, 'Excelente libro'),
(2, 2, 4, 'Muy interesante'),
(3, 3, 3, 'Regular'),
(4, 4, 2, 'No me gustó'),
(5, 5, 1, 'Pésimo'),
(6, 6, 5, 'Obra maestra'),
(7, 7, 4, 'Muy bueno'),
(8, 8, 3, 'Interesante'),
(9, 9, 2, 'Podría mejorar'),
(10, 10, 1, 'No me gustó');

-- Datos para la tabla Reserva

-- Datos para la tabla Sancion

DROP PROCEDURE IF EXISTS RealizarPrestamo;

DELIMITER //

CREATE PROCEDURE RealizarPrestamo(
    IN p_numeroInventario VARCHAR(255),
	IN p_idUsuario INT
)
BEGIN
    DECLARE v_sancionado BOOLEAN;
    DECLARE v_disponible BOOLEAN;
    DECLARE v_fechaLimite DATE;
    DECLARE p_mensaje VARCHAR(100);

    -- 1. Verificar sanciones activas
    SELECT COALESCE(sancionadoHasta > CURRENT_DATE(), 0)
    INTO v_sancionado
    FROM Usuario
    WHERE id = p_idUsuario;

    IF v_sancionado THEN
        SET p_mensaje = 'Usuario sancionado. No puede realizar préstamos.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = p_mensaje;
    END IF;

    -- 2. Verificar disponibilidad del ejemplar
    SELECT estado = 'Disponible'
    INTO v_disponible
    FROM Ejemplar
    WHERE numeroInventario = p_numeroInventario;

    IF NOT v_disponible THEN
        SET p_mensaje = 'Ejemplar no disponible para préstamo.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = p_mensaje;
    END IF;

    -- Calcular fecha límite (15 días desde hoy)
    SET v_fechaLimite = DATE_ADD(CURRENT_DATE(), INTERVAL 15 DAY);

    -- 3. Registrar el préstamo
    INSERT INTO Prestamo (
        idUsuario,
        numeroInventario,
        fechaPrestamo,
        fechaLimite
    ) VALUES (
        p_idUsuario,
        p_numeroInventario,
        CURRENT_DATE(),
        v_fechaLimite
    );

    -- 4. Actualizar estado del ejemplar
    UPDATE Ejemplar
    SET estado = 'Prestado'
    WHERE numeroInventario = p_numeroInventario;

    -- 5. Eliminar reserva si existe
    DELETE FROM Reserva
    WHERE idUsuario = p_idUsuario
    AND idLibro = (
        SELECT idLibro
        FROM Ejemplar
        WHERE numeroInventario = p_numeroInventario
    );

END //

DELIMITER ;

-- 5. Crear un procedimiento almacenado denominado DevolverLibro
-- El procedimiento debe permitir registrar la devolución de un libro.
-- Para ello el procedimiento debe:
--
-- 1. Verificar que el ejemplar esté prestado
-- 2. Eliminar el préstamo de la tabla Prestamo
-- 3. Actualizar el estado del ejemplar a 'Disponible'
-- 4. Añadir una entrada en la tabla HistorialPrestamos
-- 5. Actualizar la tabla Usuario si el libro fue devuelto con retraso

DROP PROCEDURE IF EXISTS DevolverLibro;

DELIMITER //

CREATE PROCEDURE DevolverLibro(
    IN p_numeroInventario VARCHAR(255),
    IN p_idUsuario INT
)
BEGIN
    DECLARE v_prestado BOOLEAN;
    DECLARE v_fechaPrestamo DATE;
    DECLARE v_fechaDevolucion DATE;
    DECLARE v_fechaLimite DATE;
    DECLARE v_retraso INT;
    DECLARE p_mensaje VARCHAR(100);

    -- 1. Verificar si el ejemplar está prestado
    SELECT estado = 'Prestado'
    INTO v_prestado
    FROM Ejemplar
    WHERE numeroInventario = p_numeroInventario;

    IF NOT v_prestado THEN
        SET p_mensaje = 'El ejemplar no está prestado.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = p_mensaje;
    END IF;

    -- Obtener datos del préstamo antes de eliminarlo
    SELECT fechaLimite, fechaPrestamo
    INTO v_fechaLimite, v_fechaPrestamo
    FROM Prestamo
    WHERE numeroInventario = p_numeroInventario
    AND idUsuario = p_idUsuario;

    -- 2. Eliminar préstamo
    DELETE FROM Prestamo
    WHERE numeroInventario = p_numeroInventario
    AND idUsuario = p_idUsuario;

    -- 3. Actualizar estado del ejemplar
    UPDATE Ejemplar
    SET estado = 'Disponible'
    WHERE numeroInventario = p_numeroInventario;

    -- 4. Añadir entrada en HistorialPrestamos

    SET v_fechaDevolucion = CURRENT_DATE();
    SET v_retraso = DATEDIFF(v_fechaDevolucion, v_fechaLimite);

    INSERT INTO HistorialPrestamos (
        numeroInventario,
        idUsuario,
        fechaPrestamo,
        fechaDevolucion
    ) VALUES (
        p_numeroInventario,
        p_idUsuario,
        v_fechaPrestamo,
        v_fechaDevolucion
    );

    -- 5. Actualizar tabla Usuario si hay retraso
    IF v_retraso > 0 THEN
        UPDATE Usuario
        SET sancionadoHasta = DATE_ADD(CURRENT_DATE(), INTERVAL v_retraso DAY)
        WHERE id = p_idUsuario;
    END IF;

END //  

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
