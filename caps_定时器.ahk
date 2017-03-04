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

;从剪贴板输入到界面
;三个参数 后两个可选,分别是前后空格
sendbyclip(var_string,left=0,right=0){
    ClipboardOld := ClipboardAll
    Clipboard = %var_string%
	ClipWait
	loop,%left%{
		Send, {space}
	}
    send ^v
    Loop,%right%{
    	send,{Space}
    }
    Sleep 100
    Clipboard := ClipboardOld  ; Restore previous contents of clipboard.
    ClipboardOld = ;若原文件过大的情况下可以释放内存
}


;弹窗提示
  ;msg 弹窗消息,
  ;color 字体颜色(可选,默认白色 #fff);
  ;fontsize 弹窗字体大小(可选 默认32号字体大小),
  ;time 弹窗持续时间(可选,默认1.5秒)
  ;font 将要显示的字体
;; 字体找不到好看的。。
; displayToast(msg,color="ffffff",fontSize=32,time=-1500,fontFamily="楷书"){
; 	;弹窗 Gui 命名为 MyGui,防止与监控消息冲突
; 	Gui,MyGui: Destroy
; 	Gui,MyGui: +LastFound +AlwaysOnTop +Disabled -SysMenu  -Caption +Owner  ; +Owner 避免显示任务栏按钮.
; 	Gui,MyGui:Font,s%fontSize% c%color% bold  ,%fontFamily%
; 	Gui,MyGui:Color,272822  ; sublime 底色
; 	Gui,MyGui: Add, Text,, %msg%
; 	;设定窗口透明度 右上位置坐标为X1600 Y50
; 	;WinSet, TransColor, 000  200
; 	Gui,MyGui: Show,xcenter y900  NoActivate, Title of Window  ; NoActivate 让当前活动窗口继续保持活动状态.
; 	;sleep 3000
; 	;time 负值表示计时器只运行一次
; 	SetTimer, destroyDisplay,%time%
; 	;Return
; }
; destroyDisplay:
; 	Gui,MyGui:Destroy
; 	return
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
  Gui,testGui: +LastFound +AlwaysOnTop +Disabled -SysMenu  -Caption +Owner  ; +Owner 避免显示任务栏按钮.
  Gui,testGui:Font,s%fontSize% c%FontColor% bold  ,%fontFamily%
  Gui,testGui:Color,272822  ; sublime 底色
  Gui,testGui: Add, Text,, %msg%
  ;设定窗口透明度 右上位置坐标为X1600 Y50
  ;WinSet, TransColor, 000  200
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
; 接受一个参数bool值  若为假,窗口变透明 
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
    	; 此处写成俩函数, 纯粹是因为看着乱
        opacityUp(opacityValue)
    }else{
        opacityDown(opacityValue)
    }
    Return
}
opacityUp(opacityValue){
    opacityValue += 5
    if(opacityValue >=255){
        displayToast("透明:关闭","#0f0",24)
    }else{
        WinSet, Transparent,%opacityValue%
        opacityValue := opacityValue*100 // 255
        displayToast("透明: " . opacityValue . "%","#ff0",24)
    }
    Return
}
opacityDown(opacityValue){
    opacityValue -= 5
    ;禁止完全透明
    if(opacityValue<150){
          displayToast("透明值过小"+opacityValue,"#f00",24)
      }else{
          WinSet, Transparent,%opacityValue% ;顺序不能颠倒,否则变透明的是下面的提示框
          opacityValue := opacityValue*100 // 255  ; 和这一行换顺序,会导致透明纸设置错误
          displayToast("透明: " . opacityValue . "%","#ff0",24) ; 换顺序 会导致透明提示框
    }
    Return
}

Return


; 进制转换

; 十进制 十六进制转换
hex2dec(h)
{
SetFormat, integer, dec
d :=h+0
return %d% 
} 
;十进制转换为十六进制的函数，参数为10进制数整数.
dec2hex(d)
{
SetFormat, integer, hex
h :=d+0
SetFormat, integer, dec ;恢复至正常的10进制计算习惯
h := substr(h,3)  ; 去掉十六进制前面的 ox
return h
}

