#Requires AutoHotkey v2.0

;;; Function Key ;;;
F13 & 1::F1
F13 & 2::F2
F13 & 3::F3
F13 & 4::F4
F13 & 5::F5
F13 & 6::F6
F13 & 7::F7
F13 & 8::F8
F13 & 9::F9
F13 & 0::F10
F13 & -::F11
F13 & =::F12


;;; Emacs Keybindings ;;;
F13 & f::Right     ; Forward char
F13 & b::Left      ; Backward char
F13 & p::Up        ; Previous line
F13 & n::Down      ; Next line

F13 & u::PgUp      ; Page up
F13 & v::PgDn      ; Page down

F13 & a::HOME      ; Move beginning of line
F13 & e::END       ; Move end of line

F13 & d::Del       ; Delete char
F13 & h::BS        ; Delete backward char

F13 & m::Enter     ; Newline
F13 & k::          ; Cut forward string
{
    Send "+{END}"
    Send "^x"
    return
}
F13 & y::^v        ; Yank


;;; Convert ;;;
F13 & i::F7        ; Convert to Katakana
F13 & o::F10       ; Convert to half-width char


;;; Others ;;;
F13 & '::`         ; Backquote
F13 & Space::      ; Search
{
    Send "#s"
    return
}
!q::!F4            ; Kill

;;; Excel ;;;
#HotIf WinActive("ahk_exe excel.exe")
^Tab::Send "^{PgDn}"  ; Ctrl + Tab
+^Tab::Send "^{PgUp}" ; Shift + Ctrl + Tab
