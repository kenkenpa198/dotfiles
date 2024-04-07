#Requires AutoHotkey v2.0

;;; Function keys ;;;
F13 & 1::Send "{Blind}{F1}"
F13 & 2::Send "{Blind}{F2}"
F13 & 3::Send "{Blind}{F3}"
F13 & 4::Send "{Blind}{F4}"
F13 & 5::Send "{Blind}{F5}"
F13 & 6::Send "{Blind}{F6}"
F13 & 7::Send "{Blind}{F7}"
F13 & 8::Send "{Blind}{F8}"
F13 & 9::Send "{Blind}{F9}"
F13 & 0::Send "{Blind}{F10}"
F13 & -::Send "{Blind}{F11}"
F13 & =::Send "{Blind}{F12}"

;;; Convert ;;;
; Convert to Katakana
F13 & i::Send "{Blind}{F7}"

;;; for 60% Layout ;;;
F13 & '::`
F13 & \::Send "{Blind}{PrintScreen}"
F13 & BS::Send "{Blind}{Del}"
!BS::Del

;;; Shortcuts ;;;
; Kill
!q::Send "{Blind}!F4"
; Search
F13 & Space::
{
    Send "{Blind}#s"
    return
}
; fzf
F13 & t::Send "{Blind}^t" ; fzf-file-widget
F13 & r::Send "{Blind}^r" ; fzf-history-widget
F13 & c::Send "{Blind}!c" ; fzf-cd-widget

;;; Include ;;;
#include "alt-ime.ahk"
#include "emacs.ahk"
#include "excel.ahk"
