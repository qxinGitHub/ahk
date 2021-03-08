; 翻译函数 ; =====================================================
#SingleInstance force

; F5::shuangyu("zh-CN","en")


shuangyu("zh-CN","en")

shuangyu(YuYan_1,YuYan_2){
	Global
	ClipLiShi := ClipboardAll
	Clipboard := ""
	send,^c
	ClipWait, 0.5
	keyword=%Clipboard%
	ZHONG := GoogleTranslate(keyword, , YuYan_1)
	ENGLISH := GoogleTranslate(keyword, , YuYan_2)
	Clipboard := ""
	Clipboard := ClipLiShi
	ClipLiShi := ""
	; Gui_TiShi := ZHONG . "`n<<<->>>`n" . ENGLISH
	Tip_Gui(ZHONG,ENGLISH)
	; ToolTip % ZHONG . "`n<<<->>>`n" . ENGLISH
	Return
}

Tip_Gui(Zh_TS,En_TS){
	Global
	; msgbox % StrLen(Zh_TS) . "===" . StrLen(En_TS)

	If (StrLen(Zh_TS)>=450) or (StrLen(En_TS)>=1500)
	{
		W_0 := "w1500"
	}
	Else If (StrLen(Zh_TS)>=300) or (StrLen(En_TS)>=900)
	{
		W_0 := "w1100"
	}
	Else If (StrLen(Zh_TS)>=150) or (StrLen(En_TS)>=450)
	{
		W_0 := "w700"
	}
	Else
	W_0 := ""

	Gui, FanYi_1:Destroy
	Gui, FanYi_2:Destroy
	Gui, FanYi_1:+ToolWindow +HwndFanYi_A -Caption +AlwaysOnTop border -DPIScale
	Gui, FanYi_1:Color, cDDDDDD
	Gui, FanYi_1:Font, s14 c2D2D2D Q5, 微软雅黑
	Gui, FanYi_1:Margin, 5, 5
	Gui, FanYi_1:Add, Text, %W_0% vZh_Ming gZh_Ming, % Zh_TS
	Gui, FanYi_1:Font, s10 c333333 Q5, 微软雅黑
	Gui, FanYi_1:Add, Text, vFG_Ming gFG_Ming, ------右击此处操作提示------
	Gui, FanYi_1:Font, s14 c2D2D2D Q5, 微软雅黑
	Gui, FanYi_1:Add, Text, %W_0% vEn_Ming gEn_Ming, % En_TS
	CoordMode, Mouse
	MouseGetPos, Mu_XX, Mu_YY
	Gui_XX := Mu_XX+10, Gui_YY := Mu_YY+10
	Gui, FanYi_1:Show, x%Gui_XX% y%Gui_YY%
	JQB_Z := Zh_TS
	JQB_E := En_TS
	return

	FG_Ming:
	PostMessage, 0xA1, 2
	If (A_GuiEvent = "DoubleClick")
	{
		Gui, FanYi_1:Destroy
		Gui, FanYi_2:Destroy
	}
	Return
	Zh_Ming:
	En_Ming:
	Gui, FanYi_1:Destroy
	Gui, FanYi_2:Destroy
	; ExitApp 
	return

	FanYi_1GuiContextMenu:
	; msgbox % A_GuiControl
	If (A_GuiControl = "Zh_Ming")
	{
		clipboard := JQB_Z
		ToolTip, 中文已复制
		SetTimer, Move_TT, -1000
	}
	Else If (A_GuiControl = "En_Ming")
	{
		clipboard := JQB_E
		ToolTip, 英文已复制
		SetTimer, Move_TT, -1000
	}
	Else If (A_GuiControl = "FG_Ming")
	{
		ToolTip, 单击中/英区域关闭提示框`n右击中/英区域复制相应内容到剪切板`n左键拖动中间区域移动提示框，双击关闭提示框
		SetTimer, Move_TT, -3000
	}
	return
}

Move_TT(){
	ToolTip
	return
}


GoogleTranslate(str, from := "auto", to :=0)  {
	static JS := CreateScriptObj(), _ := JS.( GetJScript() ) := JS.("delete ActiveXObject; delete GetObject;")
	if(!to)
	to := GetISOLanguageCode()
	if(from = to)
	Return str
	json := SendRequest(JS, str, to, from, proxy := "")
	oJSON := JS.("(" . json . ")")

	if !IsObject(oJSON[1])  {
	Loop % oJSON[0].length
		trans .= oJSON[0][A_Index - 1][0]
	}
	else  {
	MainTransText := oJSON[0][0][0]
	Loop % oJSON[1].length  {
		trans .= "`n+`n"
		obj := oJSON[1][A_Index-1][1]
		Loop % obj.length  {
			txt := obj[A_Index - 1]
			trans .= (MainTransText = txt ? "" : "/" txt)
		}
	}
}
	if !IsObject(oJSON[1])
	MainTransText := trans := Trim(trans, ",+`n ")
	else
	trans := MainTransText . "`n+`n" . Trim(trans, ",+`n ")

	from := oJSON[2]
	trans := Trim(trans, ",+`n")
	Return trans
}

