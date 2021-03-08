#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

MouseGetPos, posx, posy

WinActivate, ahk_exe Adobe Premiere Pro.exe
Sleep, 200

Click
Sleep, 100

; 视图更改
Send, +0 ;切换多机位
Sleep, 100

Send, ^!k
Sleep, 500
MouseClick, , 222, 56, , 0
Sleep, 400
MouseClick, , 90, 138, , 0
Sleep, 200
Send, {Enter}

Sleep, 200
Send, !+4
Sleep, 100





; MouseGetPos, posx, posy

  ;官方推荐使用 click ，相比于 MouseClick 更加简单易用，但此处需要将速度设为0，故用 MouseClick
  ;click 204,26
; MouseClick, , 165, 87, , 0


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
  	ClipWait
  	; loop,%left%{
  		Send, {space %left%}
  	; }
    send ^v
    send,{Space %right%}
    Sleep 100
    Clipboard := ClipboardOld  ; Restore previous contents of clipboard.
    ClipboardOld = ;若原文件过大的情况下可以释放内存

    Send {Left %move%}
}