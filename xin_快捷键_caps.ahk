; 大写锁改为capslock+Tab
CapsLock::Send, {ESC}

CapsLock & scf::
    GetKeyState, CapsLockState, CapsLock, T
    if (CapsLockState = "D") {
        SetCapsLockState, AlwaysOff
        displayToast("Caps 关闭","0f0",24)
    } else {
        SetCapsLockState, AlwaysOn
        displayToast("Caps 打开","f00",24)
    }
    KeyWait, scf
Return
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; ---------------------------------------------------------------------------- 未分配
CapsLock & f:: displayToast("无快捷键")
CapsLock & y::displayToast("无快捷键")
CapsLock & w::displayToast("无快捷键")
CapsLock & b:: Send, ^{Left}
CapsLock & g:: Send, {AppsKey}

CapsLock & [:: displayToast("无快捷键")
CapsLock & ]:: displayToast("无快捷键")
CapsLock & /::displayToast("无快捷键")
CapsLock & \::displayToast("无快捷键")

; ---------------------------------------------------------------------------- 鼠标水平滚动
CapsLock & WheelUp::WheelLeft
CapsLock & WheelDown::WheelRight
; ---------------------------------------------------------------------------- 快捷键
CapsLock & z:: Send,  ^#{Left}
CapsLock & x:: Send,  ^#{Right}

; ---------------------------------------------------------------------------- 运行软件
CapsLock & q::Send, +#f     ; Listar搜索
CapsLock & e:: switchToExplorer()       ;切换打开的文件夹
CapsLock & r:: runApp("日历")
CapsLock & t:: runApp("Microsoft To Do","Microsoft To Do")
CapsLock & d:: runApp("OneNote","ahk_exe ONENOTE.EXE")

; ---------------------------------------------------------------------------- 代替CTRL
CapsLock & c:: Send, ^c
CapsLock & v:: Send, ^v
CapsLock & a:: Send, ^a
CapsLock & s:: Send, ^s

; ---------------------------------------------------------------------------- 鼠标移动
CapsLock & Up::
    if GetKeyState("alt")
       opacityControl(True)
    else
        MouseMove, 0, -10, 0, R
    Return
CapsLock & Down::
    if GetKeyState("alt")
        opacityControl()
    else
        MouseMove, 0, 10, 0, R
    Return
CapsLock & Left::  MouseMove, -10, 0, 0, R
CapsLock & Right:: MouseMove, 10, 0, 0, R
;-----------------------------------o
CapsLock & Enter::
    SendEvent {Blind}{LButton down}
    KeyWait Enter
    SendEvent {Blind}{LButton up}
Return


; ---------------------------------------------------------------------------- 数字区
CapsLock & ':: Send, =
CapsLock & 1:: #1
CapsLock & 2:: #2
CapsLock & 3:: runApp("vscode","ahk_exe Code.exe")
CapsLock & 4:: #4
CapsLock & 5:: #5
CapsLock & 6:: Send,+6
CapsLock & 7:: Send,+7
CapsLock & 8:: Send,+8
CapsLock & 9:: Send,+9
CapsLock & 0:: Send,+0



; ---------------------------------------------------------------------------- 方向键
CapsLock & h::
    Suspend,permit
    if GetKeyState("control") = 0 {
        if GetKeyState("alt") = 0
            Send, {Left}
        else
            Send, +{Left}
        Return
    } else {
        if GetKeyState("alt") = 0
            Send, ^{Left}
        else
            Send, +^{Left}
        Return
    }
Return
CapsLock & j::
    Suspend,permit
    if GetKeyState("control") = 0 {
        if GetKeyState("alt") = 0
            Send, {Down}
        else
            Send, +{Down}
        Return
    } else {
        if GetKeyState("alt") = 0
            Send, ^{Down}
        else
            Send, +^{Down}
        Return
    }
Return
CapsLock & k::
    Suspend,permit
    if GetKeyState("control") = 0 {
        if GetKeyState("alt") = 0
            Send, {Up}
        else
            Send, +{Up}
        Return
    } else {
        if GetKeyState("alt") = 0
            Send, ^{Up}
        else
            Send, +^{Up}
        Return
    }
Return
CapsLock & l::
    Suspend,permit
    if GetKeyState("control") = 0 {
        if GetKeyState("alt") = 0
            Send, {Right}
        else
            Send, +{Right}
        Return
    } else {
        if GetKeyState("alt") = 0
            Send, ^{Right}
        else
            Send, +^{Right}
        Return
    }
Return

; ---------------------------------------------------------------------------- 模拟 Home End
CapsLock & i::
    if GetKeyState("control") = 0 {
        if GetKeyState("alt") = 0
            Send, {Home}
        else
            Send, +{Home}
        Return
    } else {
        if GetKeyState("alt") = 0
            Send, ^{Home}
        else
            Send, +^{Home}
        Return
    }
Return
CapsLock & o::
    if GetKeyState("control") = 0 {
        if GetKeyState("alt") = 0
            Send, {End}
        else
            Send, +{End}
        Return
    } else {
        if GetKeyState("alt") = 0
            Send, ^{End}
        else
            Send, +^{End}
        Return
    }
Return

; ---------------------------------------------------------------------------- 模拟 PgDn PgUp
CapsLock & u::
    if GetKeyState("control") = 0 {
        if GetKeyState("alt") = 0
            Send, {PgUp}
        else
            Send, +{PgUp}
        Return
    } else {
        if GetKeyState("alt") = 0
            Send, ^{PgUp}
        else
            Send, +^{PgUp}
        Return
    }
Return
CapsLock & p::
    if GetKeyState("control") = 0 {
        if GetKeyState("alt") = 0
            Send, {PgDn}
        else
            Send, +{PgDn}
        Return
    } else {
        if GetKeyState("alt") = 0
            Send, ^{PgDn}
        else
            Send, +^{PgDn}
        Return
    }
Return

; ----------------------------------------------------------------------------  根据单词移动光标
;CapsLock + ,  |  BackSpace
;CapsLock + .  |  Ctrl + BackSpace
CapsLock & ,::
    if GetKeyState("alt"){
        Send, ^+{Left}
    }else
        Send, ^{Left}
    Return
CapsLock & .::
    if GetKeyState("alt"){
        Send, ^+{Right}
    }else
        Send, ^{Right}
    Return

; ---------------------------------------------------------------------------- 删除
;CapsLock + n  |  Ctrl + Delete (Delete a Word)
;CapsLock + m  |  Delete
CapsLock & m::
    if GetKeyState("alt"){
        Send, ^{Del}
    }else
        Send, {Del}
    Return
CapsLock & n::
    if GetKeyState("alt"){
        Send, ^{BS}
    }else
        Send, {BS}
    Return

