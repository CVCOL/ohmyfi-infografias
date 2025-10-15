#!/bin/bash

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔍 Validador OhmyFi v2.0${NC}"
echo "========================"
echo ""

ERRORS=0
WARNINGS=0

# 1. Verificar index.html
echo "📄 Verificando archivo principal..."
if [ ! -f "index.html" ]; then
    echo -e "${RED}❌ ERROR: index.html no encontrado${NC}"
    ((ERRORS++))
else
    echo -e "${GREEN}✅ index.html existe${NC}"
    SIZE_KB=$(($(wc -c < index.html) / 1024))
    echo -e "${BLUE}   Tamaño: ${SIZE_KB}KB${NC}"
fi

# 2. Verificar estructura HTML
if [ -f "index.html" ]; then
    echo ""
    echo "🔍 Verificando estructura HTML..."
    
    grep -q "<!DOCTYPE html>" index.html && echo -e "${GREEN}✅ DOCTYPE correcto${NC}" || { echo -e "${YELLOW}⚠️  DOCTYPE faltante${NC}"; ((WARNINGS++)); }
    grep -q "OhmyFi" index.html && echo -e "${GREEN}✅ Contenido OhmyFi detectado${NC}" || { echo -e "${RED}❌ Contenido incorrecto${NC}"; ((ERRORS++)); }
fi

# 3. Verificar que no hay archivos versionados en stage
echo ""
echo "🔍 Verificando Git stage..."
if git diff --cached --name-only 2>/dev/null | grep -qE "info_ohmyfi_v[0-9]+\.html"; then
    echo -e "${RED}❌ ERROR: Archivos versionados (vX.html) en stage${NC}"
    ((ERRORS++))
else
    echo -e "${GREEN}✅ No hay archivos versionados en stage${NC}"
fi

# 4. Verificar VERSION.json
echo ""
echo "📝 Verificando VERSION.json..."
if [ ! -f "VERSION.json" ]; then
    echo -e "${YELLOW}⚠️  VERSION.json no encontrado (créalo pronto)${NC}"
    ((WARNINGS++))
else
    if python3 -m json.tool VERSION.json > /dev/null 2>&1; then
        echo -e "${GREEN}✅ VERSION.json válido${NC}"
        VERSION=$(python3 -c "import json; print(json.load(open('VERSION.json'))['current'])" 2>/dev/null)
        [ ! -z "$VERSION" ] && echo -e "${BLUE}   Versión: $VERSION${NC}"
    else
        echo -e "${RED}❌ VERSION.json inválido${NC}"
        ((ERRORS++))
    fi
fi

# 5. Verificar estructura de carpetas
echo ""
echo "📁 Verificando estructura..."
[ -d "archive" ] && echo -e "${GREEN}✅ Carpeta archive/ ($(ls archive/*.html 2>/dev/null | wc -l) archivos)${NC}" || { echo -e "${YELLOW}⚠️  archive/ faltante${NC}"; ((WARNINGS++)); }
[ -d "assets" ] && echo -e "${GREEN}✅ Carpeta assets/${NC}" || { echo -e "${YELLOW}⚠️  assets/ faltante${NC}"; ((WARNINGS++)); }

# Resumen
echo ""
echo "=========================================="
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✅ TODAS LAS VALIDACIONES PASARON${NC}"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠️  $WARNINGS advertencia(s)${NC}"
    exit 0
else
    echo -e "${RED}❌ $ERRORS error(es), $WARNINGS advertencia(s)${NC}"
    exit 1
fi
