#Requires AutoHotkey v2.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Include
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#Include ../libs/SendKey.ahk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Change right side keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ¥ で Backspace を送信
sc07D:: SendKey("{BS}")
; \ で右の Shift を送信
sc073:: SendKey("{RShift down}{RShift up}")

sc02B:: {
    if (GetKeyState("Shift")) {
        ; Shift + ] でパイプを送信
        Send "|"
    } else {
        ; ] で Enter を送信
        Send "{Enter}"
    }
}

; F13 + ] でバックスラッシュを送信
#HotIf GetKeyState("F13", "P")
sc02B:: Send "\"
#HotIf
