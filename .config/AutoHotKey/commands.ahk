; 先に ChgKey を使って caps lock に F13 キーを登録しておく
; F13 キーのスキャンコード：0x0064

;;;;; Emacs Commands light ;;;;;
F13 & f::Right     ; forward char
F13 & b::Left      ; backward char
F13 & p::Up        ; previous line
F13 & n::Down      ; next line
F13 & a::HOME      ; move beginning of line
F13 & e::END       ; move end of line
F13 & d::Del       ; delete char
F13 & h::BS        ; delete backward char
F13 & m::Enter     ; newline

F13 & k::
    send, +{END}
    send, ^x
return
F13 & y::^v

;;;;; Support Commands ;;;;;
F13 & i::F7        ; カタカナ変換
F13 & u::F6        ; ひらがな変換
F13 & o::F10       ; 半角英数字変換

F13 & Space::#s    ; Windows 検索
!q::!F4            ; アプリの終了