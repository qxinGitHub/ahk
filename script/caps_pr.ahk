#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

; #Include C:\Users\qxin\OneDrive\AHK\caps\script\Pr\效果控件.ahk

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Ctrl Alt Shift 3  时间轴
;   Ctrl Alt Shift 7  效果
;   Ctrl Alt Shift 8  效果控件
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Gui, +AlwaysOnTop -MaximizeBox -MinimizeBox +ToolWindow
gui, font, s13, Microsoft YaHei

; Gui,Add,Text,,这里是pr脚本
Gui,Add,Button,g变形稳定器 h35,稳定器
Gui,Add,Button,g音量_10 x+10 h35,音量-10
Gui,Add,Button,g音量_12 x+10 h35,12
Gui,Add,Button,g音量_14 x+10 h35,14

; Gui,Add,Text,x15,转场
Gui,Add,Button,g白场 x15 h35,白场
Gui,Add,Button,g黑场 x+10 h35,黑场
Gui,Add,Button,g变焦 x+10 h35,变焦

; 第3行
Gui,Add,Button,g缩放120 x15 h35,缩放120
Gui,Add,Button,g缩放200 x+10 h35,200

; 第4行
Gui,Add,Button,g多机位 x15 h35,多机位
Gui,Add,Button,g切换普通快捷键 x+10 h35,普通按键
Gui,Add,Button,gpr脚本 x+10 h35,Pr脚本




; 这两行是演示
; Gui,Add,Text,gbtn1 Border Center -BackgroundBlue cRed w100 h60,文字按钮
; Gui,Add,Picture ,gpictest w100 h-1,D:\Doucment\My Pictures\狗\狗.jpg


; ^#!p::
CoordMode, Mouse, Screen
MouseGetPos, ScreenPosx, ScreenPosy  ;相对于屏幕的鼠标位置
CoordMode, Mouse, Window   ;恢复到默认
MouseGetPos, posx, posy
posx := posx-100
posy := posy-100
Gui,show,NA X%posx% Y%posy%,PR脚本
Return

Esc::ExitApp

GuiEscape:
GuiClose:
    ; Gui,Hide
    ExitApp
return




变形稳定器(){
    效果("变形稳定器",150)
}
音量_10(){
    效果("音量 预设-10",50)
}
音量_12(){
    效果("音量 预设-12",50)
}
音量_14(){
    效果("音量 预设-14",50)
}
白场(){
    效果("白场过渡",170)
}
黑场(){
    效果("黑场过渡",170)
}
变焦(){
    效果("变焦模糊",170)
}
效果(名称,偏移){
    Gui,hide
    WinActivate, ahk_exe Adobe Premiere Pro.exe
    Sleep, 50
    ; 定位到 “效果栏”
    send ^!+7
    sleep 50
    send +f
    Sleep, 50
    Send,^a
    sendbyclip(名称)
    Sleep, 50
    OutputVarX := A_CaretX + 50
    OutputVarY := A_CaretY + 偏移
    Click,%OutputVarX%,%OutputVarY%
    Sleep, 50
    ExitApp
Return
}

多机位(){
    Gui,hide
    WinActivate, ahk_exe Adobe Premiere Pro.exe
    Sleep, 200

    ; 多机位嵌套
    click ; 切换到时间轴
    Sleep 200
    Send, ^a ; 全选
    Sleep 200
    Send, !c
    Sleep 200
    Send, n
    Sleep, 200
    sendbyclip("多机位嵌套")
    Sleep,200
    Send, {Enter}

    ; 开启多机位
    click ; 切换到时间轴
    Sleep 200
    Send, ^a ; 全选
    Sleep 200
    Send, !c
    Sleep 200
    Send, t
    Sleep 200
    Send, {Enter}
    Sleep, 200

    ; 视图更改
    Send, +0
    Sleep, 100
    Send, ^!k
    Sleep, 500
    MouseClick, , 222, 56, , 0
    Sleep, 400
    MouseClick, , 100, 143, , 0
    Sleep, 200
    Send, {Enter}

    Sleep, 200
    Send, !+2  ;切换至多机位
    Sleep, 100
ExitApp
Return
}


切换普通快捷键(){
    Gui,hide
    WinActivate, ahk_exe Adobe Premiere Pro.exe
    Sleep, 200

    ; 快捷键更改
    Send, ^!k
    Sleep, 600
    MouseClick, , 222, 56, , 0
    Sleep, 500
    MouseClick, , 90, 163, , 0
    Sleep, 300
    Send, {Enter}

    ; 视图更改
    Sleep, 400
    Send, +0
    ; 工作区更改
    Sleep, 400
    Send, !+3  ;  切换至普通剪辑界面(-2)

ExitApp
Return
}


pr脚本(){
    Run, %A_ScriptDir%\Pr\pr按钮.ahk
    ExitApp
}

缩放120(){
    缩放函数(120)
}
缩放200(){
    缩放函数(200)
}
缩放函数(大小){
    Gui,hide
    global ScreenPosx  ;将外部变量声明为全局变量
    global ScreenPosy
    WinActivate, ahk_exe Adobe Premiere Pro.exe
    Sleep, 50
    ; 定位到 “效果控件栏”
    send ^!+8
    sleep 50
    Click,190,170

    sendbyclip(大小)

    Send, {Enter}
    Sleep, 100

    CoordMode, Mouse, Screen
    MouseMove, ScreenPosx, ScreenPosy
    CoordMode, Mouse, Window
    ExitApp
}













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

; 演示按钮
btn1:
; MsgBox, 按钮1
Gui,hide
Return
pictest:
MsgBox,狗
Return

