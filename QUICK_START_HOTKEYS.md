# 🎯 RESUMEN RÁPIDO - Hotkeys Globales

## 🪟 Windows

### Instalación (una sola vez)

```powershell
# 1. Descargar AutoHotkey
# https://www.autohotkey.com/ → Descargar v2.0

# 2. Instalar AutoHotkey (siguiente, siguiente...)

# ¡Listo!
```

### Ejecución

**Opción A: Doble clic**
```
proyecto/scripts/clipboard-hotkey.ahk
```

**Opción B: Terminal**
```powershell
cd scripts
.\clipboard-hotkey.ahk
```

**Opción C: Todo automático**
```powershell
# Desde la carpeta del proyecto
.\start-manager.bat
```

### Hotkeys
- **Ctrl + Shift + C** → Copiar portapapeles al servidor
- **Ctrl + Shift + V** → Obtener servidor al portapapeles

---

## 🍎 macOS

### Instalación (una sola vez)

```bash
# 1. Instalar dependencias
brew install python3
pip3 install pynput requests

# ¡Listo!
```

### Ejecución

**Opción A: Terminal**
```bash
cd ~/Documents/node-apps/copy-paste
python3 scripts/clipboard-hotkey-mac.py
```

**Opción B: Todo automático**
```bash
bash start-manager-mac.sh
```

**Opción C: Iniciar automáticamente**
```bash
# Ver HOTKEY_SETUP.md
```

### Hotkeys
- **Cmd + Shift + C** → Copiar portapapeles al servidor
- **Cmd + Shift + V** → Obtener servidor al portapapeles

### ⚠️ Primera ejecución
macOS pedirá permiso:
1. System Settings → Privacy & Security → Accessibility
2. Agrega Terminal (o iTerm2)
3. Otorga permiso

---

## 🚀 Flujo Completo

### Terminal 1 (Servidor)
```bash
cd ~/Documents/node-apps/copy-paste  # o Windows path
npm start
```

Verás:
```
🚀 Clipboard server running on http://0.0.0.0:3000
```

### Terminal 2 (Manager)

**Windows:**
```powershell
.\start-manager.bat
```

**macOS:**
```bash
bash start-manager-mac.sh
```

Verás:
```
🚀 Clipboard Hotkey Manager
✅ Servidor disponible
💡 Presiona Ctrl+C para detener
```

---

## 📝 Ejemplo de Uso

### Máquina A (Windows)
1. Copia algo: `Hola mundo`
2. Presiona: **Ctrl + Shift + C**
3. Ves: ✅ Enviado: Hola mundo...

### Máquina B (macOS)
1. Presiona: **Cmd + Shift + V**
2. Ves: ✅ Obtenido: Hola mundo...
3. El texto está en tu portapapeles
4. Pega normalmente: **Cmd + V**

---

## ⚡ Tips

### No funcionan los hotkeys
- Cierra y reabre el manager
- Algunos programas bloquean hotkeys (Zoom, Discord)
- Intenta con otra app abierta

### Servidor no responde
Asegúrate de haber ejecutado `npm start` en la otra terminal

### En macOS dice "Permission denied"
```bash
chmod +x scripts/clipboard-hotkey-mac.py
```

---

## 📚 Documentación completa

Ver: **HOTKEY_SETUP.md**

(Troubleshooting, configuración automática, alternativas, etc.)

---

**¡Listo para usar! Copia y pega entre máquinas sin navegador. 📋**
