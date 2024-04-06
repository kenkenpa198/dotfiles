#Requires AutoHotkey v2.0

;;; Function keys ;;;
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

;;; Convert ;;;
F13 & i::F7        ; Convert to Katakana

;;; for 60% Layout ;;;
F13 & '::`
F13 & \::PrintScreen
F13 & BS::Del
!BS::Del

;;; Shortcuts ;;;
!q::!F4            ; Kill
F13 & t::^t        ; fzf-file-widget
F13 & r::^r        ; fzf-history-widget
F13 & c::!c        ; fzf-cd-widget
F13 & Space::      ; Search
{
    Send "#s"
    return
}

;;; Include ;;;
#include "alt-ime.ahk"
#include "emacs.ahk"
#include "excel.ahk"
