#!/usr/bin/env python3
# Clipboard Hotkey Manager para macOS
# Funciona con keyboard global hooks
# Requiere: pip install pynput requests

import json
import requests
from pynput import keyboard
import subprocess
import sys

SERVER_URL = "http://192.168.0.23:3000/clipboard"

# Colores
class Colors:
    CYAN = '\033[0;36m'
    GREEN = '\033[0;32m'
    RED = '\033[0;31m'
    YELLOW = '\033[1;33m'
    END = '\033[0m'

# Estado para detectar combinaciones
ctrl_pressed = False
shift_pressed = False
last_action_time = 0

def show_notification(title, message):
    """Mostrar notificación en macOS"""
    try:
        script = f'display notification "{message}" with title "{title}"'
        subprocess.run(['osascript', '-e', script], check=False)
    except:
        print(f"{Colors.YELLOW}⚠️  {title}: {message}{Colors.END}")

def get_clipboard():
    """Obtener contenido del portapapeles"""
    try:
        result = subprocess.run(['pbpaste'], capture_output=True, text=True)
        return result.stdout
    except:
        return ""

def set_clipboard(text):
    """Establecer contenido del portapapeles"""
    try:
        process = subprocess.Popen(['pbcopy'], stdin=subprocess.PIPE)
        process.communicate(input=text.encode('utf-8'))
    except:
        pass

def send_to_server():
    """Enviar portapapeles al servidor"""
    global last_action_time
    import time
    
    # Evitar acciones duplicadas
    if time.time() - last_action_time < 0.5:
        return
    last_action_time = time.time()
    
    text = get_clipboard()
    
    if not text:
        show_notification("Clipboard Manager", "❌ Portapapeles vacío")
        return
    
    try:
        response = requests.post(
            SERVER_URL,
            json={"text": text},
            timeout=5
        )
        
        if response.status_code == 200:
            preview = text[:40].replace('\n', ' ')
            msg = f"✅ Enviado: {preview}..."
            show_notification("Clipboard Manager", msg)
            print(f"{Colors.GREEN}{msg}{Colors.END}")
        else:
            show_notification("Clipboard Manager", f"❌ Error: {response.status_code}")
    except Exception as e:
        show_notification("Clipboard Manager", f"❌ Error: {str(e)}")

def get_from_server():
    """Obtener del servidor y copiar al portapapeles"""
    global last_action_time
    import time
    
    # Evitar acciones duplicadas
    if time.time() - last_action_time < 0.5:
        return
    last_action_time = time.time()
    
    try:
        response = requests.get(SERVER_URL, timeout=5)
        
        if response.status_code == 200:
            data = response.json()
            text = data.get('text', '')
            
            if not text:
                show_notification("Clipboard Manager", "⚠️ El servidor está vacío")
                return
            
            # Copiar al portapapeles
            set_clipboard(text)
            
            preview = text[:40].replace('\n', ' ')
            msg = f"✅ Obtenido: {preview}..."
            show_notification("Clipboard Manager", msg)
            print(f"{Colors.GREEN}{msg}{Colors.END}")
        else:
            show_notification("Clipboard Manager", f"❌ Error: {response.status_code}")
    except Exception as e:
        show_notification("Clipboard Manager", f"❌ Error: {str(e)}")

def on_press(key):
    """Detectar teclas presionadas"""
    global ctrl_pressed, shift_pressed
    
    try:
        if key == keyboard.Key.cmd:
            ctrl_pressed = True
        elif key == keyboard.Key.shift:
            shift_pressed = True
        elif ctrl_pressed and shift_pressed:
            if hasattr(key, 'char'):
                if key.char == 'c':
                    send_to_server()
                elif key.char == 'v':
                    get_from_server()
    except:
        pass

def on_release(key):
    """Detectar teclas soltadas"""
    global ctrl_pressed, shift_pressed
    
    try:
        if key == keyboard.Key.cmd:
            ctrl_pressed = False
        elif key == keyboard.Key.shift:
            shift_pressed = False
    except:
        pass

def check_server():
    """Verificar disponibilidad del servidor"""
    try:
        response = requests.get(SERVER_URL, timeout=2)
        return response.status_code == 200
    except:
        return False

def main():
    print(f"{Colors.CYAN}🚀 Clipboard Hotkey Manager para macOS{Colors.END}")
    print(f"{Colors.CYAN}====================================={Colors.END}")
    print("")
    print(f"{Colors.YELLOW}⌨️  Hotkeys configurados:{Colors.END}")
    print(f"  • Cmd + Shift + C = Copiar portapapeles → Servidor")
    print(f"  • Cmd + Shift + V = Obtener servidor → Portapapeles")
    print("")
    
    # Check server
    if not check_server():
        print(f"{Colors.RED}❌ El servidor no está disponible{Colors.END}")
        print(f"{Colors.YELLOW}   Inicia el servidor con: npm start{Colors.END}")
        sys.exit(1)
    
    print(f"{Colors.GREEN}✅ Servidor disponible{Colors.END}")
    print(f"{Colors.YELLOW}💡 Presiona Ctrl+C para detener{Colors.END}")
    print("")
    
    # Listener
    listener = keyboard.Listener(on_press=on_press, on_release=on_release)
    listener.start()
    listener.join()

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print(f"\n{Colors.YELLOW}Manager detenido{Colors.END}")
        sys.exit(0)
    except Exception as e:
        print(f"{Colors.RED}Error: {e}{Colors.END}")
        sys.exit(1)
