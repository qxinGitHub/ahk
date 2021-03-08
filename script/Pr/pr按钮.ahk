#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance IGNORE 

ScreenPosx := ""
ScreenPosy := ""
posx := ""
posy := ""
视频活动轨道X := ""
视频活动轨道Y := ""
轨道指示X := ""
轨道指示Y := ""

Gui, Color, EEAA99
Gui +LastFound  ; 让 GUI 窗口成为 上次找到的窗口 以用于下一行的命令.
WinSet, TransColor, EEAA99

Gui, +AlwaysOnTop -MaximizeBox -MinimizeBox +ToolWindow -Caption
gui, font, s13, Microsoft YaHei

; Gui,Add,Text,,这里是pr脚本
Gui,Add,Button,g稳定器关闭 h30,稳定器关闭
Gui,Add,Button,g稳定器分析 x+10 h30,重新分析
; Gui,Add,Button,g音量_12 x+10 h35,12
; Gui,Add,Button,g音量_14 x+10 h35,14
; WinSet, Style, -0xC00000,A
Gui,Add,Button,g关闭脚本 x+10 h30,关闭脚本

Gui Show,x650 y-10 NoActivate

; Return

SetTimer pr_timer

Return


; 自动隐藏
pr_timer:
  IfWinActive, ahk_exe Adobe Premiere Pro.exe
  {
    Gui Show,x650 y-10 NoActivate
    Return
  }
  IfWinNotActive, ahk_exe Adobe Premiere Pro.exe
  {
    Gui hide
  }
Return



; 快捷键 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 快捷键
#IfWinActive ahk_exe Adobe Premiere Pro.exe
; NumpadHome::
; 稳定器
NumpadEnd::使用稳定器()
NumpadDown::稳定器分析()
NumpadPgDn::稳定器关闭()
; 音量
NumpadLeft::音量_10()   ;音量缩小
NumpadClear::音量调整(0)   ;重置音量大小
NumpadRight::音量调整()   ;将音量调整为 -16
NumpadHome::白场()
NumpadUp::黑场()
NumpadPgUp::变焦()

NumpadDiv::解释素材()     ;除号

; 如: {Numpad5} 为数字 5. 
; {NumpadDot} 小键盘上的点 (与 Numlock 打开时输入的一样). 
; {NumpadEnter} 小键盘上的 Enter 键 
; {NumpadMult} 小键盘上的乘 
; {NumpadDiv} 小键盘上的除 
; {NumpadAdd} 小键盘上的加 
; {NumpadSub} 小键盘上的减

WheelDown::send, {WheelDown 4}
WheelUp::send, {WheelUp 4}

#IfWinActive


;  函数 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   函数
获取坐标(){
  global
  CoordMode, Mouse, Screen
  MouseGetPos, ScreenPosx, ScreenPosy  ;相对于屏幕的鼠标位置
  CoordMode, Mouse, Window   ;恢复到默认
  MouseGetPos, posx, posy

  ; ImageSearch, 视频活动轨道X, 视频活动轨道Y, 300, 600, 1100, 1100, *2 *Trans2 C:\Users\qxin\OneDrive\AHK\caps\script\img\视频活动轨道.bmp
  ; ImageSearch, 轨道指示X, 轨道指示Y, 300, 600, 1920, 1080, *2 *Trans2 C:\Users\qxin\OneDrive\AHK\caps\script\img\轨道指示.bmp

}
获取视频活动轨道坐标(){
    global
  ImageSearch, 视频活动轨道X, 视频活动轨道Y, 300, 600, 1100, 1100, *2 *Trans2 %A_ScriptDir%\img\视频活动轨道.bmp
    loop ErrorLevel {
      if A_Index > 5
       Break
      ImageSearch, 视频活动轨道X, 视频活动轨道Y, 300, 600, 1100, 1100, *2 *Trans2 %A_ScriptDir%\img\视频活动轨道.bmp
      if !ErrorLevel
       Break
    }
  if ErrorLevel {
    displayToast("未找到视频活动轨道")
  }
}

获取轨道指示坐标(){
    global
  ImageSearch, 轨道指示X, 轨道指示Y, 300, 600, 1920, 1080, *2 *Trans2 %A_ScriptDir%\img\轨道指示.bmp
    loop ErrorLevel {
      if A_Index > 5
       Break
      ImageSearch, 轨道指示X, 轨道指示Y, 300, 600, 1920, 1080, *2 *Trans2 %A_ScriptDir%\img\轨道指示.bmp
      if !ErrorLevel
       Break
    }
  if ErrorLevel
    displayToast("未找到视频活动轨道")
  Return
}


