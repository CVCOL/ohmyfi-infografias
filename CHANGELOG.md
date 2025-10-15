# Historial de Cambios - OhmyFi

Todos los cambios importantes en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/).

---

## [43.1] - 2025-10-15

### 🏗️ Estructura
- **BREAKING CHANGE**: Reorganización completa de archivos
- Consolidación de 16 versiones HTML en un único `index.html` de producción
- Archivado de versiones antiguas en `/archive` para referencia histórica
- Nueva estructura de carpetas `/assets/images` y `/assets/docs`
- Implementación de `.gitignore` para archivos temporales y backups

### 🔧 Versionamiento
- Implementación de `VERSION.json` para metadatos estructurados
- Creación de `CHANGELOG.md` para historial legible por humanos
- Scripts de automatización:
  - `reorganize.sh`: Reorganización estructural de archivos
  - `validate.sh`: Validación pre-commit de código
  - `quick-commit.sh`: Proceso de commit interactivo

### 🛡️ Seguridad (heredado de v43.0)
- Encapsulación en IIFE para prevenir conflictos con plataforma Zoho
- Mejora en el aislamiento del código JavaScript
- Contenedor principal `#ohmyfi-app-container` para mejor encapsulación

### ✨ UX (heredado de v43.0)
- Fallback para generación de PDFs cuando la descarga directa es bloqueada
- Apertura automática en nueva pestaña si el iframe bloquea la descarga
- Mejora en manejo de errores y experiencia del usuario

### 📋 Tarea Relacionada
- Zoho: ZP-REORGANIZACION

### 🎯 Impacto
Esta reorganización elimina el riesgo de regresiones causadas por gestión manual de versiones múltiples. A partir de ahora, Git es la única fuente de verdad para el historial de versiones.

---

## [43.0] - 2025-10-13

### ✨ Nueva Funcionalidad
- Selector de "Modelo de Negocio" entre Venta Directa y Monetización de Audiencia
- Textos explicativos claros debajo de cada opción del selector
- Panel de control dinámico que se adapta al modelo seleccionado

### 🔧 Motor de Cálculo
- Refactorización para soportar dos fórmulas de ingresos distintas
- Lógica diferenciada para cada modelo de negocio
- Validación y cálculos específicos según el modelo activo

### 🎨 UX
- Mejora en la narrativa visual del simulador
- Tarjetas informativas sobre beneficios de cada modelo
- Transiciones visuales suaves entre modelos
- Oculta/muestra inputs relevantes según contexto

### 📋 Tarea Relacionada
- Zoho: ZP-MODELO-DUAL

---

## [42.0] - 2025-10-13

### 🔧 Refactorización Crítica
- **BREAKING CHANGE**: Motor de cálculo completamente refactorizado
- Reemplazo de "LTV" por "Valor de Transacción Promedio"
- Diferenciación explícita entre clientes nuevos y recurrentes

### 💰 Cálculos Financieros
- Corrección del cálculo de "Ahorro en Publicidad" (solo clientes nuevos)
- Corrección del cálculo de "Ingresos Mensuales" (primera transacción)
- Proyecciones de flujo de caja más realistas y defendibles

### 📊 Precisión
- Mejora significativa en cálculo del ROI
- Períodos de recuperación más precisos
- Proyecciones financieras profesionales y auditables

### 📋 Tarea Relacionada
- Zoho: ZP-MOTOR-CALCULO-V2

---

## Convenciones de Versionado

- **MAYOR** (XX.0): Cambios incompatibles o funcionalidad nueva significativa
- **MENOR** (XX.Y): Mejoras, correcciones, ajustes de compatibilidad

## Tipos de Cambios

- **✨ Nueva Funcionalidad**: Características nuevas
- **🔧 Cambio**: Modificaciones en funcionalidad existente
- **🐛 Corrección**: Arreglo de bugs
- **🗑️ Eliminado**: Características removidas
- **🛡️ Seguridad**: Mejoras de seguridad
- **🎨 UX**: Mejoras de experiencia de usuario
- **📚 Documentación**: Cambios en documentación
- **⚡ Performance**: Mejoras de rendimiento
- **🏗️ Estructura**: Cambios en arquitectura o estructura de archivos
