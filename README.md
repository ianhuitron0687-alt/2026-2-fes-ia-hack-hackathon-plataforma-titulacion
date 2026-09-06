# 🎓 Plataforma Integral de Titulación — FES Cuautitlán UNAM

[![PHP](https://img.shields.io/badge/PHP-8.2+-777BB4.svg?style=flat-square&logo=php&logoColor=white)](https://php.net)
[![Database](https://img.shields.io/badge/Database-MySQL%20%2F%20MariaDB-4479A1.svg?style=flat-square&logo=mysql&logoColor=white)](https://mariadb.org)
[![Institution](https://img.shields.io/badge/Institution-UNAM%20FES%20Cuautitl%C3%A1n-002B49.svg?style=flat-square)](https://www.cuautitlan.unam.mx/)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](./LICENSE)
[![Author](https://img.shields.io/badge/Author-Ian%20Miguel%20Huitron-007acc.svg?style=flat-square)](https://github.com/iamhuitron)
[![Studio](https://img.shields.io/badge/Studio-XAOL%20Software%20Studio-blueviolet.svg?style=flat-square)](https://github.com/Xaol-Studio)

Sistema inteligente de gestión, verificación documental y seguimiento integral para el proceso de titulación universitaria en la **Facultad de Estudios Superiores Cuautitlán (UNAM)**. Proyecto conceptualizado y desarrollado en el marco del **FES IA Hackathon**.

---

## 📑 Tabla de Contenidos

- [Contexto del Problema](#-contexto-del-problema)
- [Arquitectura de la Solución](#-arquitectura-de-la-solución)
- [Módulos del Sistema](#-módulos-del-sistema)
- [Modelo Relacional de Datos](#-modelo-relacional-de-datos)
- [Stack Tecnológico](#-stack-tecnológico)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Instalación y Despliegue Local](#-instalación-y-despliegue-local)
- [Seguridad y Validaciones](#-seguridad-y-validaciones)
- [Hoja de Ruta y Próximos Pasos](#-hoja-de-ruta-y-próximos-pasos)
- [Licencia](#-licencia)

---

## 📌 Contexto del Problema

El trámite de titulación universitaria en facultades multidisciplinarias históricamente enfrenta fricciones administrativas:
1. **Dispersión departamental:** La validación de no adeudos requiere sellos físicos presenciales entre biblioteca central, laboratorios de carrera, cajas y mediateca.
2. **Opacidad de estatus:** Los egresados carecen de visibilidad en tiempo real del progreso de sus documentos y tiempos de respuesta.
3. **Carga operativa en ventanilla:** Revisión manual de certificados, liberaciones de servicio social y pagos con alta tasa de duplicidad o error humano.

Esta plataforma unifica los flujos de validación en un tablero centralizado, automatizando la verificación de constancias y agilizando la emisión de dictámenes.

---

## 🏗️ Arquitectura de la Solución

```
┌─────────────────────────────────────────────────────────────┐
│                       Cliente Web                           │
│  (HTML5 + CSS3 Gradientes Institucionales UNAM + Vanilla JS)│
└──────────────┬───────────────────────────────▲──────────────┘
               │                               │
       Fetch / POST (JSON)             Render Estatus / UI
               │                               │
┌──────────────▼───────────────────────────────┴──────────────┐
│                    Capa Backend (PHP)                       │
│  ├── login.php        : Auth con bind_param / Fallback demo │
│  ├── upload.php       : Sanitización MIME y cuotas PDF      │
│  └── subida.php       : Orquestador transaccional           │
└──────────────┬───────────────────────────────▲──────────────┘
               │                               │
       Sentencias Preparadas           Consultas de Estatus
               │                               │
┌──────────────▼───────────────────────────────┴──────────────┐
│                 Bases de Datos Relacionales                 │
│  ├── cuentas           : Credenciales y matrículas UNAM     │
│  ├── biblioteca y pagos: Estatus de préstamos y multas      │
│  ├── pagos             : Comprobantes de laboratorio/caja   │
│  ├── constancia        : Acreditación de idiomas (CENLEX)   │
│  └── documentos        : Certificado total y servicio social│
└─────────────────────────────────────────────────────────────┘
```

---

## 🧩 Módulos del Sistema

1. **Portal de Acceso y Autenticación:**
   - Validación de número de cuenta de 9 dígitos.
   - Modo de contingencia/demo integrado para testing local sin dependencia obligatoria de servidor MySQL activo (`admin/admin` o `demo/demo123`).
2. **Tablero Semafórico de Requisitos (`chart.html`):**
   - Monitoreo visual interactivo del estado de cada requisito (Aprobado, En Revisión, Pendiente).
   - Requisitos cubiertos:
     - Constancia de Servicio Social liberado.
     - Acreditación de Idiomas (Inglés/segundo idioma).
     - No adeudo de Biblioteca central y departamental.
     - Pago de derechos de laboratorio y titulación.
     - Certificado Total de Estudios legalizado.
3. **Pipeline Seguro de Carga Documental (`upload.php`):**
   - Verificación de cabeceras y extensión estricta (`.pdf`).
   - Límite de tamaño configurable (máximo 5 MB).
   - Sanitización de nombres con sellado de tiempo y folio de matrícula para evitar sobreescritura accidental o inyección de rutas (`path traversal`).

---

## 🗄️ Modelo Relacional de Datos

El repositorio incluye el esquema unificado en [`src/backend/schema_completo.sql`](./src/backend/schema_completo.sql), listo para importar con un solo comando:

| Tabla | Clave Primaria | Propósito |
|---|---|---|
| `cuentas` | `Num. de cuenta` | Matrícula UNAM y hash de autenticación |
| `biblioteca y pagos` | `Num. de cuenta` | Bandera de adeudo de material bibliográfico y folio |
| `pagos` | `Num. de cuenta` | Validación de pago de cuotas de laboratorio y trámite |
| `constancia` | `numero de cuenta` | Acreditación oficial de idioma extranjero |
| `documentos de titulacion` | `Num. de cuenta` | Estatus de certificado de estudios y servicio social |

---

## 🛠️ Stack Tecnológico

- **Frontend:** HTML5 semántico, CSS3 modular (diseño responsive azul y oro institucional UNAM), JavaScript (Vanilla ES6+ sin librerías externas).
- **Backend:** PHP 8.x con extensiones `mysqli` y manejo estricto de JSON.
- **Persistencia:** MySQL / MariaDB con transacciones ACID y sentencias preparadas contra SQL Injection.
- **Documentación Técnica:** Análisis del problema y especificación de requerimientos en [`docs/`](./docs/).

---

## 🗂️ Estructura del Proyecto

```
titulacion-ai/
├── docs/                                    # Documentación técnica y análisis inicial
│   ├── Analisis de Problema-1.pdf
│   └── The Impact of AI.pdf
├── src/
│   ├── backend/
│   │   ├── config.php                       # Configuración de base de datos
│   │   ├── login.php                        # Endpoint de autenticación JSON
│   │   ├── upload.php                       # Manejador de subida segura de PDFs
│   │   ├── subida.php                       # Lógica de actualización de estatus
│   │   ├── schema_completo.sql              # DDL consolidado con datos semilla
│   │   └── *.sql                            # Esquemas individuales por módulo
│   └── frontendV2/
│       ├── index.html                       # Landing principal y modal de acceso
│       ├── chart.html                       # Tablero de control de estatus
│       ├── Uploadfile.html                  # Interfaz de carga de documentos
│       ├── PageForFiles.html                # Visualizador y gestión de archivos
│       └── *.png                            # Identidad gráfica institucional UNAM
└── README.md
```

---

## ⚙️ Instalación y Despliegue Local

### Requisitos Previos
- PHP 8.0 o superior con extensión `mysqli` habilitada.
- Servidor MySQL / MariaDB (opcional si se utiliza el modo demo).

### 1. Clonar el repositorio
```bash
git clone https://github.com/iamhuitron/titulacion-ai.git
cd titulacion-ai
```

### 2. Configurar la Base de Datos (Opcional)
Si cuentas con MySQL local:
```bash
mysql -u root -p < src/backend/schema_completo.sql
```
Asegúrate de que las credenciales en `src/backend/config.php` coincidan con tu instalación local.

### 3. Iniciar Servidor de Desarrollo
Puedes ejecutar el servidor integrado de PHP directamente desde la carpeta `src/`:
```bash
php -S localhost:8000 -t src/
```

Abre en tu navegador:
```
http://localhost:8000/frontendV2/index.html
```

### 4. Credenciales de Demostración
- **Usuario:** `admin` | **Contraseña:** `admin` (acceso directo al tablero de control)
- **Usuario:** `demo`  | **Contraseña:** `demo123` (simulación de alumno regular)

---

## 🔒 Seguridad y Validaciones

- **Prevención de SQL Injection:** Uso de `mysqli::prepare` y enlaces parametrizados (`bind_param`) en todos los puntos de entrada de datos.
- **Validación de Archivos:** Filtro exclusivo para MIME type application/pdf y sanitización de nombres en uploads.
- **Cero datos sensibles expuestos:** No se almacenan contraseñas en texto plano en producción ni matrículas reales de alumnos.

---

## 🗺️ Hoja de Ruta y Próximos Pasos

- [x] Módulo de autenticación con fallback offline para pruebas.
- [x] Tablero visual de requisitos académicos y administrativos.
- [x] Validador de subida de expedientes en formato PDF.
- [x] Esquema relacional consolidado (`schema_completo.sql`).
- [ ] Integración con Tesseract Wasm / OCR para cotejo automatizado de sellos y firmas digitales.
- [ ] Conector vía API REST para validación de certificados electrónicos de la DGAE.

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](./LICENSE) para más información.

