# 🎮 QUICK REFERENCE

## Windows

### Instalación 1️⃣
```
Descarga: https://www.autohotkey.com/v2/
Instala normalmente
✅ Listo
```

### Uso 2️⃣
```powershell
npm start                    # Terminal 1
.\start-manager.bat         # Terminal 2
```

### Hotkeys ⌨️
```
Ctrl + Shift + C  →  Portapapeles → Servidor
Ctrl + Shift + V  →  Servidor → Portapapeles
```

---

## macOS

### Instalación 1️⃣
```bash
brew install python3
pip3 install pynput requests
✅ Listo
```

### Uso 2️⃣
```bash
npm start                           # Terminal 1
bash start-manager-mac.sh          # Terminal 2
```

### Hotkeys ⌨️
```
Cmd + Shift + C  →  Portapapeles → Servidor
Cmd + Shift + V  →  Servidor → Portapapeles
```

### Permisos ⚠️
```
System Settings
  → Privacy & Security
    → Accessibility
      → Agrega Terminal
        → Otorga permiso
```

---

## Navegador Web

### Puerto
```
http://localhost:3000
```

### Botones
```
📤 Enviar portapapeles    (copia local → servidor)
📥 Obtener portapapeles   (servidor → copia local)
```

---

## API REST

```
GET /clipboard
  → { "text": "contenido" }

POST /clipboard
  Body: { "text": "nuevo contenido" }
  → { "success": true, "text": "..." }

DELETE /clipboard
  → { "success": true }
```

---

## Solución de Problemas

```
❌ "Servidor no disponible"
   → npm start en otra terminal

❌ "Hotkeys no funcionan"  
   → Cierra y reabre el manager

❌ "Permission denied"
   → chmod +x scripts/clipboard-hotkey-mac.py

❌ "AutoHotkey error"
   → Instala v2.0 (no v1.1)

❌ "Port 3000 en uso"
   → set PORT=8080 && node server.js
```

---

## Documentación Completa

| Archivo | Para |
|---------|------|
| `README.md` | General |
| `QUICK_START_HOTKEYS.md` | Hotkeys paso a paso |
| `HOTKEY_SETUP.md` | Setup detallado + troubleshooting |
| `PROJECT_STRUCTURE.md` | Arquitectura técnica |
| `DOCS_INDEX.md` | Índice de docs |

---

## Archivos Importantes

```
server.js                      # Backend
public/
  ├─ index.html
  ├─ styles.css
  └─ app.js                    # Frontend
scripts/
  ├─ clipboard-hotkey.ahk       # Windows ⭐
  └─ clipboard-hotkey-mac.py    # macOS ⭐
start-manager.bat             # Windows launcher
start-manager-mac.sh          # macOS launcher
```

---

## Tips

1. **Múltiples máquinas**: Todos apuntan al mismo puerto 3000
2. **Auto-inicio**: Ver HOTKEY_SETUP.md
3. **Seguridad**: Agrega CLIPBOARD_SECRET para usar en internet
4. **Port mapping**: Si necesitas acceso remoto, usa SSH tunnel

---

**¡Copiar y Pegar Global! 📋**
