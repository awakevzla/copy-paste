# 📋 Clipboard Compartido

Aplicación web minimalista para compartir texto del portapapeles entre Windows y Mac en la misma red local.

## ✨ Características

- ✅ Enviar/recibir texto entre máquinas en red local
- ✅ Copiar texto al portapapeles del navegador
- ✅ Sincronización automática opcional (cada 2 segundos)
- ✅ Sin base de datos (almacenamiento en memoria)
- ✅ Interfaz minimalista y responsive
- ✅ Seguridad opcional con variable de entorno
- ✅ Soporte CORS para cualquier origen en red local

## 🚀 Inicio rápido

### Requisitos
- Node.js 12+
- npm

### Instalación y ejecución

```bash
# Instalar dependencias
npm install

# Ejecutar el servidor
npm start
# o
node server.js
```

El servidor escuchará en `http://0.0.0.0:3000`

### Acceso desde otra máquina

1. Encuentra la IP de tu máquina:
   - **Windows**: `ipconfig` (busca "IPv4 Address")
   - **Mac/Linux**: `ifconfig` o `hostname -I`

2. Abre en el navegador: `http://<tu-ip>:3000`

## 📡 API

### GET /clipboard
Obtiene el último texto almacenado.

```bash
curl http://localhost:3000/clipboard
# Respuesta: { "text": "contenido" }
```

### POST /clipboard
Envía/sobrescribe el texto.

```bash
curl -X POST http://localhost:3000/clipboard \
  -H "Content-Type: application/json" \
  -d '{"text": "mi texto"}'
# Respuesta: { "success": true, "text": "mi texto" }
```

### DELETE /clipboard
Limpia el servidor.

```bash
curl -X DELETE http://localhost:3000/clipboard
# Respuesta: { "success": true, "text": "" }
```

## 🔐 Seguridad (Opcional)

Para habilitar validación de secreto:

```bash
# En Windows (cmd)
set CLIPBOARD_SECRET=mi-secreto-super-seguro
node server.js

# En Windows (PowerShell)
$env:CLIPBOARD_SECRET="mi-secreto-super-seguro"
node server.js

# En Mac/Linux
export CLIPBOARD_SECRET="mi-secreto-super-seguro"
node server.js
```

Cuando está activado, todos los requests deben incluir el header:
```
X-Clipboard-Secret: mi-secreto-super-seguro
```

El frontend guardará el secreto en localStorage automáticamente.

## 📋 Estructura del Proyecto

```
clipboard-app/
├── package.json          # Dependencias
├── server.js             # Backend Express
├── public/
│   ├── index.html        # Frontend HTML
│   ├── styles.css        # Estilos minimalistas
│   └── app.js            # JavaScript cliente
├── .env                  # Variables de entorno (opcional)
└── README.md             # Este archivo
```

## 🛠️ Tecnologías

**Backend:**
- Express.js - Servidor HTTP
- CORS - Cross-Origin Resource Sharing
- dotenv - Gestión de variables de entorno

**Frontend:**
- HTML5 puro (sin frameworks)
- CSS3 (Grid, Flexbox, animaciones)
- Vanilla JavaScript (Fetch API, Clipboard API)

## 🎯 Casos de uso

- Compartir URLs, código o notas entre máquinas
- Sincronizar portapapeles en equipo sin instalación
- Herramienta de desarrollo para pruebas de red local
- Alternativa ligera a aplicaciones de sincronización completas

## ⚙️ Configuración personalizada

### Cambiar puerto

```bash
set PORT=8080
node server.js
```

### Archivo .env (opcional)

```env
PORT=3000
CLIPBOARD_SECRET=tu-secreto-aqui
```

## 📱 Compatibilidad

- ✅ Windows (PowerShell, CMD)
- ✅ macOS (Terminal)
- ✅ Linux (Bash)
- ✅ Navegadores modernos (Firefox, Chrome, Safari, Edge)

## ⚠️ Limitaciones

- Almacenamiento en memoria (se pierde al reiniciar)
- No soporta archivos o imágenes (solo texto)
- Diseñado para red local (no usar en internet)
- Sin historial persistente
- Sin autenticación de usuario

## 🎮 Hotkeys Globales

Para capturar hotkeys fuera del navegador, usa los scripts incluidos:

### Windows
1. Instala [AutoHotkey](https://www.autohotkey.com/)
2. Ejecuta: `start-manager.bat`
3. O: `scripts\clipboard-hotkey.ahk`

**Hotkeys:**
- **Ctrl + Shift + C** = Copiar portapapeles → Servidor
- **Ctrl + Shift + V** = Obtener servidor → Portapapeles

### macOS
1. Instala dependencias: `pip3 install pynput requests`
2. Ejecuta: `bash start-manager-mac.sh`
3. O: `python3 scripts/clipboard-hotkey-mac.py`

**Hotkeys:**
- **Cmd + Shift + C** = Copiar portapapeles → Servidor
- **Cmd + Shift + V** = Obtener servidor → Portapapeles

**Ver:** [HOTKEY_SETUP.md](HOTKEY_SETUP.md) para configuración completa.

## 🔮 Mejoras futuras

- WebSocket con Socket.io
- Historial de últimos 10 textos
- Historial persistente con SQLite
- Autenticación de usuario
- Sincronización bidireccional
- Interfaz para múltiples "canales"

## 📝 Licencia

MIT

---

**¡Disfruta compartiendo tu portapapeles! 📋**