GetISOLanguageCode(lang := 0) {
	LanguageCodeArray := { 0436: "af" ; Afrikaans
			, 041c: "sq" ; Albanian
			, 0401: "ar" ; Arabic_Saudi_Arabia
			, 0801: "ar" ; Arabic_Iraq
			, 0c01: "ar" ; Arabic_Egypt
			, 1001: "ar" ; Arabic_Libya
			, 1401: "ar" ; Arabic_Algeria
			, 1801: "ar" ; Arabic_Morocco
			, 1c01: "ar" ; Arabic_Tunisia
			, 2001: "ar" ; Arabic_Oman
			, 2401: "ar" ; Arabic_Yemen
			, 2801: "ar" ; Arabic_Syria
			, 2c01: "ar" ; Arabic_Jordan
			, 3001: "ar" ; Arabic_Lebanon
			, 3401: "ar" ; Arabic_Kuwait
			, 3801: "ar" ; Arabic_UAE
			, 3c01: "ar" ; Arabic_Bahrain
			, 042c: "az" ; Azeri_Latin
			, 082c: "az" ; Azeri_Cyrillic
			, 042d: "eu" ; Basque
			, 0423: "be" ; Belarusian
			, 0402: "bg" ; Bulgarian
			, 0403: "ca" ; Catalan
			, 0404: "zh-CN" ; Chinese_Taiwan
			, 0804: "zh-CN" ; Chinese_PRC
			, 0c04: "zh-CN" ; Chinese_Hong_Kong
			, 1004: "zh-CN" ; Chinese_Singapore
			, 1404: "zh-CN" ; Chinese_Macau
			, 041a: "hr" ; Croatian
			, 0405: "cs" ; Czech
			, 0406: "da" ; Danish
			, 0413: "nl" ; Dutch_Standard
			, 0813: "nl" ; Dutch_Belgian
			, 0409: "en" ; English_United_States
			, 0809: "en" ; English_United_Kingdom
			, 0c09: "en" ; English_Australian
			, 1009: "en" ; English_Canadian
			, 1409: "en" ; English_New_Zealand
			, 1809: "en" ; English_Irish
			, 1c09: "en" ; English_South_Africa
			, 2009: "en" ; English_Jamaica
			, 2409: "en" ; English_Caribbean
			, 2809: "en" ; English_Belize
			, 2c09: "en" ; English_Trinidad
			, 3009: "en" ; English_Zimbabwe
			, 3409: "en" ; English_Philippines
			, 0425: "et" ; Estonian
			, 040b: "fi" ; Finnish
			, 040c: "fr" ; French_Standard
			, 080c: "fr" ; French_Belgian
			, 0c0c: "fr" ; French_Canadian
			, 100c: "fr" ; French_Swiss
			, 140c: "fr" ; French_Luxembourg
			, 180c: "fr" ; French_Monaco
			, 0437: "ka" ; Georgian
			, 0407: "de" ; German_Standard
			, 0807: "de" ; German_Swiss
			, 0c07: "de" ; German_Austrian
			, 1007: "de" ; German_Luxembourg
			, 1407: "de" ; German_Liechtenstein
			, 0408: "el" ; Greek
			, 040d: "iw" ; Hebrew
			, 0439: "hi" ; Hindi
			, 040e: "hu" ; Hungarian
			, 040f: "is" ; Icelandic
			, 0421: "id" ; Indonesian
			, 0410: "it" ; Italian_Standard
			, 0810: "it" ; Italian_Swiss
			, 0411: "ja" ; Japanese
			, 0412: "ko" ; Korean
			, 0426: "lv" ; Latvian
			, 0427: "lt" ; Lithuanian
			, 042f: "mk" ; Macedonian
			, 043e: "ms" ; Malay_Malaysia
			, 083e: "ms" ; Malay_Brunei_Darussalam
			, 0414: "no" ; Norwegian_Bokmal
			, 0814: "no" ; Norwegian_Nynorsk
			, 0415: "pl" ; Polish
			, 0416: "pt" ; Portuguese_Brazilian
			, 0816: "pt" ; Portuguese_Standard
			, 0418: "ro" ; Romanian
			, 0419: "ru" ; Russian
			, 081a: "sr" ; Serbian_Latin
			, 0c1a: "sr" ; Serbian_Cyrillic
			, 041b: "sk" ; Slovak
			, 0424: "sl" ; Slovenian
			, 040a: "es" ; Spanish_Traditional_Sort
			, 080a: "es" ; Spanish_Mexican
			, 0c0a: "es" ; Spanish_Modern_Sort
			, 100a: "es" ; Spanish_Guatemala
			, 140a: "es" ; Spanish_Costa_Rica
			, 180a: "es" ; Spanish_Panama
			, 1c0a: "es" ; Spanish_Dominican_Republic
			, 200a: "es" ; Spanish_Venezuela
			, 240a: "es" ; Spanish_Colombia
			, 280a: "es" ; Spanish_Peru
			, 2c0a: "es" ; Spanish_Argentina
			, 300a: "es" ; Spanish_Ecuador
			, 340a: "es" ; Spanish_Chile
			, 380a: "es" ; Spanish_Uruguay
			, 3c0a: "es" ; Spanish_Paraguay
			, 400a: "es" ; Spanish_Bolivia
			, 440a: "es" ; Spanish_El_Salvador
			, 480a: "es" ; Spanish_Honduras
			, 4c0a: "es" ; Spanish_Nicaragua
			, 500a: "es" ; Spanish_Puerto_Rico
			, 0441: "sw" ; Swahili
			, 041d: "sv" ; Swedish
			, 081d: "sv" ; Swedish_Finland
			, 0449: "ta" ; Tamil
			, 041e: "th" ; Thai
			, 041f: "tr" ; Turkish
			, 0422: "uk" ; Ukrainian
			, 0420: "ur" ; Urdu
			, 042a: "vi"} ; Vietnamese
	If(lang)
	Return LanguageCodeArray[lang]
	Else Return LanguageCodeArray[A_Language]
}
SendRequest(JS, str, tl, sl, proxy) {
	ComObjError(false)
	http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	( proxy && http.SetProxy(2, proxy) )
	;~ http.open( "POST", "https://translate.google.com/translate_a/single?client=webapp&sl="
	http.open( "POST", "https://translate.google.cn/translate_a/single?client=webapp&sl="
	. sl . "&tl=" . tl . "&hl=" . tl
	. "&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&ie=UTF-8&oe=UTF-8&otf=0&ssel=0&tsel=0&pc=1&kc=1"
	. "&tk=" . JS.("tk").(str), 1 )

	http.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8")
	http.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0")
	http.send("q=" . URIEncode(str))
	http.WaitForResponse(-1)
	Return http.responsetext
}

URIEncode(str, encoding := "UTF-8")  {
	VarSetCapacity(var, StrPut(str, encoding))
	StrPut(str, &var, encoding)

	While code := NumGet(Var, A_Index - 1, "UChar")  {
	bool := (code > 0x7F || code < 0x30 || code = 0x3D)
	UrlStr .= bool ? "%" . Format("{:02X}", code) : Chr(code)
	}
	Return UrlStr
}

GetJScript()
{
	script =
	(
	var TKK = ((function() {
		var a = 561666268;
		var b = 1526272306;
		return 406398 + '.' + (a + b);
	})());

	function b(a, b) {
		for (var d = 0; d < b.length - 2; d += 3) {
			var c = b.charAt(d + 2),
				c = "a" <= c ? c.charCodeAt(0) - 87 : Number(c),
				c = "+" == b.charAt(d + 1) ? a >>> c : a << c;
			a = "+" == b.charAt(d) ? a + c & 4294967295 : a ^ c
		}
		return a
	}

	function tk(a) {
		for (var e = TKK.split("."), h = Number(e[0]) || 0, g = [], d = 0, f = 0; f < a.length; f++) {
			var c = a.charCodeAt(f);
			128 > c ? g[d++] = c : (2048 > c ? g[d++] = c >> 6 | 192 : (55296 == (c & 64512) && f + 1 < a.length && 56320 == (a.charCodeAt(f + 1) & 64512) ?
			(c = 65536 + ((c & 1023) << 10) + (a.charCodeAt(++f) & 1023), g[d++] = c >> 18 | 240,
			g[d++] = c >> 12 & 63 | 128) : g[d++] = c >> 12 | 224, g[d++] = c >> 6 & 63 | 128), g[d++] = c & 63 | 128)
		}
		a = h;
		for (d = 0; d < g.length; d++) a += g[d], a = b(a, "+-a^+6");
		a = b(a, "+-3^+b+-f");
		a ^= Number(e[1]) || 0;
		0 > a && (a = (a & 2147483647) + 2147483648);
		a `%= 1E6;
		return a.toString() + "." + (a ^ h)
	}
	)
	Return script
}

CreateScriptObj() {
	static doc
	doc := ComObjCreate("htmlfile")
	doc.write("<meta http-equiv='X-UA-Compatible' content='IE=9'>")
	Return ObjBindMethod(doc.parentWindow, "eval")
}




; 00000000000000000000000000000000000000000000000000000000



