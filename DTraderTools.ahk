#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


CV = 2.4
LE = Last updated 3/17/2023

last_changes =
	(
	Here's what's new in version %CV%:
	
	* removed embedded images
	
	* updated logos
	
	* rearranged some icons

	)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         INI CHECKER/CREATOR - VERSION CHECKER - SHOW LAST CHANGES     ;
;  this checks for config.ini file (creates one if doesn't exist) and   ; 
;  compares the version number and if different, shows last changes     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

If !FileExist(A_MyDocuments "\DTraderTools\config.ini"){
	FileCreateDir, %A_MyDocuments%\DTraderTools\
	IniWrite, 0, %A_MyDocuments%\DTraderTools\config.ini, info, version
	IniWrite, 0, %A_MyDocuments%\DTraderTools\config.ini, info, times_used
}

IniRead, OutputVar, %A_MyDocuments%\DTraderTools\config.ini, info, version
If OutputVar != %CV%
	MsgBox,,Updates in version %CV%!, %last_changes%
IniWrite, %CV%, %A_MyDocuments%\DTraderTools\config.ini, info, version
IniWrite, %last_changes%, %A_MyDocuments%\DTraderTools\config.ini, info, changes

; # of times launched since version 2.0
IniRead, current_count, %A_MyDocuments%\DTraderTools\config.ini, info, times_used
current_count++
IniWrite, %current_count%, %A_MyDocuments%\DTraderTools\config.ini, info, times_used

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                       ;
;                                   images                              ; 
;                                                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Set the folder name and URL for images
ImageFolder := A_MyDocuments . "\DTraderTools\resources\images"
ImageList := [{"Name": "stt", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/stt.png"},{"Name": "maria", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/maria.png"},{"Name": "fbn", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/fbn.png"},{"Name": "ToS", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/ToS.png"},{"Name": "Coinbase-logo-square-1", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/Coinbase-logo-square-1.png"},{"Name": "CoinDesk", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/CoinDesk.png"},{"Name": "cnn", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/cnn.png"},{"Name": "gf", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/gf.png"},{"Name": "goldprice", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/goldprice.png"},{"Name": "stocktwits", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/stocktwits.png"},{"Name": "finviz", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/finviz.png"},{"Name": "tipranks", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/tipranks.png"},{"Name": "bbtv", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/bbtv.png"},{"Name": "gpt", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/gpt.png"},{"Name": "sttlong", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/sttlong.png"},{"Name": "help", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/help.png"}]

; Check if the folder exists, if not, create it
If !FileExist(ImageFolder)
    FileCreateDir, % ImageFolder

; Download images if they don't exist in the folder
Loop, % ImageList.MaxIndex() {
    ImageName := ImageList[A_Index].Name
    ImageURL := ImageList[A_Index].URL
    ImagePath := ImageFolder . "\" . ImageName . ".png"
    If !FileExist(ImagePath)
        UrlDownloadToFile, % ImageURL, % ImagePath
}


imgfavicon:= A_MyDocuments . "\DTraderTools\resources\images\stt.png"
Menu, Tray, Icon, % imgfavicon

imgMaria:= A_MyDocuments . "\DTraderTools\resources\images\maria.png"
imgFBN:= A_MyDocuments . "\DTraderTools\resources\images\fbn.png"
imgTOS:= A_MyDocuments . "\DTraderTools\resources\images\ToS.png"
imgCB:= A_MyDocuments . "\DTraderTools\resources\images\Coinbase-logo-square-1.png"
imgCD:= A_MyDocuments . "\DTraderTools\resources\images\CoinDesk.png"
imgCNN:= A_MyDocuments . "\DTraderTools\resources\images\cnn.png"
imgGF:= A_MyDocuments . "\DTraderTools\resources\images\gf.png"
imgGP:= A_MyDocuments . "\DTraderTools\resources\images\goldprice.png"
imgST:= A_MyDocuments . "\DTraderTools\resources\images\stocktwits.png"
imgFV:= A_MyDocuments . "\DTraderTools\resources\images\finviz.png"
imgTR:= A_MyDocuments . "\DTraderTools\resources\images\tipranks.png"
imgBTV:= A_MyDocuments . "\DTraderTools\resources\images\bbtv.png"
imgChatGPT:= A_MyDocuments . "\DTraderTools\resources\images\gpt.png"
imgSTT:= A_MyDocuments . "\DTraderTools\resources\images\sttlong.png"
imghelp:= A_MyDocuments . "\DTraderTools\resources\images\help.png"
;imgKASSLOGO:= A_MyDocuments . "\DTraderTools\resources\images\kass.png"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     Helper to get version number to determine if update is needed     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

URLDownloadToVar(url) {
	WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	WebRequest.Open("GET", url)
	WebRequest.Send()
	Return, WebRequest.ResponseText
}



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     Account names for dropdownlist                                    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

accounts = 
(
Charles Schwab|Gemini|Edward Jones|Chase|Kraken|cryptowatch
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     GUI stuff                                                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Gui, Add, Text, x12 y19 w70 h30 , Enter Ticker Symbol here:
Gui, Add, Edit, x82 y19 w100 h30 vticker Uppercase r1
Gui, Add, Button, x352 y49 w80 h30 , greeks
Gui, Add, GroupBox, x22 y219 w430 h130 , Useful stuff:
Gui, Add, Button, x22 y129 w150 h30 , Options Profit Calculator
Gui, Add, Button, x22 y59 w70 h60 , Dollar Cost Average
Gui, Add, Button, x102 y59 w70 h60 , Options Tracker sheet
Gui, Add, Button, x302 y159 w70 h30 , StockCharts
Gui, Add, Button, x212 y159 w80 h30 , TradingView
Gui, Add, GroupBox, x192 y19 w260 h190 , View Ticker on:
Gui, Add, GroupBox, x202 y139 w180 h60 , Charting:
Gui, Add, GroupBox, x342 y29 w100 h60 , Options:
Gui, Add, GroupBox, x22 y359 w430 h60 , Accounts:
Gui, Add, Text, x32 y379 w120 h20 , View Account:
Gui, Add, Button, x252 y379 w40 h20 , Go
Gui, Add, Button, x392 y149 w50 h40 default, OPEN ALL
Gui, Add, Picture, gChatGPT x372 y229 w70 h60 , %imgChatGPT%
Gui, Add, DropDownList, x112 y379 w130 h200 vAcct Choose1, %accounts%
Gui, Add, Picture, gFBN x42 y239 w100 h100 vPicFox, %imgFBN%
Gui, Add, Picture, gToS x32 y169 w50 h40 vPicture, %imgTOS%
Gui, Add, Picture, gCB x102 y159 w60 h60 , %imgCB%
Gui, Add, Picture, gCD x162 y239 w100 h20 , %imgCD%
Gui, Add, Picture, gCNN x162 y269 w100 h30 , %imgCNN%
Gui, Add, Picture, gGF x162 y309 w100 h30 , %imgGF%
Gui, Add, Picture, gGP x272 y249 w100 h20 , %imgGP%
Gui, Add, Picture, gBTV x282 y289 w140 h50 , %imgBTV%
Gui, Add, Picture, gTR x352 y99 w90 h30 , %imgTR%
Gui, Add, Picture, gFV x202 y39 w80 h30 , %imgFV%
Gui, Add, Picture, gST x202 y89 w140 h50 , %imgST%
Gui, Add, Picture, gSTT x22 y419 w230 h40 , %imgSTT%
Gui, Add, Picture, ghelp x422 y429 w20 h20 , %imghelp%
Gui, Add, Button, x372 y389 w70 h20 , 200DMA
Gui, Add, Button, x372 y369 w70 h20 , StockRow
Gui, Add, Button, x302 y369 w70 h20 , OPEC Watch
Gui, Add, Button, x302 y389 w70 h20 , FedWatch
;Gui, Add, Picture, x878 y358 h461 w479, %imgKASSLOGO%
;Gui, Add, CheckBox, x372 y429 w60 h20 , enhance


; Generated using SmartGUI Creator 4.0
Gui, Show, x878 y358 h461 w479, Shane``s Trader Tools v%CV%

; the two lines below make the background transparent when uncommentted
;Gui, 1: Color, 000001
;WinSet, TransColor, 000001
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     "Button" (Picture) Controls                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FBN:
GuiControl, -Redraw, PicFox
GuiControl,, PicFox, %imgMaria%
GuiControl, +Redraw, PicFox
KeyWait, LButton, UP
GuiControl, -Redraw, PicFox
GuiControl,, PicFox, %imgFBN%
GuiControl, +Redraw, PicFox
GuiControlGet, ticker
site = https://www.newslive.com/business/fox-business-network-fbn.html
Run %site%
return 

ToS:
If WinExist("Logon to thinkorswim")
	WinActivate
else If WinExist("Main@thinkorswim")
{
		; this is supposed to find the thinkorswim taskbar icon as it appears for me in Windows 10
	Text:="|<ToS_icon>*109$24.zzVzzzXzzzXzzzXzzvbzzXbzzXjDzliDztg7zxsTzalzzXzzzbsDzxwDznyTz6LzwAHzkQNzkwMzlzwTtzwDzzyTzzyzU"
	
	if ok:=FindText(1006,1060,150000,150000,0,0,Text)
	{
		CoordMode, Mouse
		X:=ok.1, Y:=ok.2, W:=ok.3, H:=ok.4, Comment:=ok.5
		MouseMove, X+W//2, Y+H//2
		Click
	}
	
		; this is supposed to find the thinkorswim taskbar icon as it appears for me in Windows 11
	Text2:="|<ToS_icon11>*113$35.zz1UTDzzz0zzzzy3zzzzw7zzzzsDzzzzkzzzzzVzzzzz3zzzwyDzzzkwTzzz1tzTzy3nwTzy3bkzzy7D0zzzCw1zzzBkDzzjT3zzz7QTzzy7vzzzw7zzzzvzU3zzzzkDzztzsTzzXPszzwCvxz"
	
	if ok:=FindText(1093,1039,150000,150000,0,0,Text2)
	{
		CoordMode, Mouse
		X:=ok.1, Y:=ok.2, W:=ok.3, H:=ok.4, Comment:=ok.5
		MouseMove, X+W//2, Y+H//2
		Click
	}
}
else IfExist, C:\Program Files\thinkorswim\thinkorswim.exe
{
	Run "C:\Program Files\thinkorswim\thinkorswim.exe"
	WinWait,Logon to thinkorswim
}
else
{
	IfExist, C:\Users\Shane\AppData\Local\thinkorswim\thinkorswim.exe
	Try
	{
		Run "C:\Users\Shane\AppData\Local\thinkorswim\thinkorswim.exe"
		WinWait,Logon to thinkorswim
	}
}
return

CB:
GuiControlGet, ticker
site = https://pro.coinbase.com/trade/BTC-USD
Run %site%
return 

CD:
GuiControlGet, ticker
site = https://www.coindesk.com/
Run %site%
return

CNN:
GuiControlGet, ticker
site = https://www.cnn.com/business/markets/premarkets
Run %site%
return

GF:
GuiControlGet, ticker
site = https://www.google.com/finance/?hl=en
Run %site%
return

GP:
GuiControlGet, ticker
site = https://goldprice.org/
Run %site%
return

BTV:
GuiControlGet, ticker
site = https://www.bloomberg.com/live/us/btv
Run %site%
return

ChatGPT:
GuiControlGet, ticker
site = https://chat.openai.com/chat
Run %site%
return

ST:
GuiControlGet, ticker
site = https://stocktwits.com/symbol/%ticker%
Run %site%
return

FV:
GuiControlGet, ticker
site = https://finviz.com/quote.ashx?t=%ticker%
Run %site%
return

TR:
GuiControlGet, ticker
site = https://www.tipranks.com/stocks/%ticker%
Run %site%
return

STT:
MsgBox,4,Update Shane``s Trader Tools,Check for update now?, 5
IfMsgBox No
	return
else IfMsgBox Timeout
	return
else IfMsgBox Yes
	NV:= URLDownloadToVar("https://pastebin.com/raw/QL0NgcCM")
If NV != %CV%
	MsgBox,4,New version %NV% released!,Your current version is %CV% and the newest version is %NV%.`n`nUpdate Shane``s Trader Tools to the newest version now?
IfMsgBox No
	return
IfMsgBox Yes
	MsgBox,,Current Version Backup,Saving a copy of this current version to `n%A_MyDocuments%\DTraderTools\DTraderTools-backup.ahk,7
FileMove,%A_ScriptDir%/DTraderTools.ahk,%A_ScriptDir%/DTraderTools-backup.ahk,1
Sleep 100
FileMove,%A_ScriptDir%/DTraderTools-backup.ahk,%A_MyDocuments%/DTraderTools/DTraderTools_backup.ahk,1
UrlDownloadToFile,https://raw.githubusercontent.com/sxejno/DTraderTools/main/DTraderTools.ahk,%A_ScriptDir%/DTraderTools.ahk
MsgBox,,Update Checker,Shane``s Trader Tools should be updated to version %NV%!,7
Run %A_ScriptDir%\DTraderTools.ahk
ExitApp
If NV == %CV%
	MsgBox,,Update Checker,Your current version is %CV% and the newest version is %NV%.`n`nShane``s Trader Tools is up to date!
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     Button controls                                                   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Buttongreeks:
GuiControlGet, ticker
site = https://www.barchart.com/stocks/quotes/%ticker%/volatility-greeks
Run %site%
return

ButtonTradingView:
GuiControlGet, ticker
site = https://www.tradingview.com/chart/?symbol=%ticker%
Run %site%
return

ButtonStockCharts:
GuiControlGet, ticker
site = https://stockcharts.com/h-sc/ui?s=%ticker%
Run %site%
return

ButtonOpenAll:
Run chrome.exe "https://schwab.com/" " --new-window "
GuiControlGet, ticker
site = https://www.barchart.com/stocks/quotes/%ticker%/volatility-greeks
Sleep 250
Run chrome.exe %site% " --new-tab "
site2 = https://stocktwits.com/symbol/%ticker%
Sleep 250
Run chrome.exe %site2% " --new-tab "
site3 = https://www.tipranks.com/stocks/%ticker%
Sleep 250
Run chrome.exe %site3% " --new-tab "
site4 = https://finviz.com/quote.ashx?t=%ticker%
Sleep 250
Run chrome.exe %site4% " --new-tab "
return

ButtonDollarCostAverage:
GuiControlGet, ticker
site = https://percentagetools.com/dollar-cost-average-calculator/
Run %site%
return

ButtonOptionsTrackerSheet:
GuiControlGet, ticker
site = https://docs.google.com/spreadsheets/d/1e75HlZs9G4v0jcpHkvtl4NiBjv_iJa7pvm4sMiF4qzM/
Run %site%
return

ButtonOptionsProfitCalculator:
GuiControlGet, ticker
site = https://www.optionsprofitcalculator.com/
Run %site%
return

ButtonStockRow:
GuiControlGet, ticker
site = https://stockrow.com/
Run %site%
return

ButtonBloombergLiveTV:
GuiControlGet, ticker
site = https://www.bloomberg.com/live/us/btv
Run %site%
return

Button200DMA:
GuiControlGet, ticker
site = https://www.yardeni.com/pub/stmkt200dma.pdf
Run %site%
return

ButtonFedWatch:
GuiControlGet, ticker
site = https://www.cmegroup.com/trading/interest-rates/countdown-to-fomc.html
Run %site%
return

ButtonOPECWatch:
GuiControlGet, ticker
site = https://www.cmegroup.com/trading/energy/cme-opec-watch-tool.html
Run %site%
return


help:
MsgBox,,Shane's Trader Tools v%CV% - about, Shane's Trader Tools was originally created on 4/04/2022 as a collection of tools that may be helpful for stock and option trading. `n`nThe author of this software accepts no responsibility for damages `nresulting from the use of this product and makes no warranty or representation, either express or implied, including but not limited to, any implied warranty of merchantability or fitness for a particular purpose.`n`nThis software is provided "AS IS", and you, its user, `nassume all risks when using it.`n`n`nCurrent Version: %CV%`n`n%LE% `n`n%last_changes%`n`n`n          © 2022-2023 Kassandra, LLC                   https://kassandra.llc
return

ButtonGo:
Gui,Submit,NoHide
If Acct = Charles Schwab
	Run "https://client.schwab.com/clientapps/accounts/summary/"
If Acct = Edward Jones
	Run "https://edwardjones.com/"
If Acct = Chase
	Run "https://chase.com"
If Acct = Gemini
	Run "https://gemini.com"
If Acct = Kraken
	Run "https://kraken.com"
If Acct = cryptowatch
	Run "https://cryptowat.ch/"
return

GuiClose:
ExitApp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     FindText stuff                                                    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;===== Copy The Following Functions To Your Own Code Just once =====


; Note: parameters of the X,Y is the center of the coordinates,
; and the W,H is the offset distance to the center,
; So the search range is (X-W, Y-H)-->(X+W, Y+H).
; err1 is the character "0" fault-tolerant in percentage.
; err0 is the character "_" fault-tolerant in percentage.
; Text can be a lot of text to find, separated by "|".
; ruturn is a array, contains the X,Y,W,H,Comment results of Each Find.

FindText(x,y,w,h,err1,err0,text)
{
	xywh2xywh(x-w,y-h,2*w+1,2*h+1,x,y,w,h)
	if (w<1 or h<1)
		return, 0
	bch:=A_BatchLines
	SetBatchLines, -1
  ;--------------------------------------
	GetBitsFromScreen(x,y,w,h,Scan0,Stride,bits)
  ;--------------------------------------
	sx:=0, sy:=0, sw:=w, sh:=h, arr:=[]
	Loop, 2 {
		Loop, Parse, text, |
		{
			v:=A_LoopField
			IfNotInString, v, $, Continue
				Comment:="", e1:=err1, e0:=err0
    ; You Can Add Comment Text within The <>
			if RegExMatch(v,"<([^>]*)>",r)
				v:=StrReplace(v,r), Comment:=Trim(r1)
    ; You can Add two fault-tolerant in the [], separated by commas
			if RegExMatch(v,"\[([^\]]*)]",r)
			{
				v:=StrReplace(v,r), r1.=","
				StringSplit, r, r1, `,
				e1:=r1, e0:=r2
			}
			StringSplit, r, v, $
			color:=r1, v:=r2
			StringSplit, r, v, .
			w1:=r1, v:=base64tobit(r2), h1:=StrLen(v)//w1
			if (r0<2 or h1<1 or w1>sw or h1>sh or StrLen(v)!=w1*h1)
				Continue
    ;--------------------------------------------
			if InStr(color,"-")
			{
				r:=e1, e1:=e0, e0:=r, v:=StrReplace(v,"1","_")
				v:=StrReplace(StrReplace(v,"0","1"),"_","0")
			}
			mode:=InStr(color,"*") ? 1:0
			color:=RegExReplace(color,"[*\-]") . "@"
			StringSplit, r, color, @
			color:=Round(r1), n:=Round(r2,2)+(!r2)
			n:=Floor(255*3*(1-n)), k:=StrLen(v)*4
			VarSetCapacity(ss, sw*sh, Asc("0"))
			VarSetCapacity(s1, k, 0), VarSetCapacity(s0, k, 0)
			VarSetCapacity(rx, 8, 0), VarSetCapacity(ry, 8, 0)
			len1:=len0:=0, j:=sw-w1+1, i:=-j
			ListLines, Off
			Loop, Parse, v
			{
				i:=Mod(A_Index,w1)=1 ? i+j : i+1
				if A_LoopField
					NumPut(i, s1, 4*len1++, "int")
				else
					NumPut(i, s0, 4*len0++, "int")
			}
			ListLines, On
			e1:=Round(len1*e1), e0:=Round(len0*e0)
    ;--------------------------------------------
			if PicFind(mode,color,n,Scan0,Stride,sx,sy,sw,sh
      ,ss,s1,s0,len1,len0,e1,e0,w1,h1,rx,ry)
			{
				rx+=x, ry+=y
				arr.Push(rx,ry,w1,h1,Comment)
			}
		}
		if (arr.MaxIndex())
			Break
		if (A_Index=1 and err1=0 and err0=0)
			err1:=0.05, err0:=0.05
		else Break
	}
	SetBatchLines, %bch%
	return, arr.MaxIndex() ? arr:0
}