使用稳定器(){
  效果("变形稳定器",150)
}

音量_10(){
    效果("音量 预设 -12",50,,true)
}
音量_12(){
    效果("音量 预设-12",50,,true)
}
音量_14(){
    效果("音量 预设-14",50,,true)
}
白场(){
    效果("白场过渡",170,true)
}
黑场(){
    效果("黑场过渡",170,true)
}
变焦(){
    效果("变焦模糊",170,true)
}

效果(名称,偏移,轨道指示:= false,音量:= false){
    global
    获取坐标()
    获取视频活动轨道坐标()
    if !视频活动轨道Y {
      Return
    }

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

    if Abs(ScreenPosx - A_CaretX)<100{
      displayToast("距离过短")
      return
    }

    OutputVarX := A_CaretX + 50
    OutputVarY := A_CaretY + 偏移
    ; Click,%OutputVarX%,%OutputVarY%
    Sleep, 50
    if 轨道指示{
      获取轨道指示坐标()
      if 轨道指示X
        MouseClickDrag, Left, %OutputVarX%, %OutputVarY%, %轨道指示X%, %视频活动轨道Y%
      ; 重置坐标()
      Return
    }
    if 音量{
      MouseClickDrag, Left, %OutputVarX%, %OutputVarY%, %ScreenPosx%, %ScreenPosy%
      ; 重置坐标()
      Return
    }

    MouseClickDrag, Left, %OutputVarX%, %OutputVarY%, %ScreenPosx%, %视频活动轨道Y%
    ; 重置坐标()

Return
}

音量调整(大小:=-18){
  CoordMode, Pixel,Screen
    CoordMode,mouse,Screen
    MouseGetPos, ScreenPosx, ScreenPosy
  ImageSearch, OutputVarX, OutputVarY, 1920, -400, 2200, 1500, *2 *Trans2 %A_ScriptDir%\img\音量级别.bmp
  CoordMode,mouse,Screen
  If (!OutputVarX){
    displayToast("未找到音量按钮-1")
    return
  }

  OutputVarX := OutputVarX + 110
  OutputVarY := OutputVarY + 5
  Click,%OutputVarX%,%OutputVarY%
  Sleep, 50
  send %大小%
  send {enter}

  MouseMove, ScreenPosx, ScreenPosy   ;恢复鼠标位置
    CoordMode, Pixel, Window
    CoordMode, Mouse, Window
}



稳定器分析(){
    CoordMode, Pixel,Screen
    CoordMode,mouse,Screen
    MouseGetPos, ScreenPosx, ScreenPosy

    Sleep, 50
    WinActivate, ahk_exe Adobe Premiere Pro.exe
    Sleep, 50

    ImageSearch, OutputVarX, OutputVarY, 1920, 400, 3000, 1500, *2 *Trans2 %A_ScriptDir%\img\稳定器分析.bmp
    If (!OutputVarX){
        ; ImageSearch, OutputVarX, OutputVarY, 0, 200, 1000, 1000, *2 *Trans2 C:\Users\qxin\OneDrive\AHK\caps\script\img\search_blue.bmp
        displayToast("未找到稳定器")
    }
    Click,%OutputVarX%,%OutputVarY%

    MouseMove, ScreenPosx, ScreenPosy   ;恢复鼠标位置
    CoordMode, Pixel, Window
    CoordMode, Mouse, Window
}

稳定器关闭(){
    CoordMode, Pixel,Screen
    CoordMode,mouse,Screen
    MouseGetPos, ScreenPosx, ScreenPosy

    Sleep, 50
    WinActivate, ahk_exe Adobe Premiere Pro.exe
    Sleep, 50

    ImageSearch, OutputVarX, OutputVarY, 1920, 400, 3000, 1500, *2 *Trans2 %A_ScriptDir%\img\稳定器分析.bmp
    If (!OutputVarX){
        ; ImageSearch, OutputVarX, OutputVarY, 0, 200, 1000, 1000, *2 *Trans2 C:\Users\qxin\OneDrive\AHK\caps\script\img\search_blue.bmp
        displayToast("未找到稳定器")
    }
    OutputVarX := OutputVarX - 200
    OutputVarY := OutputVarY - 10
    Click,%OutputVarX%,%OutputVarY%

    MouseMove, ScreenPosx, ScreenPosy   ;恢复鼠标位置
    CoordMode, Pixel, Window
    CoordMode, Mouse, Window
}

