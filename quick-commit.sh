#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 Quick Commit OhmyFi${NC}"
echo "======================="
echo ""

# Actualizar
echo "📥 Actualizando desde GitHub..."
git pull origin main || { echo -e "${RED}❌ Error al actualizar${NC}"; exit 1; }
echo -e "${GREEN}✅ Actualizado${NC}"
echo ""

# Mostrar cambios
echo "📋 Archivos modificados:"
git status --short
echo ""

read -p "¿Continuar con el commit? (s/n): " -n 1 -r
echo ""
[[ ! $REPLY =~ ^[SsYy]$ ]] && { echo "Cancelado"; exit 0; }

# Validar
echo ""
./validate.sh || {
    read -p "Hay errores. ¿Commit de todos modos? (s/n): " -n 1 -r
    echo ""
    [[ ! $REPLY =~ ^[SsYy]$ ]] && { echo "Cancelado"; exit 1; }
}

# Pedir mensaje
echo ""
echo "💬 Mensaje del commit:"
read -p "> " COMMIT_MSG
[ -z "$COMMIT_MSG" ] && { echo -e "${RED}❌ Mensaje vacío${NC}"; exit 1; }

# Verificar referencia a Zoho
if ! echo "$COMMIT_MSG" | grep -qE "ZP-[0-9]+"; then
    echo -e "${YELLOW}⚠️  Sin referencia a Zoho (ZP-XXX)${NC}"
    read -p "¿Agregar? (s/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[SsYy]$ ]]; then
        read -p "Número de tarea: " TASK_NUM
        COMMIT_MSG="$COMMIT_MSG ZP-$TASK_NUM"
    fi
fi

# Commit y push
echo ""
git add .
git commit -m "$COMMIT_MSG" || { echo -e "${RED}❌ Error en commit${NC}"; exit 1; }
git push origin main || { echo -e "${RED}❌ Error en push${NC}"; exit 1; }

echo ""
echo -e "${GREEN}🎉 ¡Publicado exitosamente!${NC}"
echo ""
echo "Verifica en:"
echo "  GitHub: https://github.com/cvcol/ohmyfi-infografias"
echo "  Producción: https://cvcol.github.io/ohmyfi-infografias/"
