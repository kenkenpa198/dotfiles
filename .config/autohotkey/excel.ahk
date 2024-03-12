#Requires AutoHotkey v2.0

;;; for Excel Keybindings ;;;
#HotIf WinActive("ahk_exe excel.exe")
^Tab::Send "^{PgDn}"  ; Ctrl + Tab
+^Tab::Send "^{PgUp}" ; Shift + Ctrl + Tab
