;定时器 和一些全函数


timer:
;--------------------------------------
IfWinNotActive,ahk_group g_vims
{
	Suspend,Off
}

;任务栏视图  退出
;输入法也会变成中文,放弃使用
; IfWinActive, ahk_group g_ignore
; {
; 	Return
; }
; 判断上一次进程和现在的进程是否为同一个
nowProcess :=WinExist("A")
if(oldProcess = nowProcess){
	; oldProcess :=WinExist("A")
	Return
}
oldProcess :=WinExist("A")



; ime相关 输入法
IfWinActive, ahk_group g_cn
{
	; setCN(nowProcess)
	setCN_1(nowProcess)
	Return
}
IfWinActive, ahk_group g_en
{
	; setEN(nowProcess)
	setEN_1(nowProcess)
	Return
}
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
  Gui,testGui:Font,s%fontSize% c%FontColor% bold  ,%fontFamily%
  Gui,testGui:Color,272822  ; sublime 底色
  Gui,testGui: Add, Text,, %msg%
  ; 设定窗口透明度 , 未果
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
  return
/*
; 2016-8-31 已经弃用 改用setCN_1 setEN_1
; 切换中文
setCN(hwnd){
	;中文输入法状态 但禁用中文输入法
	if(!IME_GET(%hwnd%) and IME_GetConvMode(%hwnd%) = 1024)
	{
		;MsgBox, pjdr
  		IME_SetConvMode(0x01,%hwnd%)
  		displayToast( "ahk2 中","AED900" )
  		Return
	}else if(!IME_GET(%hwnd%) and IME_GetConvMode(%hwnd%) = 1){
		; if (非0 and 1)
		;此处为 美国键盘
		Send, #{Space}
		displayToast( "美国键盘 中","AED900" )
		Return
	}
	;中文输入法中的英文输入状态
  	if(IME_GetConvMode(%hwnd%) = 1)
  	{
  		;MsgBox, sdfsdf
  		;需要延迟才能正常工作
  		Sleep, 500
  		IME_SetConvMode(0x0401,%hwnd%)
  		Send, {Ctrl}
  		displayToast( "IME 中","AED900" )
  	}
	;displayToast( "ahk2 中","AED900" )
}
; 切换英文
setEN(hwnd){
	;如果在中文输入法状态下 禁用输入法
	if(IME_GET(%hwnd%))
	{
		;Sleep, 100
  		Send, ^{Space}
  		;下面这种方法没用
  		; IME_SetConvMode(0x01,%hwnd%)
;  		MsgBox, aaa
		displayToast( "ahk2 EN","FF2B00" )
	}
}
*/

; 2016-8-31
 ;只保留一个输入法 禁用输入法 或开启输入法,停用上面所有的判断
 setCN_1(hwnd){
 	if(!IME_GET(%hwnd%))
 	{
 		Send, ^{Space}
 		displayToast( "中","AED900" )
 	}
 }
 setEN_1(hwnd){
 	if(IME_GET(%hwnd%))
 	{
 		Send, ^{Space}
 		displayToast( "EN","FF2B00" )
 	}
 }
 setIME(hwnd){
 	Send, ^{Space}
 	if(IME_GET(%hwnd%))
 	{
 		;此处由于先发送了 ctrl space在进行判断,提示需要换下
 		displayToast( "中","AED900" )
 	} else {
 		; Send, ^{Space}
 		displayToast( "EN","FF2B00" )
 	}
 }






;-------------------------------------------------------
; IME 入力モードセット
;   ConvMode        入力モード
;   WinTitle="A"    対象Window
;   戻り値          0:成功 / 0以外:失敗
;--------------------------------------------------------
IME_SetConvMode(ConvMode,WinTitle="A")   {
	ControlGet,hwnd,HWND,,,%WinTitle%
	if	(WinActive(WinTitle))	{
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
	    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
	    NumPut(cbSize, stGTI,  0, "UInt")   ;	DWORD   cbSize;
		hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
	}
    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283      ;Message : WM_IME_CONTROL
          ,  Int, 0x002       ;wParam  : IMC_SETCONVERSIONMODE
          ,  Int, ConvMode)   ;lParam  : CONVERSIONMODE
}
;-------------------------------------------------------
; IME 入力モード取得
;   WinTitle="A"    対象Window
;   戻り値          入力モード
;--------------------------------------------------------
IME_GetConvMode(WinTitle="A")   {
	ControlGet,hwnd,HWND,,,%WinTitle%
	if	(WinActive(WinTitle))	{
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
	    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
	    NumPut(cbSize, stGTI,  0, "UInt")   ;	DWORD   cbSize;
		hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
	}
    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x001   ;wParam  : IMC_GETCONVERSIONMODE
          ,  Int, 0)      ;lParam  : 0
}


