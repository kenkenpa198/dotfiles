#Requires AutoHotkey v2.0

;;; Emacs keybindings ;;;
; Cursor
F13 & f::Right
F13 & b::Left
F13 & p::Up
F13 & n::Down
; Beginning/End of line
F13 & a::HOME
F13 & e::END
; Page up/down
F13 & u::PgUp
F13 & v::PgDn
; Newline
F13 & m::Enter
F13 & j::Enter
F13 & o::
{
    Send "Enter"
    Send "Left"
    return
}
; Copy
F13 & w::^x
F13 & y::^v
; Delete
F13 & d::Del
F13 & h::BS
; Kill line
F13 & k::
{
    Send "+{END}"
    Send "^x"
    return
}