PicFind(mode, color, n, Scan0, Stride
  , sx, sy, sw, sh, ByRef ss, ByRef s1, ByRef s0
  , len1, len0, err1, err0, w, h, ByRef rx, ByRef ry)
{
	static MyFunc
	if !MyFunc
	{
		x32:="5589E583EC408B45200FAF45188B551CC1E20201D08945F"
    . "48B5524B80000000029D0C1E00289C28B451801D08945D8C74"
    . "5F000000000837D08000F85F00000008B450CC1E81025FF000"
    . "0008945D48B450CC1E80825FF0000008945D08B450C25FF000"
    . "0008945CCC745F800000000E9AC000000C745FC00000000E98"
    . "A0000008B45F483C00289C28B451401D00FB6000FB6C02B45D"
    . "48945EC8B45F483C00189C28B451401D00FB6000FB6C02B45D"
    . "08945E88B55F48B451401D00FB6000FB6C02B45CC8945E4837"
    . "DEC007903F75DEC837DE8007903F75DE8837DE4007903F75DE"
    . "48B55EC8B45E801C28B45E401D03B45107F0B8B55F08B452C0"
    . "1D0C600318345FC018345F4048345F0018B45FC3B45240F8C6"
    . "AFFFFFF8345F8018B45D80145F48B45F83B45280F8C48FFFFF"
    . "FE9A30000008B450C83C00169C0E803000089450CC745F8000"
    . "00000EB7FC745FC00000000EB648B45F483C00289C28B45140"
    . "1D00FB6000FB6C069D02B0100008B45F483C00189C18B45140"
    . "1C80FB6000FB6C069C04B0200008D0C028B55F48B451401D00"
    . "FB6000FB6C06BC07201C83B450C730B8B55F08B452C01D0C60"
    . "0318345FC018345F4048345F0018B45FC3B45247C948345F80"
    . "18B45D80145F48B45F83B45280F8C75FFFFFF8B45242B45488"
    . "3C0018945488B45282B454C83C00189454C8B453839453C0F4"
    . "D453C8945D8C745F800000000E9E3000000C745FC00000000E"
    . "9C70000008B45F80FAF452489C28B45FC01D08945F48B45408"
    . "945E08B45448945DCC745F000000000EB708B45F03B45387D2"
    . "E8B45F08D1485000000008B453001D08B108B45F401D089C28"
    . "B452C01D00FB6003C31740A836DE001837DE00078638B45F03"
    . "B453C7D2E8B45F08D1485000000008B453401D08B108B45F40"
    . "1D089C28B452C01D00FB6003C30740A836DDC01837DDC00783"
    . "08345F0018B45F03B45D87C888B551C8B45FC01C28B4550891"
    . "08B55208B45F801C28B45548910B801000000EB2990EB01908"
    . "345FC018B45FC3B45480F8C2DFFFFFF8345F8018B45F83B454"
    . "C0F8C11FFFFFFB800000000C9C25000"
		x64:="554889E54883EC40894D10895518448945204C894D288B4"
    . "5400FAF45308B5538C1E20201D08945F48B5548B8000000002"
    . "9D0C1E00289C28B453001D08945D8C745F000000000837D100"
    . "00F85000100008B4518C1E81025FF0000008945D48B4518C1E"
    . "80825FF0000008945D08B451825FF0000008945CCC745F8000"
    . "00000E9BC000000C745FC00000000E99A0000008B45F483C00"
    . "24863D0488B45284801D00FB6000FB6C02B45D48945EC8B45F"
    . "483C0014863D0488B45284801D00FB6000FB6C02B45D08945E"
    . "88B45F44863D0488B45284801D00FB6000FB6C02B45CC8945E"
    . "4837DEC007903F75DEC837DE8007903F75DE8837DE4007903F"
    . "75DE48B55EC8B45E801C28B45E401D03B45207F108B45F0486"
    . "3D0488B45584801D0C600318345FC018345F4048345F0018B4"
    . "5FC3B45480F8C5AFFFFFF8345F8018B45D80145F48B45F83B4"
    . "5500F8C38FFFFFFE9B60000008B451883C00169C0E80300008"
    . "94518C745F800000000E98F000000C745FC00000000EB748B4"
    . "5F483C0024863D0488B45284801D00FB6000FB6C069D02B010"
    . "0008B45F483C0014863C8488B45284801C80FB6000FB6C069C"
    . "04B0200008D0C028B45F44863D0488B45284801D00FB6000FB"
    . "6C06BC07201C83B451873108B45F04863D0488B45584801D0C"
    . "600318345FC018345F4048345F0018B45FC3B45487C848345F"
    . "8018B45D80145F48B45F83B45500F8C65FFFFFF8B45482B859"
    . "000000083C0018985900000008B45502B859800000083C0018"
    . "985980000008B45703945780F4D45788945D8C745F80000000"
    . "0E90B010000C745FC00000000E9EC0000008B45F80FAF45488"
    . "9C28B45FC01D08945F48B85800000008945E08B85880000008"
    . "945DCC745F000000000E9800000008B45F03B45707D368B45F"
    . "04898488D148500000000488B45604801D08B108B45F401D04"
    . "863D0488B45584801D00FB6003C31740A836DE001837DE0007"
    . "8778B45F03B45787D368B45F04898488D148500000000488B4"
    . "5684801D08B108B45F401D04863D0488B45584801D00FB6003"
    . "C30740A836DDC01837DDC00783C8345F0018B45F03B45D80F8"
    . "C74FFFFFF8B55388B45FC01C2488B85A000000089108B55408"
    . "B45F801C2488B85A80000008910B801000000EB2F90EB01908"
    . "345FC018B45FC3B85900000000F8C05FFFFFF8345F8018B45F"
    . "83B85980000000F8CE6FEFFFFB8000000004883C4405DC390"
		MCode(MyFunc, A_PtrSize=8 ? x64:x32)
	}
	return, DllCall(&MyFunc, "int",mode
    , "uint",color, "int",n, "ptr",Scan0, "int",Stride
    , "int",sx, "int",sy, "int",sw, "int",sh
    , "ptr",&ss, "ptr",&s1, "ptr",&s0
    , "int",len1, "int",len0, "int",err1, "int",err0
    , "int",w, "int",h, "int*",rx, "int*",ry)
}

