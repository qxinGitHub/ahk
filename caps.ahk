;======================================================================o
;                            个人用脚本                               ;|
;---------------------------------o------------------------------------o
; AHK版本:    Version v1.1.23.01                                      ;|
; 功能:       Caps Lock 快捷键 : 组合为方向键,快捷操作等              ;|
;             热字串 : 输入缩写时进行扩展 (自动替换)                  ;|
;             软件自定义 : 自定义软件的快捷键                         ;|
;             分号快捷启动 : 配合分号实现快捷启动                     ;|
;                                                   ;|
;---------------------------------o------------------------------------|
;
; Win---># ; Shift--->+ ; Ctrl--->^ ; Alt--->!
;目录
;
;软件改造
;快捷键分配
;ctrl + alt + 9 ;网易云音乐使用 （前进，结合鼠标手势使用）
;ctrl + alt + 0 ;  （后退 ---）

;=====================================================================o
;                       CapsLock Initializer                         ;|
;---------------------------------------------------------------------o
SetCapsLockState, AlwaysOff                                          ;|
;---------------------------------------------------------------------o
;改变热字符串的结尾字符(下面回车与 Tab 之间有空格结尾字符)去掉了单引号。
#Hotstring EndChars -()[]{}:;"/\,.?!`n `t

;改变脚本工作目录,否则它的工作目录是由快捷方式属性中的"起始位置"字段决定
SetWorkingDir,%A_ScriptDir%

;激活速率,设定时间内热键最大激活数,超过后弹窗提示
#HotkeyInterval 2000  ;这里是默认值(毫秒)
#MaxHotkeysPerInterval 200 ;速率,默认70,默认导致笔记本触摸板多指操作频繁弹窗提示

; 不检查空变量是否为环境变量(官方建议)
#NoEnv

; 禁用按键历史
#KeyHistory, 0

;即使菜单出现问题也不会弹窗提示
;Menu, Tray, UseErrorLevel

; 防止线程被定时器中断
Thread, NoTimers 

; 检测隐藏窗口, 此处打开后,会导致后面无法激活活动窗口,具体原因未知
; DetectHiddenWindows, On
; 跳过温和的方式激活窗口
; #WinActivateForce

;快捷方式位置
shortcuts := "C:\shortcuts\"
;uncom = C:\Program Files\Unreal Commander\Uncom.exe
;;

;定时器统一提取出来
	;部分软件vim模式,当此类软件不激活时,关闭该模式
	;默认时间250,多数情况已不需要,故将时间设为3000
; SetTimer,vimswitch,5000 ; vim 挂起

;CreatFileMenu()
;------------------------------------------------------------------------------
;脚本图标
IfExist, icons/icon.ico
{
    Menu, Tray, Icon,icons/icon.ico
}
;托盘图标处创建一个气泡消息窗口，
	; 17 为 1 + 16 , 1为“提示图标” 16为“关闭提示声音”
;TrayTip,caps,启动成功,6,17
;------------------------------------------------------------------------------
;定义一些变量

;输入法切换
; IMEFlag = 1
; setChineseLayout()
;监控消息回调ShellMessage，并自动设置输入法
; Gui +LastFound
; hWnd := WinExist()
; DllCall( "RegisterShellHookWindow", UInt,hWnd )
; MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
; OnMessage( MsgNum, "ShellMessage")

; 判断输入法使用
oldProcess := WinExist("A")
nowProcess :=



;------------------------------------------------------------------------------;
;窗口组
	;窗口组统一使用 g_ 开头
	;ahk_class #32770 有毒 , 牵扯的太多,少用为好
;部分软件拥有类似 vim 的 Insert 设置,将这些软件划分到同一个窗口组
GroupAdd,g_vims,ahk_class SWT_Window0   ;XMind 主窗口
;GroupAdd,g_vims,ahk_class #32770    ;XMind 备注窗口? 这个 class 难道是系统的
GroupAdd,g_vims,ahk_class TxUNCOM    ;Unreal Commander 主窗口
;Unreal Commander
GroupAdd,g_UNCOM,ahk_class Tdisk_changer ;盘符选择
GroupAdd,g_UNCOM,ahk_class TxUNCOM   ;主界面
GroupAdd,g_UNCOM,ahk_class Tdel_ask   ;删除确认
;XMind
;GroupAdd,g_xminds,ahk_class #32770    ;XMind备注和批注的窗口
GroupAdd,g_xminds,ahk_class SWT_Window0   ;XMind主窗口

;输入法切换 ----------------------用来控制输入法切换
;=====分组配置
;中文输入法的分组
; GroupAdd,g_cn,ahk_exe QQ.exe  ;QQ
; GroupAdd,g_cn,ahk_exe WINWORD.EXE ;word
GroupAdd,g_cn,ahk_exe MindManager.exe

;英文输入法的分组
    ;实质上是禁用了输入法
GroupAdd,g_en,ahk_class YodaoMainWndClass
GroupAdd,g_en,ahk_exe YodaoDict.exe
GroupAdd,g_en,ahk_exe sublime_text.exe
GroupAdd,g_en,ahk_exe cmd.exe
GroupAdd,g_en,ahk_exe putty.exe
GroupAdd,g_en,ahk_exe pycharm.exe
;下面的分组已弃用
GroupAdd,g_ignore,ahk_class MultitaskingViewFrame    ;任务切换
;GroupAdd,g_ignore,ahk_class MultitaskingViewFrame    ;任务视图
GroupAdd,g_ignore,ahk_class Windows.UI.Core.CoreWindow    ;开始界面

;------------------------------------------------------------------------------;
;开启定时器
SetTimer,timer
;------------------------------------------------------------------------------;
;关闭有道词典底栏广告(已弃用)
; #Include, caps_closeYodaoDictAd.ahk
;自动切换输入法,被定时器取代
;#Include, caps_IME.ahk
#Include, caps_runApp.ahk
#Include, caps_热字串.ahk
#Include, caps_软件自定义.ahk
#Include, caps_快捷键.ahk
#Include, caps_定时器.ahk
#Include, caps_candy.ahk ; 2017-03-14 17:27:06 add


;-----------------------------------------------------------------------------
;重启脚本 Ctrl + Alt + r
^#!r::Reload
{
	Sleep 1000
	Msgbox,36,重启出错,脚本无法加载.你想打开来编辑么?`6秒后自动关闭,6
	IfMsgBox,yes,Edit
}

;写些问题
	;1.所有的定义(变量,分组,创建的菜单),都需要在 Return,热键,热字符串, wait命令等 之前定义,否则无法使用;
	;2. Wait, WaitClose 之类的程序会每隔100毫秒检查进程一次.所以当此命令处于等待状态时,依旧可以通过热键,自定义菜单项或计时器启动新的进程.但无法正常加载之后的 分组 声明等.