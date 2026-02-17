// Configuration
const API_BASE = window.location.origin;

// DOM Elements
const sendBtn = document.getElementById('sendBtn');
const fetchBtn = document.getElementById('fetchBtn');
const statusEl = document.getElementById('status');
const messageEl = document.getElementById('message');
const serverStatusEl = document.getElementById('serverStatus');

// Helper: Get secret from localStorage (optional)
function getSecret() {
  return localStorage.getItem('clipboardSecret') || null;
}

// Helper: Fetch with optional secret
async function secureFetch(endpoint, options = {}) {
  const headers = options.headers || {};
  const secret = getSecret();
  if (secret) {
    headers['X-Clipboard-Secret'] = secret;
  }
  return fetch(`${API_BASE}${endpoint}`, {
    ...options,
    headers,
  });
}

// Helper: Update status indicator
function setStatus(type, text) {
  statusEl.className = `status status-${type}`;
  statusEl.textContent = '';
  const dot = document.createElement('span');
  dot.className = 'status-dot';
  statusEl.appendChild(dot);
  statusEl.appendChild(document.createTextNode(text));
}

// Helper: Show message
function showMessage(text, type = 'info') {
  messageEl.className = `message ${type}`;
  messageEl.textContent = text;
  messageEl.classList.remove('hidden');

  // Auto-hide after 4 seconds
  setTimeout(() => {
    messageEl.classList.add('hidden');
  }, 4000);
}

// Helper: Button state
function setButtonsDisabled(disabled) {
  sendBtn.disabled = disabled;
  fetchBtn.disabled = disabled;
}

// Send text from clipboard to server
async function sendText() {
  try {
    setStatus('loading', 'Leyendo portapapeles...');
    setButtonsDisabled(true);

    // Read from clipboard
    const text = await navigator.clipboard.readText();

    if (!text.trim()) {
      showMessage('⚠️ El portapapeles está vacío', 'error');
      setStatus('idle', 'Listo');
      setButtonsDisabled(false);
      return;
    }

    // Send to server
    const response = await secureFetch('/clipboard', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ text }),
    });

    if (!response.ok) {
      if (response.status === 401) {
        throw new Error('No autorizado. Verifica el secreto.');
      }
      throw new Error(`Error del servidor: ${response.status}`);
    }

    setStatus('success', 'Enviado ✓');
    showMessage('📤 Portapapeles enviado al servidor', 'success');
  } catch (error) {
    console.error('Error al enviar:', error);
    setStatus('error', 'Error al enviar');
    showMessage(`❌ ${error.message}`, 'error');
  } finally {
    setButtonsDisabled(false);
  }
}

// Fetch text from server and copy to clipboard
async function fetchText() {
  try {
    setStatus('loading', 'Obteniendo...');
    setButtonsDisabled(true);

    const response = await secureFetch('/clipboard', {
      method: 'GET',
    });

    if (!response.ok) {
      if (response.status === 401) {
        throw new Error('No autorizado. Verifica el secreto.');
      }
      throw new Error(`Error del servidor: ${response.status}`);
    }

    const data = await response.json();
    const text = data.text;

    if (!text) {
      showMessage('⚠️ El servidor no tiene contenido', 'error');
      setStatus('idle', 'Listo');
      setButtonsDisabled(false);
      return;
    }

    // Copy to clipboard
    try {
      // Try modern API first
      if (navigator.clipboard && navigator.clipboard.writeText) {
        try {
          await navigator.clipboard.writeText(text);
        } catch (clipboardError) {
          console.warn('Clipboard API falló, usando fallback:', clipboardError);
          copyToClipboardFallback(text);
        }
      } else {
        copyToClipboardFallback(text);
      }
      setStatus('success', 'Copiado ✓');
      showMessage('📥 Portapapeles actualizado desde servidor', 'success');
    } catch (clipboardError) {
      throw new Error('No se pudo copiar al portapapeles');
    }
  } catch (error) {
    console.error('Error al obtener:', error);
    setStatus('error', 'Error al obtener');
    showMessage(`❌ ${error.message}`, 'error');
  } finally {
    setButtonsDisabled(false);
  }
}

// Fallback function for clipboard copy
function copyToClipboardFallback(text) {
  const textArea = document.createElement('textarea');
  textArea.value = text;
  textArea.style.position = 'fixed';
  textArea.style.left = '-999999px';
  textArea.style.top = '-999999px';
  document.body.appendChild(textArea);
  textArea.focus();
  textArea.select();

  const successful = document.execCommand('copy');
  document.body.removeChild(textArea);

  if (!successful) {
    throw new Error('El comando copy no fue soportado');
  }
}

// Check server status
async function checkServerStatus() {
  try {
    const response = await secureFetch('/clipboard', {
      method: 'GET',
    });

    if (response.ok) {
      serverStatusEl.textContent = '✅ Conectado al servidor';
      serverStatusEl.style.color = '#2e7d32';
    }
  } catch (error) {
    serverStatusEl.textContent = '❌ No se puede conectar al servidor';
    serverStatusEl.style.color = '#c62828';
  }
}

// Event listeners
sendBtn.addEventListener('click', sendText);
fetchBtn.addEventListener('click', fetchText);

// Initialize
document.addEventListener('DOMContentLoaded', () => {
  checkServerStatus();
  setStatus('idle', 'Listo');

  // Check server status periodically
  setInterval(checkServerStatus, 10000);
});
