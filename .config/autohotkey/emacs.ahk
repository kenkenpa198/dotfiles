#Requires AutoHotkey v2.0

;;; Emacs Keybindings ;;;
F13 & f::Right
F13 & b::Left
F13 & p::Up
F13 & n::Down
F13 & u::PgUp
F13 & v::PgDn
F13 & a::HOME
F13 & e::END

F13 & d::Del
F13 & h::BS
F13 & m::Enter
F13 & y::^v
F13 & k::
{
    Send "+{END}"
    Send "^x"
    return
}
