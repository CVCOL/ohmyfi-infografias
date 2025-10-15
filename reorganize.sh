#!/bin/bash

echo "🔧 Script de Reorganización OhmyFi v2.0"
echo "========================================"
echo ""

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Verificar que estamos en un repositorio Git
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ ERROR: No estás en un repositorio Git${NC}"
    exit 1
fi

echo -e "${BLUE}📂 Directorio de trabajo: $(pwd)${NC}"
echo ""
echo -e "${YELLOW}⚠️  Este script reorganizará tu estructura de archivos${NC}"
echo "   Acciones a realizar:"
echo "   1. Crear backup de todos los archivos HTML"
echo "   2. Renombrar info_ohmyfi_qas.html a index.html"
echo "   3. Mover versiones antiguas a /archive"
echo "   4. Crear estructura de carpetas /assets"
echo ""
read -p "¿Deseas continuar? (s/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[SsYy]$ ]]; then
    echo "Operación cancelada"
    exit 0
fi

# Crear backup
BACKUP_DIR="backup_$(date +%Y%m%d_%H%M%S)"
echo ""
echo "📦 Creando backup en: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
cp *.html "$BACKUP_DIR/" 2>/dev/null
echo -e "${GREEN}✅ Backup creado con $(ls $BACKUP_DIR/*.html | wc -l) archivos${NC}"

# Crear estructura de carpetas
echo ""
echo "📁 Creando estructura de carpetas..."
mkdir -p archive
mkdir -p assets/images
mkdir -p assets/docs

# Identificar archivo principal (el más reciente info_ohmyfi_qas.html)
MAIN_FILE="info_ohmyfi_qas.html"

echo ""
echo "📝 Archivo principal detectado: $MAIN_FILE"

# Copiar a index.html
if [ -f "$MAIN_FILE" ]; then
    cp "$MAIN_FILE" index.html
    echo -e "${GREEN}✅ index.html creado desde $MAIN_FILE${NC}"
else
    echo -e "${RED}❌ ERROR: No se encontró $MAIN_FILE${NC}"
    exit 1
fi

# Mover versiones antiguas a archive
echo ""
echo "📦 Moviendo versiones antiguas a /archive..."
MOVED_COUNT=0

for file in info_ohmyfi*.html; do
    if [ -f "$file" ]; then
        mv "$file" archive/
        echo "   Movido: $file"
        ((MOVED_COUNT++))
    fi
done

echo -e "${GREEN}✅ $MOVED_COUNT archivo(s) movido(s) a archive/${NC}"

# Crear .gitignore
if [ ! -f ".gitignore" ]; then
    echo ""
    echo "📝 Creando .gitignore..."
    cat > .gitignore << 'EOF'
# Backups
backup_*/

# OS Files
.DS_Store
Thumbs.db

# Editor
.vscode/
*.swp
*.swo

# Temporales
*.tmp
*~

# Zoho WorkDrive
.zw-*
EOF
    echo -e "${GREEN}✅ .gitignore creado${NC}"
fi

# Resumen
echo ""
echo "=========================================="
echo -e "${GREEN}🎉 Reorganización completada exitosamente${NC}"
echo ""
echo "Estructura actual:"
echo "  📄 index.html (archivo principal de producción)"
echo "  📁 archive/ (con $MOVED_COUNT versiones antiguas)"
echo "  📁 assets/images/ (vacía, lista para imágenes)"
echo "  📁 assets/docs/ (vacía, lista para documentos)"
echo "  📦 $BACKUP_DIR/ (backup de seguridad)"
echo ""
echo "Próximos pasos:"
echo "1. Verifica que index.html funciona: firefox index.html"
echo "2. Valida el estado: ohmyfi status"
echo "3. Crea los archivos VERSION.json y CHANGELOG.md"
echo "4. Valida antes de commit: ./validate.sh"
echo ""
echo -e "${BLUE}💡 Tu backup está en: $(pwd)/$BACKUP_DIR${NC}"
