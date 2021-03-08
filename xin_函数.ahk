;定时器 和一些全函数

timer:
    IfWinNotActive,ahk_group g_vims
    {
        Suspend,Off
    }

    ; 判断上一次进程和现在的进程是否为同一个
    nowProcess :=WinExist("A")
    if(oldProcess = nowProcess){
        Return
    }
    oldProcess :=WinExist("A")

    ; ime相关 输入法
    IfWinActive, ahk_group g_cn
    {
        setCN_1(nowProcess)
        Return
    }
    IfWinActive, ahk_group g_en
    {
        setEN_1(nowProcess)
        Return
    }
    ;  自动运行pr脚本
    IfWinActive, ahk_exe Adobe Premiere Pro.exe
    {
        run, %A_ScriptDir%\script\Pr\pr按钮.ahk
    }

Return

;函数
; ---------------------------------------------------------------------------- 从剪贴板输入到界面 sendbyclip()
; 四个参数 三个可选
  ; move 可选,光标是否移动 (默认 0, 不移动)
  ; left,right 可选,前后空格 (默认 0, 无空格)
sendbyclip(var_string,move:=0,left:=0,right:=0){
    ClipboardOld := ClipboardAll
    Clipboard = %var_string%
  	ClipWait

  	Send, {space %left%}
    send ^v
    send,{Space %right%}

    Sleep 100
    Clipboard := ClipboardOld  ; Restore previous contents of clipboard.
    ClipboardOld = ;若原文件过大的情况下可以释放内存

    Send {Left %move%}
}
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; ---------------------------------------------------------------------------- 弹窗提示 displayToast()
  ;msg 弹窗消息,
  ;color 可选,字体颜色 (默认白色 #fff);
  ;fontsize 可选,弹窗字体大小 (默认32号字体大小),
  ;time 可选,弹窗持续时间 (默认1.5秒)
  ;font 可选,将要显示的字体 (默认楷体) 字体找不到好看的。。
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
    Gui,testGui:Font,s%fontSize% c%FontColor% bold  ,%fontFamily%
    Gui,testGui:Color,272822  ; sublime 底色
    Gui,testGui: Add, Text,, %msg%

    ; 右上位置坐标为X1600 Y50
    Gui,testGui: Show,xcenter y900  NoActivate, Title of Window  ; NoActivate 让当前活动窗口继续保持活动状态.

    ;time 负值表示计时器只运行一次
    SetTimer, destroyDisplay,%time%
    Return
}
destroyDisplay:
  Gui,testGui:Destroy
  Return
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


; ----------------------------------------------------------------------------  控制透明度 opacityControl()
; 接受一个参数bool值  若为假,增大窗口透明,若为真窗口变透明减小
; 返回值: 当前窗口的透明度
opacityControl(mark:=False){
    WinExist("A")
    WinGet, opacityValue,Transparent
    if(!opacityValue){
    	;如果是之前未设置过透明度, 则取不到值
    	; 设置值后, 再取,若还取不到则证明不支持
        WinSet, Transparent,250
        ; sleep 100
        WinGet, opacityValue,Transparent
        if(!opacityValue){
            displayToast("该软件不支持","#f00",24)
            Return
      }
    }
    if mark{
      opacityValue += 5
    }else{
      opacityValue -= 5
    }
    if(opacityValue >=255){
        displayToast("透明:关闭","#0f0",24)
    }else if(opacityValue<120){ ;禁止过低的透明,防止自己都找不到窗口
        displayToast("透明值过小" + opacityValue*100 // 255,"#f00",24)
    }else{
        WinSet, Transparent,%opacityValue% ;顺序不能颠倒,否则变透明的是下面的提示框
        opacityValue := opacityValue*100 // 255  ; 和这一行换顺序,会导致透明纸设置错误
        displayToast("透明: " . opacityValue . "%","#ff0",24) ; 换顺序 会导致透明提示框
    }
    Return (WinGet, opacityValue,Transparent)
}
Return
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; ---------------------------------------------------------------------------- Explore 切换
switchToExplorer(){
    sleep 11 ;this is to avoid the stuck modifiers bug
    IfWinNotExist, ahk_class CabinetWClass
        Run, explorer.exe
    GroupAdd, taranexplorers, ahk_class CabinetWClass
    if WinActive("ahk_exe explorer.exe")
        GroupActivate, taranexplorers, r
    else
        WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.

    WinGetActiveTitle, OutputVar
    displayToast(OutputVar)
}
closeAllExplorers()
{
    WinClose,ahk_group taranexplorers
}
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; ---------------------------------------------------------------------------- 窗口活动置顶
活动窗口置顶(){
    WinExist("A")
    WinSet, AlwaysOnTop, Toggle ;,%OutputVar%
    WinGet, ExStyle, ExStyle
    if(ExStyle & 0x8){
        displayToast("置顶","0f0",24)
    }else{
        displayToast("取消置顶","f00",24)
    }
}
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; ---------------------------------------------------------------------------- 其他  Function
;获取当前进程 id（未用到）
_mhwnd(){	;background test
	;MouseGetPos,x,,hwnd
	;WinGet, hwnd, id
	hwnd := WinExist("A")
	return "ahk_id " . hwnd
}