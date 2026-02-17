#!/bin/bash
# Script para iniciar el servidor + manager en macOS
# Uso: bash start-manager-mac.sh

set -e

cd "$(dirname "$0")"

echo ""
echo "========================================"
echo "  Clipboard Manager Launcher (macOS)"
echo "========================================"
echo ""

# Verificar si Node está instalado
if ! command -v node &> /dev/null; then
    echo "❌ ERROR: Node.js no está instalado"
    echo "   Descarga desde: https://nodejs.org/"
    exit 1
fi

# Verificar si Python3 está instalado
if ! command -v python3 &> /dev/null; then
    echo "❌ ERROR: Python3 no está instalado"
    echo "   Instala con: brew install python3"
    exit 1
fi

echo "[1/2] Verificando dependencias Python..."

# Verificar pynput y requests
python3 -c "import pynput" 2>/dev/null || {
    echo "   Instalando pynput..."
    pip3 install pynput
}

python3 -c "import requests" 2>/dev/null || {
    echo "   Instalando requests..."
    pip3 install requests
}

echo "   ✅ Dependencias OK"
echo ""

# Esperar a que inicie
sleep 3

echo "[2/2] Iniciando Clipboard Manager..."
echo ""

# Ejecutar el manager
python3 scripts/clipboard-hotkey-mac.py
