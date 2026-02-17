# 📖 Índice de Documentación

## 🎯 Elige tu punto de entrada

### ⚡ Tengo prisa (5 minutos)
👉 [QUICK_START_HOTKEYS.md](QUICK_START_HOTKEYS.md)
- Pasos esenciales
- Copiar y pegar comandos
- Listo para funcionar

### 📚 Quiero entender todo
👉 [README.md](README.md)
- Características generales
- Uso del navegador web
- API endpoints
- Configuración básica

### 🔧 Configurar hotkeys globales
👉 [HOTKEY_SETUP.md](HOTKEY_SETUP.md)
- Instalación detallada Windows
- Instalación detallada macOS
- Troubleshooting completo
- Alternativas y opciones

### 📁 Ver estructura del proyecto
👉 [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)
- Archivos del proyecto
- Tecnologías usadas
- Flujos de datos
- Personalizaciones

---

## 🚀 Paths Rápidos

### "Solo quiero usar el navegador"
```bash
npm install
npm start
# Accede a: http://localhost:3000
```

### "Quiero hotkeys en Windows"
```bash
# 1. Instala AutoHotkey: https://www.autohotkey.com/
# 2. Ejecuta:
.\start-manager.bat
```

### "Quiero hotkeys en macOS"
```bash
# 1. Instala dependencias:
pip3 install pynput requests

# 2. Ejecuta:
bash start-manager-mac.sh
```

### "Quiero ambos en la misma máquina"
- Terminal 1: `npm start`
- Terminal 2: `bash start-manager-mac.sh` (o `.bat` en Windows)
- ¡Funciona en red local!

---

## 📋 Checklist de Inicio

### Instalación Inicial
- [ ] Clonaste el proyecto
- [ ] Ejecutaste `npm install`
- [ ] El servidor inicia con `npm start`
- [ ] Accedes a `http://localhost:3000` en navegador

### Hotkeys Windows
- [ ] Instalaste AutoHotkey v2.0
- [ ] Ejecutas `start-manager.bat` (o script `.ahk` directo)
- [ ] Los hotkeys Ctrl+Shift+C/V funcionan
- [ ] Ves tooltips de confirmación

### Hotkeys macOS
- [ ] Instalaste Python3 + pynput + requests
- [ ] Das permisos en System Settings → Accessibility
- [ ] Ejecutas `bash start-manager-mac.sh`
- [ ] Los hotkeys Cmd+Shift+C/V funcionan
- [ ] Ves notificaciones del sistema

### Multi-Dispositivo
- [ ] Máquina A copia y envía (Ctrl/Cmd+Shift+C)
- [ ] Máquina B obtiene y pega (Ctrl/Cmd+Shift+V)
- [ ] El texto se sincroniza correctamente

---

## 🆘 Problemas Comunes

### "El servidor no inicia"
→ Ve a [README.md - Troubleshooting](README.md#troubleshooting)

### "Los hotkeys no funcionan"
→ Ve a [HOTKEY_SETUP.md - Troubleshooting General](HOTKEY_SETUP.md#-troubleshooting-general)

### "Permission denied en macOS"
→ Ve a [HOTKEY_SETUP.md - Permisos de accesibilidad](HOTKEY_SETUP.md#paso-3-permisos-de-accesibilidad)

### "No encuentro mi IP"
→ Ve a [README.md - Acceso desde otra máquina](README.md#acceso-desde-otra-máquina)

---

## 🔗 Enlaces Útiles

**Instalaciones Necesarias:**
- AutoHotkey (Windows): https://www.autohotkey.com/
- Python3 (macOS): https://www.python.org/ o `brew install python3`
- Node.js: https://nodejs.org/

**Lecturas Adicionales:**
- [Express.js](https://expressjs.com/)
- [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)
- [Clipboard API](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard_API)
- [AutoHotkey Docs](https://www.autohotkey.com/docs/v2/)
- [pynput Docs](https://pynput.readthedocs.io/)

---

## 📞 Contacto / Soporte

Si tienes dudas:
1. Revisa el archivo de documentación relevante
2. Busca en la sección Troubleshooting
3. Verifica que el servidor está corriendo (`npm start`)
4. Comprueba que los puertos no están en conflicto

---

## 📝 Versiones

- **Versión**: 1.0.0
- **Última actualización**: Febrero 2026
- **Estado**: Producción (LAN local)

---

**¡Elige tu camino y comienza! 🚀**