;获取当前进程 id（未用到）
_mhwnd(){	;background test
	;MouseGetPos,x,,hwnd
	;WinGet, hwnd, id
	hwnd := WinExist("A")
	return "ahk_id " . hwnd
}

;-----------------------------------------------------------
; IMEの状態をセット
;   SetSts          1:ON / 0:OFF
;   WinTitle="A"    対象Window
;   戻り値          0:成功 / 0以外:失敗
;-----------------------------------------------------------
;当前输入法状态  返回值: 1 中文, 0 英文
IME_GET(WinTitle="A")  {
	ControlGet,hwnd,HWND,,,%WinTitle%
	if	(WinActive(WinTitle))	{
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
		VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
		NumPut(cbSize, stGTI,  0, "UInt")   ;	DWORD   cbSize;
		hwnd := DllCall("GetGuiThReadInfo", Uint,0, Uint,&stGTI)
		? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
	}

	return DllCall("SendMessage"
		, UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
		, UInt, 0x0283  ;Message : WM_IME_CONTROL
		,  Int, 0x0005  ;wParam  : IMC_GETOPENSTATUS
		,  Int, 0)      ;lParam  : 0
}

;---------------------------------------------------------------------------
;  IMEの種類を選ぶかもしれない関数

;==========================================================================
;  IME 文字入力の状態を返す
;  (パクリ元 : http://sites.google.com/site/agkh6mze/scripts#TOC-IME- )
;    標準対応IME : ATOK系 / MS-IME2002 2007 / WXG / SKKIME
;    その他のIMEは 入力窓/変換窓を追加指定することで対応可能
;
;       WinTitle="A"   対象Window
;       ConvCls=""     入力窓のクラス名 (正規表現表記)
;       CandCls=""     候補窓のクラス名 (正規表現表記)
;       戻り値      1 : 文字入力中 or 変換中
;                   2 : 変換候補窓が出ている
;                   0 : その他の状態
;
;   ※ MS-Office系で 入力窓のクラス名 を正しく取得するにはIMEのシームレス表示を
;      OFFにする必要がある
;      オプション-編集と日本語入力-編集中の文字列を文書に挿入モードで入力する
;      のチェックを外す
;==========================================================================
IME_GetConverting(WinTitle="A",ConvCls="",CandCls="") {

    ;IME毎の 入力窓/候補窓Class一覧 ("|" 区切りで適当に足してけばOK)
    ConvCls .= (ConvCls ? "|" : "")                 ;--- 入力窓 ---
            .  "ATOK\d+CompStr"                     ; ATOK系
            .  "|imejpstcnv\d+"                     ; MS-IME系
            .  "|WXGIMEConv"                        ; WXG
            .  "|SKKIME\d+\.*\d+UCompStr"           ; SKKIME Unicode
            .  "|MSCTFIME Composition"              ; Google日本語入力

    CandCls .= (CandCls ? "|" : "")                 ;--- 候補窓 ---
            .  "ATOK\d+Cand"                        ; ATOK系
            .  "|imejpstCandList\d+|imejpstcand\d+" ; MS-IME 2002(8.1)XP付属
            .  "|mscandui\d+\.candidate"            ; MS Office IME-2007
            .  "|WXGIMECand"                        ; WXG
            .  "|SKKIME\d+\.*\d+UCand"              ; SKKIME Unicode
   CandGCls := "GoogleJapaneseInputCandidateWindow" ;Google日本語入力

	ControlGet,hwnd,HWND,,,%WinTitle%
	if	(WinActive(WinTitle))	{
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
	    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
	    NumPut(cbSize, stGTI,  0, "UInt")   ;	DWORD   cbSize;
		hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
	}

    WinGet, pid, PID,% "ahk_id " hwnd
    tmm:=A_TitleMatchMode
    SetTitleMatchMode, RegEx
    ret := WinExist("ahk_class " . CandCls . " ahk_pid " pid) ? 2
        :  WinExist("ahk_class " . CandGCls                 ) ? 2
        :  WinExist("ahk_class " . ConvCls . " ahk_pid " pid) ? 1
        :  0
    SetTitleMatchMode, %tmm%
    return ret
}


;===========================================================
; 控制透明度
;===========================================================
; 接受一个参数bool值  若为假,增大窗口透明,若为真窗口变透明减小 
; 返回值: 当前窗口的透明度
opacityControl(mark:=False){
    WinExist("A")
    WinGet, opacityValue,Transparent
    ; WinGet, PPath ,ProcessPath
    ; MsgBox, %PPath% . `n . %opacityValue%
    ; Return
    ; displayToast(opacityValue,"#f00",24)
    ; Sleep, 1000
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

