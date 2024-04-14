#Requires AutoHotkey v2.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Excel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#HotIf WinActive("ahk_exe excel.exe")
    ^Tab::Send "^{PgDn}"  ; Ctrl + Tab
    +^Tab::Send "^{PgUp}" ; Shift + Ctrl + Tab
#HotIf
