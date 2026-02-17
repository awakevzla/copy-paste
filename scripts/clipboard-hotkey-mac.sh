#!/bin/bash
# Clipboard Hotkey Manager para macOS
# Requiere: brew install cliclick
# Uso: bash scripts/clipboard-hotkey-mac.sh

SERVER_URL="http://192.168.0.23:3000/clipboard"
SEND_KEY="cmd+shift+c"
GET_KEY="cmd+shift+v"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}🚀 Clipboard Hotkey Manager para macOS${NC}"
echo -e "${CYAN}=====================================${NC}"
echo ""
echo -e "${YELLOW}⌨️  Hotkeys configurados:${NC}"
echo -e "  • Cmd + Shift + C = Copiar portapapeles → Servidor"
echo -e "  • Cmd + Shift + V = Obtener servidor → Portapapeles"
echo ""

# Funciones
send_to_server() {
    TEXT=$(pbpaste)
    
    if [ -z "$TEXT" ]; then
        echo -e "${YELLOW}⚠️  Portapapeles vacío${NC}"
        return
    fi
    
    RESPONSE=$(curl -s -X POST "$SERVER_URL" \
        -H "Content-Type: application/json" \
        -d "{\"text\": $(echo "$TEXT" | jq -Rs '.')}")
    
    if echo "$RESPONSE" | jq . >/dev/null 2>&1; then
        PREVIEW=$(echo "$TEXT" | head -c 40)
        echo -e "${GREEN}✅ Enviado: $PREVIEW...${NC}"
    else
        echo -e "${RED}❌ Error al enviar${NC}"
    fi
}

get_from_server() {
    RESPONSE=$(curl -s -X GET "$SERVER_URL")
    
    if echo "$RESPONSE" | jq . >/dev/null 2>&1; then
        TEXT=$(echo "$RESPONSE" | jq -r '.text')
        
        if [ -z "$TEXT" ] || [ "$TEXT" = "null" ]; then
            echo -e "${YELLOW}⚠️  El servidor está vacío${NC}"
            return
        fi
        
        # Copiar al portapapeles
        echo -n "$TEXT" | pbcopy
        
        PREVIEW=$(echo "$TEXT" | head -c 40)
        echo -e "${GREEN}✅ Obtenido: $PREVIEW...${NC}"
    else
        echo -e "${RED}❌ Error al obtener${NC}"
    fi
}

# Check server
check_server() {
    if curl -s "$SERVER_URL" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Verify server is running
if ! check_server; then
    echo -e "${RED}❌ El servidor no está disponible${NC}"
    echo -e "${YELLOW}   Inicia el servidor con: npm start${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Servidor disponible${NC}"
echo ""

# Para capturar hotkeys globales en macOS de forma nativa, 
# necesitamos usar launchd + script ejecutado
# O usar una aplicación de terceros

echo -e "${YELLOW}⚠️  NOTA IMPORTANTE:${NC}"
echo -e "   macOS requiere una configuración especial para hotkeys globales."
echo -e "   Opciones:"
echo ""
echo -e "   ${CYAN}Opción 1: Usar Keyboard Maestro (GUI, recomendado)${NC}"
echo -e "   - Descarga: https://www.keyboardmaestro.com/"
echo -e "   - Configura hotkeys para ejecutar los comandos send/get"
echo ""
echo -e "   ${CYAN}Opción 2: Usar Automator + Calendar alerts${NC}"
echo -e "   - Crea una alarma recurrente que ejecute este script"
echo ""
echo -e "   ${CYAN}Opción 3: Usar Python con pynput (CLI)${NC}"
echo -e "   - Se incluye en: scripts/clipboard-hotkey-mac.py"
echo ""

# Mantener el script corriendo
echo -e "${YELLOW}💡 Script listo. Presiona Ctrl+C para detener${NC}"
echo ""

while true; do
    sleep 1
done
