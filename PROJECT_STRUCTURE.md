# 📁 Estructura del Proyecto

```
clipboard-app/
├── 📄 package.json                 # Dependencias Node.js
├── 📄 server.js                    # Backend Express
├── 📄 README.md                    # Documentación principal
├── 📄 HOTKEY_SETUP.md             # Guía completa hotkeys
├── 📄 QUICK_START_HOTKEYS.md      # Guía rápida hotkeys
├── 📄 .env.example                # Variables de entorno
├── 🔧 start-manager.bat           # Launcher Windows
├── 🔧 start-manager-mac.sh        # Launcher macOS
│
├── 📁 public/                      # Frontend web
│   ├── 📄 index.html              # HTML principal
│   ├── 📄 styles.css              # Estilos CSS
│   └── 📄 app.js                  # JavaScript cliente
│
├── 📁 scripts/                    # Scripts globales
│   ├── 🔧 clipboard-hotkey.ahk       # Windows (AutoHotkey)
│   ├── 🔧 clipboard-hotkey.ps1       # Windows (PowerShell)
│   ├── 🍎 clipboard-hotkey-mac.py    # macOS (Python)
│   └── 🍎 clipboard-hotkey-mac.sh    # macOS (Bash)
│
└── 📁 node_modules/               # Dependencias instaladas
```

---

## 📊 Archivos Principales

### Backend
| Archivo | Descripción |
|---------|-------------|
| `server.js` | Express server, endpoints /clipboard (GET, POST, DELETE) |
| `package.json` | Dependencias: express, cors, dotenv |

### Frontend Web
| Archivo | Descripción |
|---------|-------------|
| `public/index.html` | Interfaz HTML (2 botones) |
| `public/styles.css` | Diseño responsive, animaciones |
| `public/app.js` | Lógica cliente, Fetch API, Clipboard API |

### Hotkeys Globales
| Archivo | SO | Lenguaje | Recomendación |
|---------|-------|----------|--------------|
| `scripts/clipboard-hotkey.ahk` | Windows | AutoHotkey | ⭐⭐⭐⭐⭐ |
| `scripts/clipboard-hotkey.ps1` | Windows | PowerShell | ⭐⭐ (referencia) |
| `scripts/clipboard-hotkey-mac.py` | macOS | Python | ⭐⭐⭐⭐⭐ |
| `scripts/clipboard-hotkey-mac.sh` | macOS | Bash | ⭐⭐ (referencia) |

### Launchers (Todo en Uno)
| Archivo | SO | Función |
|---------|-------|---------|
| `start-manager.bat` | Windows | Inicia servidor + manager |
| `start-manager-mac.sh` | macOS | Inicia servidor + manager |

---

## 🔀 Flujos de Datos

### Flujo 1: Enviar (Ctrl+Shift+C)
```
Tu Portapapeles
      ↓
  Manager (script)
      ↓
POST /clipboard
      ↓
Servidor (en memoria)
```

### Flujo 2: Obtener (Ctrl+Shift+V)
```
Servidor (en memoria)
      ↓
GET /clipboard
      ↓
  Manager (script)
      ↓
Tu Portapapeles
```

### Flujo 3: Usar Web (Navegador)
```
Botón "Enviar"
      ↓
Lee portapapeles
      ↓
POST /clipboard
      ↓
Servidor
```

```
Servidor
      ↓
GET /clipboard
      ↓
Botón "Obtener"
      ↓
Copia a portapapeles
```

---

## ⚙️ Tecnologías

### Backend
- **Node.js**: Runtime JavaScript
- **Express**: Framework web minimalista
- **CORS**: Control de origen cruzado
- **dotenv**: Variables de entorno

### Frontend Web
- **HTML5**: Estructura
- **CSS3**: Flexbox, Grid, animaciones
- **JavaScript Vanilla**: Fetch API, Clipboard API

### Hotkeys
- **Windows**: AutoHotkey (lenguaje específico para automatización)
- **macOS**: Python 3 + pynput (librería de eventos del teclado)

---

## 📚 Documentación

| Archivo | Contenido |
|---------|-----------|
| `README.md` | Documentación general, API endpoints |
| `HOTKEY_SETUP.md` | Guía completa instalación y configuración |
| `QUICK_START_HOTKEYS.md` | Pasos rápidos, ejemplos |
| `PROJECT_STRUCTURE.md` | Este archivo |

---

## 🚀 Casos de Uso

### 1. Solo Navegador Web
- Accede a `http://<ip>:3000` desde otro dispositivo
- Usa botones: Enviar / Obtener
- ✅ Sin instalación adicional
- ❌ Necesita navegador abierto

### 2. Hotkeys Windows (Recomendado)
- Instala AutoHotkey (5 min)
- Ejecuta `start-manager.bat`
- ✅ Funciona en segundo plano
- ✅ Sin navegador
- ✅ Muy rápido

### 3. Hotkeys macOS (Recomendado)
- Instala Python + pynput (5 min)
- Ejecuta `bash start-manager-mac.sh`
- ✅ Funciona en segundo plano
- ✅ Sin navegador
- ✅ Muy rápido

### 4. Combinar Ambos
- Máquina A: Windows con hotkeys
- Máquina B: macOS con hotkeys
- Máquina C: Browser en iPad/Android
- ¡Todo conectado al mismo servidor!

---

## 🔐 Seguridad

Por defecto: **NO requiere contraseña** (perfecto para red local)

Para habilitar autenticación:

```bash
# Windows
set CLIPBOARD_SECRET=mi-secreto
node server.js

# macOS
export CLIPBOARD_SECRET=mi-secreto
node server.js
```

Los scripts de hotkeys soportan automáticamente el secreto (se lee de localStorage en navegador).

---

## 💡 Personalizaciones

### Cambiar hotkeys (Windows)

Edita `scripts/clipboard-hotkey.ahk`:

```autohotkey
^+c:: SendToServer()        ; Ctrl + Shift + C (cambiar aquí)
^+v:: GetFromServer()       ; Ctrl + Shift + V (cambiar aquí)
```

Ejemplos:
- `^+c` = Ctrl + Shift + C
- `!+c` = Alt + Shift + C
- `#+c` = Win + Shift + C

### Cambiar hotkeys (macOS)

Edita `scripts/clipboard-hotkey-mac.py` en la función `on_press`:

```python
elif key.char == 'c':      # 'c' = C
    send_to_server()
elif key.char == 'v':      # 'v' = V
    get_from_server()
```

Cambia 'c' y 'v' por otras letras.

---

## 📈 Performance

- **Servidor**: En memoria, sin BD
- **Latencia**: ~50-200ms entre máquinas (red local)
- **Máximo de texto**: Teóricamente ilimitado (RAM)
- **Conexiones simultáneas**: Sin límite (sin BD)
- **CPU**: ~0% en idle
- **RAM**: ~50MB (Node + Express)

---

## 🐛 Debugging

### Ver logs del servidor
```bash
node server.js
```

### Ver logs del manager (Windows)
```
Tooltip visual directamente en pantalla
```

### Ver logs del manager (macOS)
```bash
python3 scripts/clipboard-hotkey-mac.py
# Verás líneas como:
# ✅ Enviado: Hola mundo...
# ✅ Obtenido: Test...
```

### Ver peticiones HTTP
```bash
# Terminal
curl http://localhost:3000/clipboard

# Respuesta
{"text":"tu contenido aquí"}
```

---

**¡Proyecto listo para producción en LAN! 🎉**