; 调整帧速率 默认25
解释素材(){
  WinActivate, ahk_exe Adobe Premiere Pro.exe
  ; displayToast("解释素材")
  Sleep, 200

  ; MouseGetPos, posx, posy

  Click Right
  Sleep, 150

  Send {Down 8}
  Sleep 150
  Send {Right}
  Sleep 150
  Send {Down}
  Sleep 150
  Send {Enter}
  Sleep 500
  MouseClick, , 200, 140, , 0
  Sleep 100
  Send ^a
  Sleep 300
  Send 25
  ; Sleep 300
  ; Send {Enter}
}



; 通过搜图寻找
; CoordMode, Pixel,Screen
; ImageSearch, OutputVarX, OutputVarY, 0, 200, 1000, 1000, *2 *Trans2 C:\Users\qxin\OneDrive\AHK\caps\script\img\search.bmp
; If (!OutputVarX){
;   ImageSearch, OutputVarX, OutputVarY, 0, 200, 1000, 1000, *2 *Trans2 C:\Users\qxin\OneDrive\AHK\caps\script\img\search_blue.bmp
; }
; CoordMode,mouse,Screen
; Click,%OutputVarX%,%OutputVarY%


关闭脚本(){
    ExitApp
}
GuiEscape:
GuiClose:
    ; Gui,Hide
    ExitApp
return

重置坐标(){
  global
  ScreenPosx := ""
  ScreenPosy := ""
  posx := ""
  posy := ""
  视频活动轨道X := ""
  视频活动轨道Y := ""
  轨道指示X := ""
  轨道指示Y := ""
}




;弹窗提示
  ;msg 弹窗消息,
  ;color 可选,字体颜色 (默认白色 #fff);
  ;fontsize 可选,弹窗字体大小 (默认32号字体大小),
  ;time 可选,弹窗持续时间 (默认1.5秒)
  ;font 可选,将要显示的字体 (默认楷体)
;字体找不到好看的。。
; todo: 增加一个窗口组(如游戏,或者其他),在此分组中禁止显示 17/3/14
displayToast(msg,FontColor:="ffffff",fontSize:=32,time:=-1500,fontFamily:="楷书"){
  ;前期工作
  ; 自带的颜色识别莫名其妙,不认#号,简写识别错误(识别成另一种颜色或直接错误)
  ; 如果颜色中带"#"号
  StringReplace, FontColor, FontColor, #,, All
  ; 如果颜色是简写,恢复,正则判断是否为颜色代码
  if RegExMatch(FontColor, "([0-9]|[a-f]|[A-F]){3}"){
    if(StrLen(FontColor)=3){
      FontColor := SubStr(FontColor, 1 , 1)SubStr(FontColor, 1 , 1)SubStr(FontColor, 2 , 1)SubStr(FontColor, 2 , 1)SubStr(FontColor, 3 , 1)SubStr(FontColor, 3 , 1)
    }
  }
  ; 如果传入的时间为正
  if(time>0){
    time := -time
  }
  ;前期工作 end

  ;弹窗 Gui 命名为 MyGui,防止与监控消息冲突
  Gui,testGui: Destroy
  Gui,testGui: +AlwaysOnTop +Disabled -SysMenu  -Caption +Owner  ; +Owner 避免显示任务栏按钮. +LastFound
    ;    -sysmenu :防止交互  -SysMenu:默认,去掉最大化最小化关闭 -caption:去掉标题栏
  Gui,testGui:Font,s%fontSize% c%FontColor% bold  ,%fontFamily%
  Gui,testGui:Color,272822  ; sublime 底色
  Gui,testGui: Add, Text,, %msg%
  ; 设定窗口透明度 , 未果(无标题窗口需要先透明，再去掉标题)
  ; Gui +LastFound  ; 让 GUI 窗口成为 上次找到的窗口 以用于下一行的命令.
  ; WinSet, TransColor, 272822 150
  ;WinSet, TransColor, 000  200
  ; 右上位置坐标为X1600 Y50
  Gui,testGui: Show,xcenter y900  NoActivate, Title of Window  ; NoActivate 让当前活动窗口继续保持活动状态.
  ;sleep 3000
  ;time 负值表示计时器只运行一次
  SetTimer, destroyDisplay,%time%
  Return
}
destroyDisplay:
  Gui,testGui:Destroy
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
