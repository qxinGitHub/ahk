﻿#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; WinActivate, ahk_exe ONENOTE.EXE
Sleep, 200

Send ^+n
Sleep, 200

MouseGetPos, posx, posy

; Send, {Alt}
; Sleep 100
; Send,h
; Sleep 100
; Send, ff
; Sleep 300
; sendbyclip("思源黑体")
; Sleep, 200
; Send {Enter}

; 更改字号
Sleep, 200
Send, {Alt}
Sleep 100
Send,h
Sleep 100
Send, fs
Sleep 100
Send  14
Sleep, 200
Send {Enter}

; 颜色
Send, !{3}
Sleep 500
MouseClick, , 75, 116, , 0
Sleep 200

MouseMove, posx, posy, 0

Return


;函数

; 从剪贴板输入到界面
; 四个参数 三个可选
  ; move 可选,光标是否移动 (默认 0, 不移动)
  ; left,right 可选,前后空格 (默认 0, 无空格)
sendbyclip(var_string,move:=0,left:=0,right:=0){
    ClipboardOld := ClipboardAll
    Clipboard = %var_string%

    send ^v

    Sleep 100
    Clipboard := ClipboardOld  ; Restore previous contents of clipboard.
    ClipboardOld = ;若原文件过大的情况下可以释放内存

}