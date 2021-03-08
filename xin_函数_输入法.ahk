; 2020-11-09 单独拿出来 封藏使用

; 文字输入提示
IMETip(文字,时间:=-1000){
    if A_CaretX{
      ToolTip, %文字%,A_CaretX,A_CaretY
    } else{
      ToolTip, %文字%
    }
    SetTimer, RemoveIMETip, %时间%
}
RemoveIMETip:
  ToolTip
return

; 2016-8-31
 ;只保留一个输入法 禁用输入法 或开启输入法,停用上面所有的判断
 setCN_1(hwnd){
 	if(!IME_GET())
 	{
 		Send, ^{Space}
 		displayToast( "中","AED900" )
 	}
   Return
 }
 setEN_1(hwnd){
  ;  vime := IME_GET()
  ;  ToolTip %vime%
 	if(IME_GET())
 	{
 		Send, ^{Space}
 		displayToast( "EN","FF2B00" )
 	}
   return
 }

 setIME(hwnd){
 	Send, ^{Space}
 	if(IME_GET())
 	{
 		;此处由于先发送了 ctrl space在进行判断,提示需要换下
 		displayToast( "中","AED900" )
    IMETip("中文")
 	} else {
 		; Send, ^{Space}
 		displayToast( "EN","FF2B00" )
    IMETip("EN")
 	}
 }
Return

If (IME_GET())
	ToolTip,中
else
	ToolTip,EN  ;shift得反着提示，提示切换后的状态。
return

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
; --------------------------------输入法相关-  END-------------