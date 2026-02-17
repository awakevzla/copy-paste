; Clipboard Hotkey Manager para Windows
; Requiere AutoHotkey v2.0
; Descarga: https://www.autohotkey.com/

#Requires AutoHotkey v2.0
DetectHiddenWindows True

; Configuración
serverUrl := "http://192.168.0.23:3000/clipboard"

; Estado
lastError := ""

; Tooltip para feedback
ShowTooltip(message, duration := 2000) {
    ToolTip message
    SetTimer(() => ToolTip(), duration)
}

; Enviar portapapeles al servidor
SendToServer() {
    text := A_Clipboard
    
    if (text = "") {
        ShowTooltip("❌ Portapapeles vacío")
        return
    }
    
    try {
        ; Crear objeto WinHTTP
        http := ComObject("WinHttp.WinHttpRequest.5.1")
        http.Open("POST", serverUrl, false)
        http.SetRequestHeader("Content-Type", "application/json")
        
        ; Escapar caracteres especiales para JSON
        escapedText := StrReplace(text, "\", "\\")
        escapedText := StrReplace(escapedText, "`n", "\n")
        escapedText := StrReplace(escapedText, "`r", "\r")
        escapedText := StrReplace(escapedText, "`t", "\t")
        ; Reemplazar comillas usando Chr() para evitar problemas de sintaxis
        dq := Chr(34)
        escapedText := StrReplace(escapedText, dq, "\" . dq)
        
        json := "{" . dq . "text" . dq . ": " . dq . escapedText . dq . "}"
        
        http.Send(json)
        
        if (http.Status = 200) {
            preview := SubStr(StrReplace(text, "`n", " "), 1, 40)
            ShowTooltip("✅ Enviado: " preview "...")
        } else {
            ShowTooltip("❌ Error: " http.Status)
        }
    } catch Error as err {
        ShowTooltip("❌ Error: " err.What)
    }
}

; Obtener del servidor y copiar al portapapeles
GetFromServer() {
    try {
        ; Crear objeto WinHTTP
        http := ComObject("WinHttp.WinHttpRequest.5.1")
        http.Open("GET", serverUrl, false)
        
        http.Send()
        
        if (http.Status = 200) {
            ; Parse JSON
            response := http.ResponseText
            dq := Chr(34)
            
            ; Simple JSON parsing para { "text": "..." }
            searchStr := dq . "text" . dq . ":"
            startPos := InStr(response, searchStr)
            if (startPos > 0) {
                startPos := InStr(response, dq, startPos + 8)
                endPos := InStr(response, dq, startPos + 1)
                text := SubStr(response, startPos + 1, endPos - startPos - 1)
                
                ; Reemplazar escaped sequences
                text := StrReplace(text, "\" . dq, dq)
                text := StrReplace(text, "\\", "\")
                text := StrReplace(text, "\n", "`n")
                text := StrReplace(text, "\r", "`r")
                
                ; Copiar al portapapeles
                A_Clipboard := text
                
                preview := SubStr(StrReplace(text, "`n", " "), 1, 40)
                ShowTooltip("✅ Obtenido: " preview "...")
            }
        } else {
            ShowTooltip("❌ Error: " http.Status)
        }
    } catch Error as err {
        ShowTooltip("❌ Error: " err.What)
    }
}

; Hotkeys
^+c:: SendToServer()        ; Ctrl + Shift + C
^+v:: GetFromServer()       ; Ctrl + Shift + V

; Tray menu
A_IconTip := "Clipboard Manager`n`nCtrl+Shift+C = Enviar`nCtrl+Shift+V = Obtener"

; Exit handler
OnExit(ExitFunc)

ExitFunc(ExitReason, ExitCode) {
    MsgBox(0, "Clipboard Manager", "Manager detenido")
}

^Esc::ExitApp()  ; Ctrl + Esc para salir
