;======================================================================o
;                            个人用脚本 
; version:  0.1.2
; lastUpdata: 2021-04-21
;---------------------------------o------------------------------------o
; AHK版本:    Version v1.1.32.00  1.1.33.06
; windows:    20H2 19042.804
; 功能:       Caps Lock 快捷键 : 组合为方向键,快捷操作等 
;             热字串 : 输入缩写时进行扩展 (自动替换)
;             软件自定义 : 自定义软件的快捷键  
;             分号快捷启动 : 配合分号实现快捷启动                     
;---------------------------------o------------------------------------|
;
; Win---># ; Shift--->+ ; Ctrl--->^ ; Alt--->!
;目录
;
;软件改造
;快捷键分配
;ctrl + alt + 9 ;网易云音乐使用 （前进，结合鼠标手势使用）
;ctrl + alt + 0 ;  （后退 ---）

; 以管理员权限运行
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; 需要 v1.0.92.01+
   ExitApp
}

;=====================================================================o
;                       CapsLock Initializer                         ;|
;---------------------------------------------------------------------o
SetCapsLockState, AlwaysOff                                          ;|
;---------------------------------------------------------------------o
;改变热字符串的结尾字符(下面回车与 Tab 之间有空格结尾字符)去掉了单引号。
#Hotstring EndChars -()[]{}:;"/\,.?!`n `t

;激活速率,设定时间内热键最大激活数,超过后弹窗提示
#HotkeyInterval 2000  ;这里是默认值(毫秒)
#MaxHotkeysPerInterval 200 ;速率,默认70,默认导致笔记本触摸板多指操作频繁弹窗提示

; 不检查空变量是否为环境变量(官方建议)
#NoEnv

; 禁用按键历史
; #KeyHistory, 0

;即使菜单出现问题也不会弹窗提示
;Menu, Tray, UseErrorLevel

; 防止线程被定时器中断
Thread, NoTimers, true
Critical, On

; 设置工作目录为脚本所在文件夹,,否则它的工作目录是由快捷方式属性中的"起始位置"字段决定，让脚本无条件使用它所在的文件夹作为工作目录
SetWorkingDir %A_ScriptDir%
; oneDrive 位置
oneDriveDir := "C:\Users\qxin\OneDrive"
;快捷方式位置
shortcuts := A_ScriptDir . "\shortcuts\"

;------------------------------------------------------------------------------
;脚本图标
IfExist, icons/icov2.ico
{
    Menu, Tray, Icon,icons/icov2.ico
}
;托盘图标处创建一个气泡消息窗口，
	; 17 为 1 + 16 , 1为“提示图标” 16为“关闭提示声音”
;TrayTip,caps,启动成功,6,17
;------------------------------------------------------------------------------
;定义一些变量

; 判断输入法使用
oldProcess := WinExist("A")
nowProcess :=
; 锁定主键盘的num
NUMLK := False
;------------------------------------------------------------------------------;
;窗口组
	;窗口组统一使用 g_ 开头
;部分软件拥有类似 vim 的 Insert 设置,将这些软件划分到同一个窗口组
GroupAdd,g_vims,ahk_class SWT_Window0   ;XMind 主窗口
GroupAdd,g_vims,ahk_class TxUNCOM    ;Unreal Commander 主窗口
;Unreal Commander
GroupAdd,g_UNCOM,ahk_class Tdisk_changer ;盘符选择
GroupAdd,g_UNCOM,ahk_class TxUNCOM   ;主界面
GroupAdd,g_UNCOM,ahk_class Tdel_ask   ;删除确认
;XMind
GroupAdd,g_xminds,ahk_class SWT_Window0   ;XMind主窗口

;输入法切换 ----------------------用来控制输入法切换
; 目前只对QQ输入法有效,在 win10 的情况下可以检测中英文状态
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
GroupAdd,g_en,ahk_exe powershell.exe
GroupAdd,g_en,ahk_exe putty.exe
GroupAdd,g_en,ahk_exe pycharm.exe
GroupAdd,g_en,ahk_exe Adobe Premiere Pro.exe
GroupAdd,g_en,ahk_exe Photoshop.exe
GroupAdd,g_en,ahk_exe FSViewer.exe
GroupAdd,g_en,ahk_exe Code.exe
GroupAdd,g_en,ahk_exe v2rayN.exe

;下面的分组已弃用
GroupAdd,g_ignore,ahk_class MultitaskingViewFrame    ;任务切换
;GroupAdd,g_ignore,ahk_class MultitaskingViewFrame    ;任务视图
GroupAdd,g_ignore,ahk_class Windows.UI.Core.CoreWindow    ;开始界面

;------------------------------------------------------------------------------;
;开启定时器
SetTimer,timer
;------------------------------------------------------------------------------;

;------------------------------------------------------------------------------;
; 读取一些个人信息, 
FileEncoding, UTF-8
fileName := oneDriveDir . "\AHK\info.txt"
fileInfo := []
Loop, Read, %fileName%
{
	fileInfo.Push(A_LoopReadLine)
}
info_winPassword := fileInfo[2]     ;由于脚本是管理员权限, 所以所有通过脚本打开的程序也将是管理员权限, 但是可以通过runas自定义改变
info_phone := fileInfo[4]
info_id := fileInfo[6]
info_googleMail := fileInfo[8]
info_password := fileInfo[10]
;------------------------------------------------------------------------------;



#Include xin_runApp.ahk
#Include xin_热字串.ahk
#Include xin_软件自定义.ahk
#Include xin_屏幕边缘操作.ahk
#Include xin_快捷键.ahk
#Include xin_快捷键_caps.ahk
#Include xin_函数.ahk
#Include xin_函数_输入法.ahk
#Include xin_candy.ahk ; 2017-03-14 17:27:06 add

;-----------------------------------------------------------------------------
;重启脚本 Ctrl + Alt + r
^#!r::Reload
{
	Sleep 1000
	Msgbox,36,重启出错,脚本无法加载.你想打开来编辑么?`6秒后自动关闭,6
	IfMsgBox,yes,Edit
}

;写些问题
	;1. 所有的定义(变量,分组,创建的菜单),都需要在 Return,热键,热字符串, wait命令等 之前定义,否则无法使用;
	;2. Wait, WaitClose 之类的程序会每隔100毫秒检查进程一次.所以当此命令处于等待状态时,依旧可以通过热键,自定义菜单项或计时器启动新的进程.但无法正常加载之后的 分组 声明等.
	;3. 2021-04-21 在使用 RunAs后, 后续的run命令无法运行需要计算的变量, 可以先计算后赋值给变量,然后在运行 run, 变量

	;2021-03-08 最新版的ahk会导致单独按ctrl无法触发热键,已退回v1.1.32.00 
		;2021-04-21 3月14日的1.1.33.06的版本已经可以单独触发ctrl按键