; candy Lite  candy轻量版  快捷菜单
Label_Candy_Start:
    MouseGetPos,,,Candy_CurWin_id         ;当前鼠标下的进程ID
    WinGet, Candy_CurWin_Fullpath,ProcessPath,Ahk_ID %Candy_CurWin_id%    ;当前进程的路径
    WinGetTitle, Candy_Title,Ahk_ID %Candy_CurWin_id%    ;当前进程的标题
    Candy_Saved_ClipBoard := ClipboardAll
    Clipboard =
    Send, ^c
    ClipWait,0.5
    If ( ErrorLevel  )          ;如果没有选择到什么东西，则退出
    {
        Clipboard := Candy_Saved_ClipBoard    ;还原粘贴板
        Candy_Saved_ClipBoard =
        Return
    }
    Candy_isFile := DllCall("IsClipboardFormatAvailable", "UInt", 15)   ;是否是文件类型
    Candy_isHtml := DllCall("RegisterClipboardFormat", "str", "HTML Format")  ;是否Html类型
    CandySel=%Clipboard%
    CandySel_Rich:=ClipboardAll
    Clipboard := Candy_Saved_ClipBoard  ;还原粘贴板
    Candy_Saved_ClipBoard = 

    If(Fileexist(CandySel) && RegExMatch(CandySel,"^(\\\\|.:\\)")) ;文件或者文件夹,不再支持相对路径的文件路径,但容许“文字模式的全路径”
    {
        Candy_isFile:=1     ;如果是“文字型”的有效路径，强制认定为文件
        SplitPath,CandySel,CandySel_FileNameWithExt,CandySel_ParentPath,CandySel_Ext,CandySel_FileNameNoExt,CandySel_Drive
        SplitPath,CandySel_ParentPath,CandySel_ParentName,,,, ;用这个提取“所在文件夹名”
        If InStr(FileExist(CandySel), "D")  ;区分是否文件夹,Attrib= D ,则是文件夹
        {
            CandySel_FileNameNoExt:=CandySel_FileNameWithExt
            CandySel_Ext:=RegExMatch(CandySel,"^.:\\$") ? "Drive":"Folder"  ;细分：盘符或者文件夹
        }
        Else  If (CandySel_Ext="")       ;若不是文件夹，且无后缀，则定义为NoExt
        {
            CandySel_Ext:="NoExt"
        }
        if (CandySel_ParentName="")
            CandySel_ParentName:=RTrim(CandySel_Drive,":")
    }
    Else if(instr(CandySel,"`n") And  Candy_isFile=1)  ;如果包含多行，且粘贴板性质为文件，则是“多文件”
    {
        CandySel_Ext:="MultiFiles" ;多文件的后缀=MultiFiles
        CandySel_FirstFile:=RegExReplace(CandySel,"(.*)\r.*","$1")  ;取第一行
        SplitPath ,CandySel_FirstFile,,CandySel_ParentPath,,  ;以第一行的父目录为“多文件的父目录”
        If RegExMatch(CandySel_ParentPath,"\:(|\\)$")  ;如果父目录是磁盘根目录,用盘符做父目录名。
            CandySel_ParentName:= RTrim(CandySel_ParentPath,":")
        else  ;否则，提取父目录名
            CandySel_ParentName:= RegExReplace(CandySel_ParentPath, ".*\\(.*)$", "$1")
    }
    Else     ;文本类型
    {
        CandySel_Ext:=StrLen(CandySel) < 80 ? "ShortText" : "LongText" ;区分长短文本
    }
  Return

extension:
  img_ext :="png|jpg|jpeg|gif|tiff|tif|psd|ico"
  text_ext :="txt|ini|py|html|css|js|ahk|md"
  if Candy_isFile{
      if RegExMatch(img_ext, CandySel_Ext){
        ; MsgBox, 图片`n%CandySel%`n%CandySel_Ext%`n %CandySel_ParentPath%
        Run, C:\Program Files\Adobe\Adobe Photoshop CC 2015.5\Photoshop.exe %CandySel%
      }else if RegExMatch(text_ext, CandySel_Ext){
        ; MsgBox, 文档
        Run, C:\Program Files\Sublime Text 3\sublime_text.exe %CandySel%
      }else if Instr(CandySel_Ext, "MultiFiles"){
            Run C:\Programs\autohotkey\Candy-master\plugins\Bulk Rename Utility\Bulk Rename Utility.exe %CandySel_ParentPath% 
        }else{
            Send, {alt Down}
            Send, {Enter}
            Send, {alt Up}
        }

  }else{
      ; MsgBox, 文本  ;%CandySel%
      if RegExMatch(CandySel,"((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+",mUrl){
            ; todo: 只能匹配第一个  后续的所有均忽略掉
            ;((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+  ;无限匹配 简单粗暴
            ;(https?://)?([\da-z\.-]+)\.([a-z\.]{2,6})([/\w \.-\?]*)*/? ;无法匹配汉字以及一些标点符号
            ; MsgBox, %mUrl% ;连接
            ; Run, ColorPicker_win.exe% col, C:\Programs\autohotkey\plugins
            run %mUrl%
        } else if RegExMatch(CandySel, "(0x|#){1}([a-f\d]){6}",mCol){ ;match color 匹配颜色
            ; MsgBox, % mCol
            mCol := "C:\Programs\autohotkey\plugins\ColorPicker_win.exe " . SubStr(mCol, 2) . "ff"
            MsgBox, % mCol
            Run, % mCol
        } else if RegExMatch(CandySel, "\((?P<col1>25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\,(?P<col2>25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\,(?P<col3>25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\)",mCol){
            mCol := "ColorPicker_win.exe " . (dec2hex(mColcol1)dec2hex(mColcol2)dec2hex(mColcol3)) . "ff" ; RGB格式的颜色
            Run, % mCol, C:\Programs\autohotkey\plugins
            ; MsgBox, % mCol
        }else if RegExMatch(CandySel,"\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}",mMail){
            ; MsgBox, %mEmail% ;邮箱地址
            Clipboard := mMail
            displayToast(mMail,"ffff00",24,-3000)
        }else if RegExMatch(CandySel,"0?(13|14|15|18)[0-9]{9}",mPhone){
            ; MsgBox, %mPhone% ;大陆手机号码
            Clipboard := mPhone
            displayToast(mPhone,"ffff00",24,-3000)
        }else if RegExMatch(CandySel,"(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)",mIP){
            ; MsgBox, %mIP% ;ip地址
            Clipboard := mIP
            displayToast(mIP,"ffff00",24,-3000)
        ; }else if RegExMatch(CandySel,"(HKCU|HKCR|HKCC|HKU|HKLM|HKEY_CLASSES_ROOT|HKEY_CURRENT_USER|HKEY_LOCAL_MACHINE|HKEY_USERS|HKEY_CURRENT_CONFIG)\\",mReg){
            ; MsgBox, %mReg% ;注册表地址
            Clipboard := mReg
            displayToast(mReg,"ffff00",24,-3000)
        }
  }

Return