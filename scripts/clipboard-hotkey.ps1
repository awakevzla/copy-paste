# Clipboard Hotkey Manager para Windows
# Escucha Ctrl+Shift+C y Ctrl+Shift+V globalmente
# Requiere: Windows PowerShell 5.0+

Add-Type @"
using System;
using System.Runtime.InteropServices;

public class GlobalHotkey
{
    [DllImport("user32.dll")]
    private static extern bool RegisterHotKey(IntPtr hWnd, int id, uint fsModifiers, uint vk);
    
    [DllImport("user32.dll")]
    private static extern bool UnregisterHotKey(IntPtr hWnd, int id);
    
    [DllImport("user32.dll")]
    private static extern IntPtr GetMessageExtraInfo();
    
    [DllImport("kernel32.dll")]
    private static extern IntPtr GetConsoleWindow();
    
    private const uint MOD_CONTROL = 2;
    private const uint MOD_SHIFT = 4;
    private const uint VK_C = 67;
    private const uint VK_V = 86;
    
    private static IntPtr handle = GetConsoleWindow();
    private const int HOTKEY_ID_C = 9000;
    private const int HOTKEY_ID_V = 9001;
    
    public static void Register()
    {
        RegisterHotKey(handle, HOTKEY_ID_C, MOD_CONTROL | MOD_SHIFT, VK_C);
        RegisterHotKey(handle, HOTKEY_ID_V, MOD_CONTROL | MOD_SHIFT, VK_V);
        Write-Host "✅ Hotkeys registrados: Ctrl+Shift+C | Ctrl+Shift+V"
    }
}
"@

# API Configuration
$ServerUrl = "http://192.168.0.23:3000"
$Port = 3000

function Send-ToServer {
    param([string]$Text)
    
    try {
        $body = @{ text = $Text } | ConvertTo-Json
        $response = Invoke-RestMethod -Uri "$ServerUrl/clipboard" `
            -Method POST `
            -Headers @{"Content-Type"="application/json"} `
            -Body $body `
            -TimeoutSec 5
        
        Write-Host "✅ Enviado: $(($Text -replace '[\r\n]+', ' ').Substring(0, [Math]::Min(50, $Text.Length)))..." -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "❌ Error al enviar: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

function Get-FromServer {
    try {
        $response = Invoke-RestMethod -Uri "$ServerUrl/clipboard" `
            -Method GET `
            -TimeoutSec 5
        
        $text = $response.text
        
        if ([string]::IsNullOrEmpty($text)) {
            Write-Host "⚠️ El servidor está vacío" -ForegroundColor Yellow
            return $false
        }
        
        # Copiar al portapapeles
        [System.Windows.Forms.SendKeys]::SendWait('^c')  # Simula Ctrl+C para limpiar
        Start-Sleep -Milliseconds 100
        
        # Usar PowerShell nativo para copiar
        $text | Set-Clipboard
        Write-Host "✅ Obtenido: $(($text -replace '[\r\n]+', ' ').Substring(0, [Math]::Min(50, $text.Length)))..." -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "❌ Error al obtener: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

function Check-Server {
    try {
        Invoke-RestMethod -Uri "$ServerUrl/clipboard" -Method GET -TimeoutSec 2 | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

# Main loop
Write-Host "🚀 Clipboard Hotkey Manager" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan
Write-Host ""
Write-Host "⌨️  Hotkeys configurados:" -ForegroundColor Yellow
Write-Host "  • Ctrl + Shift + C = Copiar portapapeles → Servidor" -ForegroundColor Cyan
Write-Host "  • Ctrl + Shift + V = Obtener servidor → Portapapeles" -ForegroundColor Cyan
Write-Host ""

# Check server availability
if (-not (Check-Server)) {
    Write-Host "❌ El servidor no está disponible en $ServerUrl" -ForegroundColor Red
    Write-Host "   Inicia el servidor con: npm start" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Servidor disponible" -ForegroundColor Green
Write-Host "💡 Presiona Ctrl+C en la terminal para detener" -ForegroundColor Yellow
Write-Host ""

# Register hotkeys (conceptual - PowerShell puro no puede interceptar hotkeys globales)
# Para una solución real, usar AutoHotkey
Write-Host "⚠️ NOTA: Este script requiere AutoHotkey para funcionar completamente." -ForegroundColor Yellow
Write-Host "   Ve a: scripts/clipboard-hotkey.ahk" -ForegroundColor Yellow

# Keep running
while ($true) {
    Start-Sleep -Seconds 1
}
