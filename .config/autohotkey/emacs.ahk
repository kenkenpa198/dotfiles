#Requires AutoHotkey v2.0

;;; Emacs keybindings ;;;
; Cursor
F13 & f::Send "{Blind}{Right}"
F13 & b::Send "{Blind}{Left}"
F13 & p::Send "{Blind}{Up}"
F13 & n::Send "{Blind}{Down}"
; Beginning/End of line
F13 & a::Send "{Blind}{HOME}"
F13 & e::Send "{Blind}{END}"
; Page Up/Down
F13 & u::Send "{Blind}{PgUp}"
F13 & v::Send "{Blind}{PgDn}"
; Newline
F13 & m::Send "{Blind}{Enter}"
F13 & j::Send "{Blind}{Enter}"
F13 & o::
{
    Send "{Blind}{End}"
    Send "{Blind}{Enter}"
    Send "{Blind}{Home}"
    Send "{Blind}{Left}"
    return
}
; Copy
F13 & w::Send "{Blind}^x"
F13 & y::Send "{Blind}^v"
; Delete
F13 & d::Send "{Blind}{Del}"
F13 & h::Send "{Blind}{BS}"
; Kill line
F13 & k::
{
    Send "{Blind}+{END}"
    Send "{Blind}^x"
    return
}
