# 🌍 Clipboard Hotkey Manager

Guía de configuración para hotkeys globales en Windows y macOS.

## 📋 Tabla de contenidos

- [Windows](#-windows)
- [macOS](#-macos)

---

## 🪟 Windows

### Requisito: AutoHotkey

AutoHotkey es la forma más confiable de capturar hotkeys globales en Windows.

#### Paso 1: Descargar AutoHotkey

1. Ve a: https://www.autohotkey.com/
2. Descarga **AutoHotkey v2.0** (o superior)
3. Ejecuta el instalador y completa la instalación

#### Paso 2: Configurar el script

1. Navega a tu carpeta del proyecto:
   ```
   c:\Users\rober\Documents\node-apps\copy-paste\scripts\
   ```

2. Verifica que exista el archivo `clipboard-hotkey.ahk`

#### Paso 3: Ejecutar el manager

**Opción A: Ejecución manual**

```powershell
# En PowerShell
cd "C:\Users\rober\Documents\node-apps\copy-paste\scripts"
.\clipboard-hotkey.ahk
```

O simplemente **haz doble clic** en `clipboard-hotkey.ahk`

**Opción B: Ejecución automática al iniciar**

1. Presiona `Win + R`
2. Escribe `shell:startup`
3. Crea un atajo para `clipboard-hotkey.ahk` en esa carpeta

#### Paso 4: Verificar funcionamiento

1. Asegúrate de que **npm start** esté corriendo en otra terminal
2. Copia algo en tu portapapeles
3. Presiona **Ctrl + Shift + C**
4. Deberías ver un tooltip: ✅ Enviado: ...
5. Presiona **Ctrl + Shift + V** en otra máquina
6. El contenido debería pegarse automáticamente

#### Hotkeys en Windows

| Combinación | Acción |
|-------------|--------|
| **Ctrl + Shift + C** | Copiar portapapeles → Servidor |
| **Ctrl + Shift + V** | Obtener servidor → Portapapeles |
| **Ctrl + Esc** | Detener el manager |

#### Troubleshooting Windows

**❌ "Script error or unrecognized action"**
- Instala AutoHotkey v2.0 (no v1.1)
- Verifica que el archivo sea `.ahk`

**❌ Los hotkeys no funcionan**
- Cierra el script y vuelve a ejecutar
- Algunas aplicaciones pueden bloquear hotkeys (Zoom, Discord, etc.)
- Intenta con otra aplicación abierta para probar

**❌ Tooltip no aparece**
- Verifica que el servidor esté corriendo: `npm start`
- Comprueba el puerto 3000 en uso

---

## 🍎 macOS

macOS es más restrictivo con hotkeys globales. Hay 3 opciones:

### Opción 1: Python + pynput (⭐ Recomendada)

La más confiable y sin costo.

#### Paso 1: Instalar Python y dependencias

```bash
# Si no tienes Homebrew, instálalo primero:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar Python 3
brew install python3

# Instalar dependencias
pip3 install pynput requests
```

#### Paso 2: Ejecutar el manager

```bash
cd ~/Documents/node-apps/copy-paste
python3 scripts/clipboard-hotkey-mac.py
```

#### Paso 3: Permisos de accesibilidad

macOS te pedirá permiso. Ve a:
1. **System Settings** → **Privacy & Security** → **Accessibility**
2. Agrega Terminal (o iTerm2) a la lista
3. Otorga permiso

#### Paso 4: Ejecutar en segundo plano

Para que se inicie automáticamente:

```bash
# Crear un archivo LaunchAgent
mkdir -p ~/Library/LaunchAgents

# Editar (usando nano)
nano ~/Library/LaunchAgents/com.clipboard.hotkey.plist
```

Pega esto:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.clipboard.hotkey</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/python3</string>
        <string>/Users/rober/Documents/node-apps/copy-paste/scripts/clipboard-hotkey-mac.py</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
```

Guarda (Ctrl+X, luego Y, luego Enter)

Activa el servicio:

```bash
launchctl load ~/Library/LaunchAgents/com.clipboard.hotkey.plist
```

#### Hotkeys en macOS (Opción Python)

| Combinación | Acción |
|-------------|--------|
| **Cmd + Shift + C** | Copiar portapapeles → Servidor |
| **Cmd + Shift + V** | Obtener servidor → Portapapeles |
| **Ctrl + C** (terminal) | Detener el manager |

---

### Opción 2: Keyboard Maestro (GUI, más fácil)

Si prefieres una interfaz gráfica:

1. Descarga: https://www.keyboardmaestro.com/
2. Compra licencia (~$30 USD) o prueba 30 días gratis
3. Crea un macro para cada hotkey que ejecute los comandos

**Ventajas:**
- Interfaz gráfica
- Muy confiable
- Muchas más funcionalidades

---

### Opción 3: Automator (Integrada, limitada)

Usar la app Automator de macOS:

1. Abre **Automator**
2. Crea un nuevo "Quick Action"
3. Agrega "Run Shell Script":
   ```bash
   curl -X POST http://localhost:3000/clipboard \
     -H "Content-Type: application/json" \
     -d "{\"text\": \"$(pbpaste)\"}"
   ```
4. Guarda como "Copiar al servidor"
5. Ve a **System Settings** → **Keyboard** → **Shortcuts**
6. Asigna un hotkey

**Desventaja:** Más trabajo manual, menos confiable

---

## 🔧 Troubleshooting General

### ❌ "Connection refused"

El servidor no está corriendo. Ejecuta en otra terminal:

```bash
npm start
```

### ❌ "Invalid JSON"

Asegúrate de estar copiando/pegando texto válido. Caracteres especiales pueden causar problemas.

### ❌ "Permission denied"

En macOS, da permisos:
```bash
chmod +x scripts/clipboard-hotkey-mac.sh
chmod +x scripts/clipboard-hotkey-mac.py
```

En Windows, ejecuta PowerShell como administrador.

### ❌ El portapapeles está vacío

El servidor no tiene contenido. En otra máquina:
1. Copia algo
2. Presiona Ctrl+Shift+C (Windows) o Cmd+Shift+C (Mac)

---

## 🚀 Guía rápida

### Windows

```powershell
# Terminal 1: Iniciar servidor
npm start

# Terminal 2: Ejecutar manager
cd scripts
.\clipboard-hotkey.ahk
```

### macOS

```bash
# Terminal 1: Iniciar servidor
npm start

# Terminal 2: Ejecutar manager
python3 scripts/clipboard-hotkey-mac.py
```

---

## 📊 Comparativa de soluciones

| Solución | Windows | macOS | Costo | Confiabilidad |
|----------|---------|-------|-------|---------------|
| **AutoHotkey** | ✅ Excelente | ❌ No | Gratis | ⭐⭐⭐⭐⭐ |
| **Python + pynput** | ✅ Bueno | ✅ Excelente | Gratis | ⭐⭐⭐⭐⭐ |
| **Keyboard Maestro** | ✅ Bueno | ✅ Excelente | $30 | ⭐⭐⭐⭐⭐ |
| **Automator** | ❌ No | ✅ Básico | Gratis | ⭐⭐⭐ |

---

## 💡 Tips

1. **Iniciar automáticamente:**
   - Windows: Pon el script en `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`
   - macOS: Usa LaunchAgent (ver arriba)

2. **Múltiples máquinas:**
   - Todos los managers pueden apuntar al mismo servidor
   - El último enviado es lo que se obtiene

3. **Seguridad:**
   - Para uso en internet, agrega `CLIPBOARD_SECRET` (ver README.md)
   - En LAN privada está seguro sin secreto

4. **Problemas de conflictos:**
   - Si otros programas usan Ctrl+Shift+C/V, ajusta en los scripts
   - Windows: Edita en `clipboard-hotkey.ahk`
   - macOS: Edita en `clipboard-hotkey-mac.py`

---

¡Listo! Elige tu opción y comienza a compartir portapapeles. 🎉