xywh2xywh(x1,y1,w1,h1,ByRef x,ByRef y,ByRef w,ByRef h)
{
	SysGet, zx, 76
	SysGet, zy, 77
	SysGet, zw, 78
	SysGet, zh, 79
	left:=x1, right:=x1+w1-1, up:=y1, down:=y1+h1-1
	left:=left<zx ? zx:left, right:=right>zx+zw-1 ? zx+zw-1:right
	up:=up<zy ? zy:up, down:=down>zy+zh-1 ? zy+zh-1:down
	x:=left, y:=up, w:=right-left+1, h:=down-up+1
}

GetBitsFromScreen(x,y,w,h,ByRef Scan0,ByRef Stride,ByRef bits)
{
	VarSetCapacity(bits,w*h*4,0), bpp:=32
	Scan0:=&bits, Stride:=((w*bpp+31)//32)*4
	Ptr:=A_PtrSize ? "UPtr" : "UInt", PtrP:=Ptr . "*"
	win:=DllCall("GetDesktopWindow", Ptr)
	hDC:=DllCall("GetWindowDC", Ptr,win, Ptr)
	mDC:=DllCall("CreateCompatibleDC", Ptr,hDC, Ptr)
  ;-------------------------
	VarSetCapacity(bi, 40, 0), NumPut(40, bi, 0, "int")
	NumPut(w, bi, 4, "int"), NumPut(-h, bi, 8, "int")
	NumPut(1, bi, 12, "short"), NumPut(bpp, bi, 14, "short")
  ;-------------------------
	if hBM:=DllCall("CreateDIBSection", Ptr,mDC, Ptr,&bi
    , "int",0, PtrP,ppvBits, Ptr,0, "int",0, Ptr)
	{
		oBM:=DllCall("SelectObject", Ptr,mDC, Ptr,hBM, Ptr)
		DllCall("BitBlt", Ptr,mDC, "int",0, "int",0, "int",w, "int",h
      , Ptr,hDC, "int",x, "int",y, "uint",0x00CC0020|0x40000000)
		DllCall("RtlMoveMemory","ptr",Scan0,"ptr",ppvBits,"ptr",Stride*h)
		DllCall("SelectObject", Ptr,mDC, Ptr,oBM)
		DllCall("DeleteObject", Ptr,hBM)
	}
	DllCall("DeleteDC", Ptr,mDC)
	DllCall("ReleaseDC", Ptr,win, Ptr,hDC)
}

base64tobit(s)
{
	ListLines, Off
	Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    . "abcdefghijklmnopqrstuvwxyz"
	SetFormat, IntegerFast, d
	StringCaseSense, On
	Loop, Parse, Chars
	{
		i:=A_Index-1, v:=(i>>5&1) . (i>>4&1)
      . (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
		s:=StrReplace(s,A_LoopField,v)
	}
	StringCaseSense, Off
	s:=SubStr(s,1,InStr(s,"1",0,0)-1)
	s:=RegExReplace(s,"[^01]+")
	ListLines, On
	return, s
}

bit2base64(s)
{
	ListLines, Off
	s:=RegExReplace(s,"[^01]+")
	s.=SubStr("100000",1,6-Mod(StrLen(s),6))
	s:=RegExReplace(s,".{6}","|$0")
	Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    . "abcdefghijklmnopqrstuvwxyz"
	SetFormat, IntegerFast, d
	Loop, Parse, Chars
	{
		i:=A_Index-1, v:="|" . (i>>5&1) . (i>>4&1)
      . (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
		s:=StrReplace(s,v,A_LoopField)
	}
	ListLines, On
	return, s
}

ASCII(s){
	if RegExMatch(s,"(\d+)\.([\w+/]{3,})",r)
	{
		s:=RegExReplace(base64tobit(r2),".{" r1 "}","$0`n")
		s:=StrReplace(StrReplace(s,"0","_"),"1","0")
	}
	else s=
		return, s
}

MCode(ByRef code, hex){
	ListLines, Off
	bch:=A_BatchLines
	SetBatchLines, -1
	VarSetCapacity(code, StrLen(hex)//2)
	Loop, % StrLen(hex)//2
		NumPut("0x" . SubStr(hex,2*A_Index-1,2), code, A_Index-1, "char")
	Ptr:=A_PtrSize ? "UPtr" : "UInt"
	DllCall("VirtualProtect", Ptr,&code, Ptr
    ,VarSetCapacity(code), "uint",0x40, Ptr . "*",0)
	SetBatchLines, %bch%
	ListLines, On
}

; You can put the text library at the beginning of the script, and Use Pic(Text,1) to add the text library to Pic()'s Lib,
; Use Pic("comment1|comment2|...") to get text images from Lib
Pic(comments, add_to_Lib=0) {
	static Lib:=[]
	if (add_to_Lib)
	{
		re:="<([^>]*)>[^$]+\$\d+\.[\w+/]{3,}"
		Loop, Parse, comments, |
			if RegExMatch(A_LoopField,re,r)
				Lib[Trim(r1)]:=r
	}
	else
	{
		text:=""
		Loop, Parse, comments, |
			text.="|" . Lib[Trim(A_LoopField)]
		return, text
	}
}
return

Specify_Area:
run FindText_get_coordinates.ahk
return

