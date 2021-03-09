;;;;; Emacs commands light ;;;;;
; カーソル移動
>^f::Send {Right}
>^b::Send {Left}
>^p::Send {Up}
>^n::Send {Down}
>^a::Send {Home}
>^e::Send {End}

; 削除・切り貼り系
>^d::Send {Delete}
>^h::Send {BackSpace}
>^k::>^x
>^y::>^v

;;;;; Supports ;;;;;
; アプリの終了
!p::!F4