;功能：
;1 到几点几分几秒定时关机；——实际上只能精确到分钟
;2 指定多少分钟后定时关机；
;3 立即关机

#SingleInstance force
; #NoTrayIcon
IfExist, icons/ico_shutdown.ico
{
    Menu, Tray, Icon,icons/ico_shutdown.ico
}
;默认将关机时间推后一个小时
Hour := A_Hour + 1
if (Hour>23){
	Hour := 0
}

Gui,New,,关机 ;此行只为定义标题
; GUI -Theme
gui, font, s13, Microsoft YaHei

;第一行
Gui,Add,Edit,x15 y+20 w70 h30 0X2000 ;Number vt,30 ;0X2000 只能输入数字
Gui, Add, UpDown,h25 vt 0X80  Range1-1440, 30
gui,add,text,x+10 yp+2,分钟后
Gui,Add,Button,x+20 yp-2 h28 gst1,关机 (&w)   ;0X8000去掉按钮3d效果改为平面
Gui,Add,Button,x+5 h28 gPowerSleep1,睡眠 (&e)

;第二行
gui,add,edit,x15 y+20 w45 h25
Gui, Add, UpDown,h25 vh Range0-23, %Hour%
gui,add,text,x+5 yp+0,时
gui,add,edit,x+5 yp-0 w45 h25
Gui, Add, UpDown,h25 vm Range0-59, %A_Min%
gui,add,text,x+5 yp+0,分
; gui,add,edit,x+5 yp-5 w50 h25,
; Gui, Add, UpDown,h25 vs Range0-59,%A_Sec%
; gui,add,text,x+5 yp+5,秒
Gui,Add,Button,x+15 yp-2 h28 gst2,关机 (&s)
Gui,Add,Button,x+5 h28 gPowerSleep2,睡眠 (&d)

;第三行
Gui,Add,Button,x15 y+20 h28 gst,立即关机 (&x)
Gui,Add,Button,x+5 h28 gPowerSleep,睡眠 (&c)
Gui,Add,Button,x+5  h28 gCloseGui,取消
; Gui, Color, E8E8FF  ;浅绿色
; Gui, Color, ffffff ;黑色
; Gui, Color, ff0000,00ff00 ;黑色
GuiControl +BackgroundFFFFFF, MyListView
Gui, Show
Return

GuiEscape:
GuiClose:
ExitApp

;指定倒计时关机 (30分钟后关机)
st1:
gui,submit
fun_st1(t,"关机")
Shutdown, 0
return

PowerSleep1:
gui,submit
fun_st1(t,"睡眠")
DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
ExitApp
Return

;指定具体时间关机 (23:59关机)
st2:
gui,submit
fun_st2(h,m,"关机")
Shutdown, 0
return

PowerSleep2:
gui,submit
fun_st2(h,m,"睡眠")
DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
ExitApp
Return

;立即执行
st:
Shutdown, 1
return
ExitApp
return

;睡眠
PowerSleep:
DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
ExitApp
Return

CloseGui:
Gui Destroy
ExitApp
Return



;;函数
fun_st1(t,order){
	msg = 剩余 %t% 分钟%order%
	displayToast(msg)
	Sleep, 1000
	; displayToast(t)
	loop,%t%
	{
	    if (a_index>t)
	    {
	        break
	    }
		sleep,60000
	    count := t-a_index
	    ; ToolTip,剩余 %count% 分钟关机
	    msg = 剩余 %count% 分钟%order%
	    displayToast(msg)
	}
	MsgBox ,33,%order%倒计时,定时%order%的时间到了，确定要关闭计算机吗？`n`n此框30秒内自动确定,30
	IfMsgBox Cancel
    ;MsgBox 取消了关机
    ExitApp
}
fun_st2(h,m,order){
	mh := h - A_Hour
	mm := m - A_Min
	;ms := s - A_Sec
	shut_time := (60*mh + mm)
	;sleep,%shut_time%
	msg = 剩余 %shut_time% 分钟%order%
	displayToast(msg)
	loop,%shut_time%
	{
	    if (a_index>shut_time)
	    {
	        break
	    }
		sleep,60000
	    count := shut_time-a_index
	    ; ToolTip,剩余 %count% 分钟关机2
	    msg = 剩余 %count% 分钟%order%
	    displayToast(msg)
	}
	; ToolTip
	MsgBox ,33,%order%倒计时,定时%order%的时间到了，确定要关闭计算机吗？`n`n此框30秒内自动确定,30
	IfMsgBox Cancel
	    ExitApp
}

;弹窗提示
  ;msg 弹窗消息,
  ;color 字体颜色(可选,默认白色 #fff);
  ;fontsize 弹窗字体大小(可选 默认32号字体大小),
  ;time 弹窗持续时间(可选,默认1.5秒)
  ;font 弹窗消息的字体(可选,默认楷书)
;; 字体找不到好看的。。
displayToast(msg,color="ffffff",fontSize=32,time=-1500,fontFamily="楷书"){
	;弹窗 Gui 命名为 MyGui,防止与监控消息冲突
	Gui,ShutDownGui: Destroy
	Gui,ShutDownGui: +LastFound +AlwaysOnTop +Disabled -SysMenu  -Caption +Owner  ; +Owner 避免显示任务栏按钮.
	Gui,ShutDownGui:Font,s%fontSize% c%color% bold  ,%fontFamily%
	Gui,ShutDownGui:Color,272822  ; sublime 底色
	Gui,ShutDownGui: Add, Text,, %msg%
	;设定窗口透明度 右上位置坐标为X1600 Y50
	;WinSet, TransColor, 000  200
	Gui,ShutDownGui: Show,xcenter y900  NoActivate, Title of Window  ; NoActivate 让当前活动窗口继续保持活动状态.
	;sleep 3000
	;time 负值表示计时器只运行一次
	SetTimer, destroyDisplay,%time%
	;Return
}
destroyDisplay:
	Gui,ShutDownGui:Destroy
Return