-- ==============================================================================
-- UNAM FES Cuautitlán - Plataforma Integral de Titulación
-- Esquema Consolidado de Base de Datos (MySQL / MariaDB)
-- ==============================================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Cuentas de alumnos y autenticación
CREATE TABLE IF NOT EXISTS `cuentas` (
  `Num. de cuenta` int(9) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  PRIMARY KEY (`Num. de cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estado de biblioteca y préstamos
CREATE TABLE IF NOT EXISTS `biblioteca y pagos` (
  `Num. de cuenta` int(9) NOT NULL,
  `adeudo de biblioteca` tinyint(1) NOT NULL DEFAULT 0,
  `Num. de referencia` bigint(20) NOT NULL,
  PRIMARY KEY (`Num. de cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Pagos de laboratorio y cajas
CREATE TABLE IF NOT EXISTS `pagos` (
  `Num. de cuenta` int(11) NOT NULL,
  `referencia` varchar(32) NOT NULL,
  `has pago` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Num. de cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Constancias de idiomas (CENLEX / Mediateca)
CREATE TABLE IF NOT EXISTS `constancia` (
  `numero de cuenta` int(11) NOT NULL,
  `constancia` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`numero de cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estatus de documentos de titulación
CREATE TABLE IF NOT EXISTS `documentos de titulacion` (
  `Num. de cuenta` int(11) NOT NULL,
  `certificado de estudios` tinyint(1) NOT NULL DEFAULT 0,
  `servicio social` tinyint(1) NOT NULL DEFAULT 0,
  `constancia de ver` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Num. de cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Datos semilla para entorno de pruebas / demo
INSERT INTO `cuentas` (`Num. de cuenta`, `contraseña`) VALUES
(320000001, 'demo123')
ON DUPLICATE KEY UPDATE `contraseña` = VALUES(`contraseña`);

INSERT INTO `biblioteca y pagos` (`Num. de cuenta`, `adeudo de biblioteca`, `Num. de referencia`) VALUES
(320000001, 0, 100293847)
ON DUPLICATE KEY UPDATE `adeudo de biblioteca` = VALUES(`adeudo de biblioteca`);

INSERT INTO `pagos` (`Num. de cuenta`, `referencia`, `has pago`) VALUES
(320000001, 'LAB-REF-9921', 1)
ON DUPLICATE KEY UPDATE `has pago` = VALUES(`has pago`);

INSERT INTO `constancia` (`numero de cuenta`, `constancia`) VALUES
(320000001, 1)
ON DUPLICATE KEY UPDATE `constancia` = VALUES(`constancia`);

INSERT INTO `documentos de titulacion` (`Num. de cuenta`, `certificado de estudios`, `servicio social`, `constancia de ver`) VALUES
(320000001, 1, 1, 1)
ON DUPLICATE KEY UPDATE `certificado de estudios` = VALUES(`certificado de estudios`);

COMMIT;
