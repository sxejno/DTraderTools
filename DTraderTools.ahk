#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; SetBatchLines, -1 ; runs AHK at top speed

; used because #NoEnv is used... this allows the script to get the user's local file path for AppData
EnvGet, A_LocalAppData, LocalAppData

CV = 2.74
LE = Last updated 6/05/2023

last_changes =
	(
	Here's what's new in version %CV%:
	
	* most links should now open in new window
	
	* added "last updated" date for Stuff tool
	
	* made Stuff scrap tool more robust
	
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
	;IniWrite, 0, %A_MyDocuments%\DTraderTools\config.ini, info, changes
}

IniRead, OutputVar, %A_MyDocuments%\DTraderTools\config.ini, info, version
If OutputVar != %CV%
{
	MsgBox,,Updates in version %CV%!, %last_changes%
	IniWrite, %CV%, %A_MyDocuments%\DTraderTools\config.ini, info, version
	IniDelete, %A_MyDocuments%\DTraderTools\config.ini, info, changes
	;IniWrite, %last_changes%, %A_MyDocuments%\DTraderTools\config.ini, info, changes
}

; # of times launched since version 2.0
IniRead, current_count, %A_MyDocuments%\DTraderTools\config.ini, info, times_used
current_count++
IniWrite, %current_count%, %A_MyDocuments%\DTraderTools\config.ini, info, times_used

IfNotExist, %A_MyDocuments%\DTraderTools\backups
{
	FileCreateDir, %A_MyDocuments%\DTraderTools\backups
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                       ;
;                                   images                              ; 
;                                                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imgfavicon:= A_MyDocuments . "\DTraderTools\resources\images\favicon.ico"
imgKASSTRANS:= A_MyDocuments . "\DTraderTools\resources\images\kasstrans.png"
imgMaria:= A_MyDocuments . "\DTraderTools\resources\images\maria.png"
imgFBN:= A_MyDocuments . "\DTraderTools\resources\images\fbn.png"
imgTOS:= A_MyDocuments . "\DTraderTools\resources\images\ToS.png"
imgCB:= A_MyDocuments . "\DTraderTools\resources\images\Coinbase-logo-square-1.png"
imgCD:= A_MyDocuments . "\DTraderTools\resources\images\CoinDesk.png"
imgCNN:= A_MyDocuments . "\DTraderTools\resources\images\cnn.png"
imgGF:= A_MyDocuments . "\DTraderTools\resources\images\gf.png"
imgSR:= A_MyDocuments . "\DTraderTools\resources\images\stuff.png"
imgGP:= A_MyDocuments . "\DTraderTools\resources\images\goldprice.png"
imgST:= A_MyDocuments . "\DTraderTools\resources\images\stocktwits.png"
imgFV:= A_MyDocuments . "\DTraderTools\resources\images\finviz.png"
imgGreeks:= A_MyDocuments . "\DTraderTools\resources\images\greeks.png"
imgTR:= A_MyDocuments . "\DTraderTools\resources\images\tipranks.png"
imgBTV:= A_MyDocuments . "\DTraderTools\resources\images\bbtv.png"
imgChatGPT:= A_MyDocuments . "\DTraderTools\resources\images\gpt.png"
imgSTT:= A_MyDocuments . "\DTraderTools\resources\images\sttlong.png"
imgTF:= A_MyDocuments . "\DTraderTools\resources\images\tru.png"
imgECAL:= A_MyDocuments . "\DTraderTools\resources\images\ecal.png"
imgXO:= A_MyDocuments . "\DTraderTools\resources\images\xo.png"
imgOB:= A_MyDocuments . "\DTraderTools\resources\images\ob.png"
imgcal:= A_MyDocuments . "\DTraderTools\resources\images\cal.png"
imgcalc:= A_MyDocuments . "\DTraderTools\resources\images\calc.png"
imghelp:= A_MyDocuments . "\DTraderTools\resources\images\help.png"
imgrefresh:= A_MyDocuments . "\DTraderTools\resources\images\refresh.png"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     Account names for dropdownlist                                    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

accounts = 
(
Charles Schwab|TDAmeritrade|Nancy Barron|Edward Jones|Chase|Gemini|Kraken|cryptowatch
)

; Set tray icon

try {
	Menu, Tray, Icon, % imgfavicon
	Gui, Add, Picture, x0 y0 h383 w473, %imgKASSTRANS%
	Gui, Add, Text, x12 y19 w70 h30 , Enter Ticker Symbol here:
	Gui, Add, Edit, x82 y19 w100 h30 vticker Uppercase r1
	Gui, Add, Picture, gButtongreeks x352 y49 w80 h30 BackgroundTrans, %imgGreeks%
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
	Gui, Add, Picture, gECAL x380 y229 w60 h60 BackgroundTrans, %imgECAL%
	Gui, Add, DropDownList, x112 y379 w130 h200 vAcct Choose1, %accounts%
	Gui, Add, Picture, gFBN x42 y239 w100 h100 BackgroundTrans vPicFox, %imgFBN%
	Gui, Add, Picture, gToS x32 y169 w50 h40 BackgroundTrans, %imgTOS%
	Gui, Add, Picture, gCB x102 y159 w60 h60 BackgroundTrans, %imgCB%
	Gui, Add, Picture, gCD x162 y239 w100 h20 BackgroundTrans, %imgCD%
	Gui, Add, Picture, gCNN x162 y269 w100 h30 BackgroundTrans, %imgCNN%
	Gui, Add, Picture, gGF x162 y309 w100 h30 BackgroundTrans, %imgGF%
	Gui, Add, Picture, gSR x272 y233 w100 h20 BackgroundTrans, %imgSR%
	Gui, Add, Picture, gGP x272 y259 w100 h20 BackgroundTrans, %imgGP%
	Gui, Add, Picture, gBTV x282 y289 w140 h50 BackgroundTrans, %imgBTV%
	Gui, Add, Picture, gTR x352 y99 w90 h30 BackgroundTrans, %imgTR%
	Gui, Add, Picture, gFV x202 y39 w80 h30 BackgroundTrans, %imgFV%
	Gui, Add, Picture, gST x202 y89 w140 h50 BackgroundTrans, %imgST%
	Gui, Add, Picture, gSTT x22 y495 w230 h40 BackgroundTrans, %imgSTT%
	Gui, Add, Picture, ghelp x422 y505 w20 h20 BackgroundTrans, %imghelp%
	Gui, Add, Picture, grefresh x452 y505 w20 h20 BackgroundTrans, %imgrefresh%
	Gui, Add, Button, x372 y389 w70 h20 , 200DMA
	Gui, Add, Button, x372 y369 w70 h20 , StockRow
	Gui, Add, Button, x302 y369 w70 h20 , OPEC Watch
	Gui, Add, Button, x302 y389 w70 h20 , FedWatch
	;Gui, Add, Link,, This is a <a href="http://ahkscript.org">link</a>
	;Gui, Add, Link,, Links may be used anywhere in the text like <a id="1">this</a> or <a id="2">that</a>
	
	; Add buttons above the help button
	Gui, Add, Picture,gCalendar x22 y429 w64 h64 BackgroundTrans, %imgcal%
	Gui, Add, Picture,gOB x122 y432 w31 h49 BackgroundTrans, %imgOB%
	Gui, Add, Picture,gCalc x182 y429 w64 h64 BackgroundTrans, %imgcalc%
	
	Gui, Add, Picture, gTF x290 y420 w126 h30 BackgroundTrans, %imgTF%
	Gui, Add, Picture, gChatGPT x425 y425 w25 h25 BackgroundTrans, %imgChatGPT%
	Gui, Add, Picture, gXO x425 y450 w50 h50 BackgroundTrans, %imgXO%
	; CODE 2 integration - gradient boxes
	Gui, Add, Link, x290 y453, <a href="https://ycharts.com/indicators/vix_volatility_index">VIX</a>
	Gui, Add, Link, x340 y453, <a href="https://ycharts.com/indicators/cboe_equity_put_call_ratio">PCR</a>
	Gui, Add, Link, x390 y453, <a href="https://www.investing.com/indices/us-spx-500-technical">SP</a>
	
	Gui, Add, Picture, x290 y468 w20 h20 vVIXpic, % vixImage
	Gui, Add, Picture, x340 y468 w20 h20 vPutCallpic, % putCallImage
	Gui, Add, Picture, x390 y468 w20 h20 vSPpic, % sp500RelImage
	Gui, Add, Text, x290 y493 w30 vVIX, % VIXnum
	Gui, Add, Text, x340 y493 w30 vPutCall, % PCRnum
	Gui, Add, Text, x390 y493 w30 vSP, % Round(SP) . "%"
	
	Gui, Font, s8 cGreen Bold, Verdana
	Gui, Add, Text, x290 y510 w100 vGAS, % GASprc
	
	try {
		VIXnum := "..."
		PCRnum := "..."
		GASprc := "...getting gas..."
		value200DMA := 
		valueSP500 :=
		sp500RelValue := "..."
		temppath := A_MyDocuments . "\DTraderTools\resources\temp.txt"
		FileReadLine, VIXnum, %temppath%, 1
		FileReadLine, PCRnum, %temppath%, 2
		FileReadLine, SP, %temppath%, 3	
		FileReadLine, GASprc, %temppath%, 4
	}
	
	; Generated using SmartGUI Creator 4.0
	Gui, Show, x878 y358 h531 w479, Shane's Trader Tools v%CV%
	
} catch {
	Gui, Hide
	ImageFolder := A_MyDocuments . "\DTraderTools\resources\images"
	ImageList := [{"Name": "favicon", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/favicon.ico"},{"Name": "maria", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/maria.png"},{"Name": "fbn", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/fbn.png"},{"Name": "ToS", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/ToS.png"},{"Name": "Coinbase-logo-square-1", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/Coinbase-logo-square-1.png"},{"Name": "CoinDesk", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/CoinDesk.png"},{"Name": "cnn", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/cnn.png"},{"Name": "gf", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/gf.png"},{"Name": "goldprice", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/goldprice.png"},{"Name": "stocktwits", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/stocktwits.png"},{"Name": "finviz", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/finviz.png"},{"Name": "greeks", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/greeks.png"},{"Name": "tipranks", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/tipranks.png"},{"Name": "bbtv", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/bbtv.png"},{"Name": "gpt", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/gpt.png"},{"Name": "sttlong", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/sttlong.png"},{"Name": "help", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/help.png"},{"Name": "kasstrans", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/kasstrans.png"},{"Name": "10", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/10.png"},{"Name": "20", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/20.png"},{"Name": "30", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/30.png"},{"Name": "40", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/40.png"},{"Name": "50", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/50.png"},{"Name": "60", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/60.png"},{"Name": "70", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/70.png"},{"Name": "80", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/80.png"},{"Name": "90", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/90.png"},{"Name": "100", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/100.png"}, {"Name": "ob", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/ob.png"},{"Name": "cal", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/cal.png"},{"Name": "calc", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/calc.png"},{"Name": "tru", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/tru.png"},{"Name": "ecal", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/ecal.png"},{"Name": "xo", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/xo.png"},{"Name": "stuff", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/stuff.png"},{"Name": "refresh", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/refresh.png"}]	
	CheckAndDownloadImages(ImageList, imageFolder)
	Gui, Show
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                       ;
;             Check if there is a new version available                 ; 
;                                                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Add this line at the beginning of your script, right after the initial comments and before any other code
CheckForUpdate:

;GitHubVersionURL := "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/DTraderTools-version.txt"
GitHubVersionURL := "https://pastebin.com/raw/QL0NgcCM"
GitHubScriptURL := "https://raw.githubusercontent.com/sxejno/DTraderTools/main/DTraderTools.ahk"

; Use a Try statement to handle any errors while checking for an update
Try {
	NV := URLDownloadToVar(GitHubVersionURL)
} Catch {
    ; If there's an error checking for an update, proceed with the script
	Goto, StartScript
}

; Check if there is a new version available
If (NV != CV) {
	MsgBox, 4, New version %NV% released!, Your current version is %CV% and the newest version is %NV%.`n`nUpdate Shane's Trader Tools to the newest version now?
	IfMsgBox, No ; "No" button
		Goto, StartScript
	IfMsgBox, Yes ; "Yes" button
	{
        ; Add update process here
		MsgBox,, Current Version Backup, Saving a copy of this current version to `n%A_MyDocuments%\DTraderTools\backups\DTraderTools-backup_v%CV%.ahk, 7
		FileMove, %A_ScriptDir%/DTraderTools.ahk, %A_ScriptDir%/DTraderTools-backup_v%CV%.ahk, 1
		Sleep, 100
		FileMove, %A_ScriptDir%/DTraderTools-backup_v%CV%.ahk, %A_MyDocuments%/DTraderTools/backups/DTraderTools_backup_v%CV%.ahk, 1
		UrlDownloadToFile, %GitHubScriptURL%, %A_ScriptDir%/DTraderTools.ahk
		MsgBox,, Update Checker, Shane's Trader Tools should be updated to version %NV%!, 7
		Run, %A_ScriptDir%\DTraderTools.ahk
		ExitApp
	}
} Else {
	Goto, StartScript
}

; Add a label here to start your script normally when there is no update or the user declines the update
StartScript:
; Your script should continue here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                       ;
;                       check for images                                ; 
;                                                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Check and download missing images
ResourcesFolder := A_MyDocuments . "\DTraderTools\resources"
ImageFolder := A_MyDocuments . "\DTraderTools\resources\images"
ImageList := [{"Name": "favicon", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/favicon.ico"},{"Name": "maria", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/maria.png"},{"Name": "fbn", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/fbn.png"},{"Name": "ToS", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/ToS.png"},{"Name": "Coinbase-logo-square-1", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/Coinbase-logo-square-1.png"},{"Name": "CoinDesk", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/CoinDesk.png"},{"Name": "cnn", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/cnn.png"},{"Name": "gf", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/gf.png"},{"Name": "goldprice", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/goldprice.png"},{"Name": "stocktwits", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/stocktwits.png"},{"Name": "finviz", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/finviz.png"},{"Name": "greeks", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/greeks.png"},{"Name": "tipranks", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/tipranks.png"},{"Name": "bbtv", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/bbtv.png"},{"Name": "gpt", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/gpt.png"},{"Name": "sttlong", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/sttlong.png"},{"Name": "help", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/help.png"},{"Name": "kasstrans", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/kasstrans.png"},{"Name": "10", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/10.png"},{"Name": "20", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/20.png"},{"Name": "30", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/30.png"},{"Name": "40", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/40.png"},{"Name": "50", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/50.png"},{"Name": "60", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/60.png"},{"Name": "70", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/70.png"},{"Name": "80", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/80.png"},{"Name": "90", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/90.png"},{"Name": "100", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/100.png"}, {"Name": "ob", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/ob.png"},{"Name": "cal", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/cal.png"},{"Name": "calc", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/calc.png"},{"Name": "tru", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/tru.png"},{"Name": "ecal", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/ecal.png"},{"Name": "xo", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/xo.png"},{"Name": "stuff", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/stuff.png"},{"Name": "refresh", "URL": "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/refresh.png"}]	


CheckAndDownloadImages(ImageList, imageFolder)

; Create the image folder if it doesn't exist
If !FileExist(ImageFolder)
	FileCreateDir, % ImageFolder

; Download the scrape.ahk script if it doesn't exist in the resources folder
scrapeScriptPath := ResourcesFolder . "\scrape.ahk"
scrapeScriptURL := "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/scrape.ahk" 

If !FileExist(scrapeScriptPath)
	UrlDownloadToFile, % scrapeScriptURL, % scrapeScriptPath
Run % scrapeScriptPath


; Download the DownloadImage.ahk script if it doesn't exist in the resources folder
DownloadImageScriptPath := ResourcesFolder . "\DownloadImage.ahk"
DownloadImageScriptURL := "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/DownloadImage.ahk" 

If !FileExist(DownloadImageScriptPath)
	UrlDownloadToFile, % DownloadImageScriptURL, % DownloadImageScriptPath



; Create an object to store missing images
MissingImages := {}

; Check if images exist, and if not, add them to MissingImages
Loop, % ImageList.MaxIndex() {
	ImageName := ImageList[A_Index].Name
	ImageURL := ImageList[A_Index].URL
	ImagePath := ImageFolder . "\" . ImageName . ".*"
	
	If !FileExist(ImagePath)
		MissingImages.Insert({"Name": ImageName, "URL": ImageURL})
}

; Download missing images concurrently
DownloadScript := A_MyDocuments . "\DTraderTools\resources\DownloadImage.ahk"
Loop, % MissingImages.MaxIndex() {
	ImageName := MissingImages[A_Index].Name
	ImageURL := MissingImages[A_Index].URL
	
	Run, % A_AhkPath . " " . DownloadScript . " " . ImageName . " " . ImageURL . " " . ImageFolder,, UseErrorLevel
}



WatchFolder(folder, event) {
	static handles := {}
	if (!handles[folder]) {
		handles[folder] := DllCall("FindFirstChangeNotification", "Str", folder, "Int", 0, "Int", 0x10)
		if (handles[folder] = -1)
			return false
	}
	if (event)
		OnMessage(0x4E, event)
	else
		OnMessage(0x4E, "")
	return DllCall("FindNextChangeNotification", "Ptr", handles[folder])
}

WatchImagesFolder() {
	WatchFolder(A_MyDocuments . "\DTraderTools\resources\images", "CheckImagesDownloaded")
}




; Function to get VIX gradient image based on input VIX value
GetVIXGradientImage(value) {
	ImageFolder := A_MyDocuments . "\DTraderTools\resources\images\"
	vixThresholds := [13, 19, 28]
	
	if (value <= vixThresholds[2]) {
        ; Calculate the appropriate image between 100 (green) and 60 (yellow) based on the VIX value
		relativeValue := (value - vixThresholds[1]) / (vixThresholds[2] - vixThresholds[1])
		imageIndex := 100 - (40 * relativeValue)
		return ImageFolder . Round(imageIndex / 10) * 10 . ".png" ; Round to the nearest multiple of 10
	}
	else if (value > vixThresholds[2] && value <= vixThresholds[3]) {
        ; Calculate the appropriate image between 60 (yellow) and 10 (red) based on the VIX value
		relativeValue := (value - vixThresholds[2]) / (vixThresholds[3] - vixThresholds[2])
		imageIndex := 60 - (50 * relativeValue)
		return ImageFolder . Round(imageIndex / 10) * 10 . ".png" ; Round to the nearest multiple of 10
	}
	else {
        ; Calculate the appropriate image between 10 (red) and 1 (most red) based on the VIX value
        ; Use a max VIX value to cap the gradient (set it to a high value if you don't want a cap)
		maxVIX := 100
		relativeValue := (value - vixThresholds[3]) / (maxVIX - vixThresholds[3])
		imageIndex := 10 - (9 * relativeValue)
		return ImageFolder . Round(imageIndex / 10) * 10 . ".png" ; Limit the minimum index to 1 (most red)
	}
}

GetPCRGradientImage(value, reverse := false) {
	ImageFolder := A_MyDocuments . "\DTraderTools\resources\images\"
	gradientRange := [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
	
    ; Determine the appropriate value for the gradient variable based on the put/call ratio
	if (value <= 0.7) {
		gradientValue := InterpolateValues(100, 50, value / 0.7)
	} else {
		gradientValue := InterpolateValues(50, 10, (value - 0.7) / 0.3)
	}
	
    ; Round gradientValue to the nearest multiple of 10
	gradientValue := Round(gradientValue / 10) * 10
	
    ; Limit the gradient value to be within the range [10, 100]
	gradientValue := min(max(gradientValue, 10), 100)
	
    ; Construct the file path for the appropriate gradient image
	gradientFileName := gradientValue . ".png"
	gradientFilePath := ImageFolder . gradientFileName
	
	return gradientFilePath
}

InterpolateValues(minValue, maxValue, ratio) {
	return minValue + (maxValue - minValue) * ratio
}


	; Function to get gradient image based on input value and thresholds
GetGradientImage(value, thresholds, reverse := false) {
	ImageFolder := A_MyDocuments . "\DTraderTools\resources\images\"
	for index, threshold in thresholds {
		if (value <= threshold) {
			if (reverse)
				return ImageFolder . ((10 - index) * 10) . ".png"
			else
				return ImageFolder  . (index * 10) . ".png"
		}
	}
	return reverse ? A_MyDocuments . "\DTraderTools\resources\images\10.png" : A_MyDocuments . "\DTraderTools\resources\images\100.png"
}




; Example values (replace these with the actual fetched values)
vixValue = VIXnum
putCallRatio = PCRnum
sp500CurrentValue = valueSP500
sp500_200DMA = value200DMA

; Define thresholds for VIX, Put/Call ratio, and S&P 500 vs. 200 DMA
;vixThresholds := [6, 12, 14, 16, 18, 20, 22, 24, 26]
putCallThresholds := [0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3]
sp500RelThresholds := [-5, -2, -1, -0.5, 0, 1, 0.5, 2, 5]

; Calculate the S&P 500 relationship to its 200 DMA
; sp500RelValue := ((sp500CurrentValue - sp500_200DMA) / sp500_200DMA) * 100

; Get the gradient images for the values
vixImage := 
putCallImage := 
sp500RelImage :=

CheckImagesDownloaded:
; Check if all images have been downloaded
AllImagesDownloaded := true
Loop, % ImageList.MaxIndex() {
	ImageName := ImageList[A_Index].Name
	ImageExt := (ImageName = "favicon") ? ".ico" : ".png"
	ImagePath := ImageFolder . "\" . ImageName . ImageExt
	
	If !FileExist(ImagePath) {
		Gui, Hide
		AllImagesDownloaded := false
		reload
		break
	}
}

if (AllImagesDownloaded) {
	SetTimer, CheckImagesDownloaded, Off
	Menu, Tray, Icon, % imgfavicon
	Gui, Show, x878 y358 h531 w479, Shane's Trader Tools v%CV%
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     Helper to get version number to determine if update is needed     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
; Function to download the script version as a variable
	URLDownloadToVar(url) {
		h := ComObjCreate("WinHttp.WinHttpRequest.5.1")
		h.Open("GET", url, true)
		h.Send()
		h.WaitForResponse()
		return h.ResponseText
	}
	
	; Set a timer to call the FetchAndUpdate label with a delay
	SetTimer, FetchAndUpdate, 100
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
	Run chrome.exe %site% " --new-window "
	return 
	
	ToS:
	If WinExist("Logon to thinkorswim")
		WinActivate
	else If WinExist("Main@thinkorswim")
	{
		SetTitleMatchMode, 2
		If WinExist("thinkorswim")
		{
			WinActivate
		}
	}
	else
	{
		TosPathLocalAppData := A_LocalAppData "\thinkorswim\thinkorswim.exe"
		TosPathProgramFiles := "C:\Program Files\thinkorswim\thinkorswim.exe"
		
		IfExist, %TosPathLocalAppData%
		{
			Run %TosPathLocalAppData%
			WinWait, Logon to thinkorswim
		}
		else IfExist, %TosPathProgramFiles%
		{
			Run %TosPathProgramFiles%
			WinWait, Logon to thinkorswim
		}
		else
		{
			MsgBox, Thinkorswim not found at either %TosPathLocalAppData% or %TosPathProgramFiles%. Please check the installation.
		}
	}
	return
	
	CB:
	GuiControlGet, ticker
	site = https://pro.coinbase.com/trade/BTC-USD
	Run chrome.exe %site% " --new-window "
	return 
	
	CD:
	GuiControlGet, ticker
	site = https://www.coindesk.com/
	Run chrome.exe %site% " --new-window "
	return
	
	CNN:
	GuiControlGet, ticker
	site = https://www.cnn.com/business/markets/premarkets
	Run chrome.exe %site% " --new-window "
	return
	
	GF:
	GuiControlGet, ticker
	site = https://www.google.com/finance/?hl=en
	Run chrome.exe %site% " --new-window "
	return
	
	/* ; old way 
		SR:
	; find python install dir hopefully...
		RunWait, %ComSpec% /c where python > temp.txt,, hide
		FileRead, PythonPath, temp.txt
		FileDelete, temp.txt
		if (PythonPath = "") 
		{
			MsgBox, No compatible version of Python was found. Please install Python 3.8 or later.
			return
		}
		
	; Download the stuff.pyw script if it doesn't exist in the resources folder
		stuffScriptPath := ResourcesFolder "\stuff.pyw"
		stuffScriptURL := "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/stuff.pyw" 
		
	; Download the stuff.pyw script anyway
		UrlDownloadToFile, %stuffScriptURL%, %stuffScriptPath%
		
	;RunWait the Python script
	;RunWait, %ComSpec% /c %PythonPath% %stuffScriptPath%
		
		RunWait, %stuffScriptPath%
		if ErrorLevel != 0
			MsgBox, The Python script encountered an error. Let Shane know.
		return
	*/
	
	SR:
	; find python install dir hopefully...
	Username := A_UserName
	PythonPaths := ["C:\Users\" . Username . "\AppData\Local\Programs\Python\Python312\python.exe", "C:\Users\" . Username . "\AppData\Local\Programs\Python\Python311\python.exe", "C:\Users\" . Username . "\AppData\Local\Programs\Python\Python310\python.exe", "C:\Program Files\Python312\python.exe", "C:\Program Files\Python311\python.exe", "C:\Program Files\Python310\python.exe"]
	PythonPath := ""
	
	; Let's try to find Python in the most common directories.
	For index, path in PythonPaths
	{
		If FileExist(path)
		{
			PythonPath := path
			Break
		}
	}
	
	; If we couldn't find Python in the common directories, let's try to find it using the "where" command.
	if (PythonPath = "")
	{
		RunWait, %ComSpec% /c where python > temp.txt,, hide
		FileRead, PythonPath, temp.txt
		FileDelete, temp.txt
	}
	
	; If we still couldn't find Python, let's show an error message and stop.
	if (PythonPath = "") 
	{
		MsgBox, No compatible version of Python was found. Please install Python 3.10 or later.
		return
	}
	
	; Download the stuff.pyw script if it doesn't exist in the resources folder
	stuffScriptPath := ResourcesFolder "\stuff.pyw"
	stuffScriptURL := "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/stuff.pyw" 
	
	; Download the stuff.pyw script anyway
	UrlDownloadToFile, %stuffScriptURL%, %stuffScriptPath%
	
	; try to run stuff python script different ways
	Try
	{
		; try to run directly
		RunWait, %stuffScriptPath%
		if ErrorLevel != 0
		{
			; if it fails to run directly, we will try to run it with the full python path
			RunWait, %PythonPath% %stuffScriptPath%
			if ErrorLevel != 0
			{
			; If script fails to run directly, try running with 'python' command
				RunWait, %ComSpec% /c python %stuffScriptPath%
				if ErrorLevel != 0
				{
					MsgBox, The Python script returned an error code. Let Shane know.
					return
				}
			}
		}
	}
	Catch
	{
		
		MsgBox, The Python script returned an error code. Let Shane know.
		return
	}
	return
	
	
	
	GP:
	GuiControlGet, ticker
	site = https://goldprice.org/
	Run chrome.exe %site% " --new-window "
	return
	
	BTV:
	GuiControlGet, ticker
	site = https://www.bloomberg.com/live/us/btv
	Run chrome.exe %site% " --new-window "
	return
	
	ChatGPT:
	GuiControlGet, ticker
	site = https://chat.openai.com/chat
	Run chrome.exe %site% " --new-window "
	return
	
	ST:
	GuiControlGet, ticker
	site = https://stocktwits.com/symbol/%ticker%
	Run chrome.exe %site% " --new-window "
	return
	
	FV:
	GuiControlGet, ticker
	site = https://finviz.com/quote.ashx?t=%ticker%
	Run chrome.exe %site% " --new-window "
	return
	
	TR:
	GuiControlGet, ticker
	site = https://www.tipranks.com/stocks/%ticker%
	Run chrome.exe %site% " --new-window "
	return
	
	TF:
	GuiControlGet, ticker
	site = https://truflation.com
	Run chrome.exe %site% " --new-window "
	return
	
	ECAL:
	GuiControlGet, ticker
	site = https://www.marketwatch.com/economy-politics/calendar
	Run chrome.exe %site% " --new-window "
	return
	
	XO:
	GuiControlGet, ticker
	site = https://stockcharts.com/freecharts/pnf.php?c=`%24BTCUSD,PGPADEYRNR[PA][D][F1!3!1.0!!0!20]
	Run chrome.exe %site% " --new-window "
	return
	
	Calendar:
	site = https://calendar.google.com
	Run chrome.exe %site% " --new-window "
	return
	
	Calc:
	Run calc.exe
	return
	
	refresh:
	reload
	return
	
	OB:
	SetTitleMatchMode, 2
	wintit := "Obsidian v"
	IfWinExist, %wintit%
		WinActivate, Obsidian
	else If WinExist("Obsidian v")
	{
		SetTitleMatchMode, 2
		If WinExist("Obsidian v")
		{
			WinActivate
		}
	}
	else
	{
		OBPathLocalAppData := A_LocalAppData "\Obsidian\Obsidian.exe"
		OBPathProgramFiles := "C:\Program Files\Obsidian\Obsidian.exe"
		
		IfExist, %OBPathLocalAppData%
		{
			Run %OBPathLocalAppData%
			WinWaitActive
		}
		else IfExist, %OBPathProgramFiles%
		{
			Run %OBPathProgramFiles%
			WinWaitActive
		}
		else
		{
			MsgBox, Obsidian not found at either %OBPathLocalAppData% or %OBPathProgramFiles%. Please check the installation or download Obsidian.
		}
	}
	return
	
	/*
	; work in progress update to updater that saves a user-specified number of backups	
		STT:
		; Check if config file exists, if not, create it
		IfExist, %A_MyDocuments%\DTraderTools\config.ini
		if ErrorLevel
		{
			FileAppend,, %A_MyDocuments%\DTraderTools\config.ini
			AskUserForBackupNumber()
		}
		
	; Read the backups to keep number from the config file
		IniRead, backupsToKeep, %A_MyDocuments%\DTraderTools\config.ini, Settings, BackupsToKeep
		if backupsToKeep = 
		{
			AskUserForBackupNumber()
		}
		
		if NV != %CV%
		{
			MsgBox, 4, New version %NV% released!, Your current version is %CV% and the newest version is %NV%.`n`nUpdate Shane's Trader Tools to the newest version now?
			
			IfMsgBox No
				return
			IfMsgBox Yes
			{
				MsgBox,, Current Version Backup, Saving a copy of this current version to `n%A_MyDocuments%\DTraderTools\backups\DTraderTools-backup_v%CV%.ahk, 7
				FileMove, %A_ScriptDir%/DTraderTools.ahk, %A_ScriptDir%/DTraderTools-backup_v%CV%.ahk, 1
				Sleep, 100
				FileMove, %A_ScriptDir%/DTraderTools-backup_v%CV%.ahk, %A_MyDocuments%/DTraderTools/backups/DTraderTools_backup_v%CV%.ahk, 1
				DeleteOldBackups(backupsToKeep)
				UrlDownloadToFile, %GitHubScriptURL%, %A_ScriptDir%/DTraderTools.ahk
				MsgBox,, Update Checker, Shane's Trader Tools should be updated to version %NV%!, 7
				Run, %A_ScriptDir%\DTraderTools.ahk
				ExitApp
			}
		}
		else if NV = %CV%
		{
			MsgBox,, Update Checker, Your current version is %CV% and the newest version is %NV%.`n`nShane's Trader Tools is up to date!
		}
		
		AskUserForBackupNumber()
		{
			InputBox, backupsToKeep, Backups to keep, Please enter the number of backups to keep:
			IniWrite, %backupsToKeep%, %A_MyDocuments%\DTraderTools\config.ini, Settings, BackupsToKeep
		}
		
		DeleteOldBackups(backupsToKeep)
		{
    ; Loop through the backup files and delete the oldest ones if they exceed the limit
			FileList =
			Loop, %A_MyDocuments%\DTraderTools\backups\*.ahk
			{
				FileList = %FileList%%A_LoopFileName%`n
			}
			
			Sort, FileList, D`n ; Sort by date modified, oldest first
			
			Loop, Parse, FileList, `n
			{
				If (A_Index > backupsToKeep)
				{
					FileDelete, %A_MyDocuments%\DTraderTools\backups\%A_LoopField%
				}
			}
		}
		return
	*/
	
	
	
	
	
	STT:
	MsgBox, 4, Update Shane's Trader Tools, Check for update now?, 5
	
	IfMsgBox No
	{
		MsgBox, 4, Feature Request & Bug Reporting, Want to REQUEST A FEATURE or REPORT A BUG?
		IfMsgBox Yes
			Run, https://forms.gle/Apubmtc1cmbhpSu59
		else IfMsgBox No
			return
	}
	else IfMsgBox Timeout
	{
		return
	}
	else IfMsgBox Yes
	{
		GitHubVersionURL := "https://pastebin.com/raw/QL0NgcCM"
		GitHubScriptURL := "https://raw.githubusercontent.com/sxejno/DTraderTools/main/DTraderTools.ahk"
		NV := URLDownloadToVar(GitHubVersionURL)
		
		if NV != %CV%
		{
			MsgBox, 4, New version %NV% released!, Your current version is %CV% and the newest version is %NV%.`n`nUpdate Shane's Trader Tools to the newest version now?
			
			IfMsgBox No
				return
			IfMsgBox Yes
			{
				MsgBox,, Current Version Backup, Saving a copy of this current version to `n%A_MyDocuments%\DTraderTools\backups\DTraderTools-backup_v%CV%.ahk, 7
				FileMove, %A_ScriptDir%/DTraderTools.ahk, %A_ScriptDir%/DTraderTools-backup_v%CV%.ahk, 1
				Sleep, 100
				FileMove, %A_ScriptDir%/DTraderTools-backup_v%CV%.ahk, %A_MyDocuments%/DTraderTools/backups/DTraderTools_backup_v%CV%.ahk, 1
				UrlDownloadToFile, %GitHubScriptURL%, %A_ScriptDir%/DTraderTools.ahk
				MsgBox,, Update Checker, Shane's Trader Tools should be updated to version %NV%!, 7
				Run, %A_ScriptDir%\DTraderTools.ahk
				ExitApp
			}
		}
		else if NV = %CV%
		{
			MsgBox,, Update Checker, Your current version is %CV% and the newest version is %NV%.`n`nShane's Trader Tools is up to date!
		}
	}
	return
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     Button controls                                                   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	Buttongreeks:
	GuiControlGet, ticker
	site = https://www.barchart.com/stocks/quotes/%ticker%/volatility-greeks
	Run chrome.exe %site% " --new-window "
	return
	
	ButtonTradingView:
	GuiControlGet, ticker
	site = https://www.tradingview.com/chart/?symbol=%ticker%
	Run chrome.exe %site% " --new-window "
	return
	
	ButtonStockCharts:
	GuiControlGet, ticker
	site = https://stockcharts.com/h-sc/ui?s=%ticker%
	Run chrome.exe %site% " --new-window "
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
	Run chrome.exe %site% " --new-window "
	return
	
	ButtonOptionsTrackerSheet:
	GuiControlGet, ticker
	site = https://docs.google.com/spreadsheets/d/1e75HlZs9G4v0jcpHkvtl4NiBjv_iJa7pvm4sMiF4qzM/
	Run chrome.exe %site% " --new-window "
	return
	
	ButtonOptionsProfitCalculator:
	GuiControlGet, ticker
	site = https://www.optionsprofitcalculator.com/
	Run chrome.exe %site% " --new-window "
	return
	
	ButtonStockRow:
	GuiControlGet, ticker
	site = https://stockrow.com/
	Run chrome.exe %site% " --new-window "
	return
	
	ButtonBloombergLiveTV:
	GuiControlGet, ticker
	site = https://www.bloomberg.com/live/us/btv
	Run chrome.exe %site% " --new-window "
	return
	
	Button200DMA:
	GuiControlGet, ticker
	site = https://www.yardeni.com/pub/stmkt200dma.pdf
	Run chrome.exe %site% " --new-window "
	return
	
	ButtonFedWatch:
	GuiControlGet, ticker
	site = https://www.cmegroup.com/trading/interest-rates/countdown-to-fomc.html
	Run chrome.exe %site% " --new-window "
	return
	
	ButtonOPECWatch:
	GuiControlGet, ticker
	site = https://www.cmegroup.com/trading/energy/cme-opec-watch-tool.html
	Run chrome.exe %site% " --new-window "
	return	
	
	help:
	MsgBox,,Shane's Trader Tools v%CV% - about, Shane's Trader Tools was originally created on April 4th, 2022 as a collection of tools that may be helpful for stock/option trading. `n`nThe author of this software accepts no responsibility for damages `nresulting from the use of this product and makes no warranty or representation, either express or implied, including but not limited to, any implied warranty of merchantability or fitness for a particular purpose.`n`nThis software is provided "AS IS", and you, its user, `nassume all risks when using it.`n`nYou have opened this program: %current_count% times`n`nCurrent Version: %CV%`n`n%LE% `n`n%last_changes%`n`n`n          © 2022-2023 Kassandra, LLC                   https://kassandra.llc
	return
	
	ButtonGo:
	Gui,Submit,NoHide
	If Acct = Charles Schwab
		Run "https://client.schwab.com/clientapps/accounts/summary/"
	If Acct = TDAmeritrade
		Run "https://www.tdameritrade.com/"
	If Acct = Nancy Barron
		Run "https://www.mystreetscape.com/login/access/investor-index.html"
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
	
	FetchAndUpdate:
	try {
		sleep 100
		VIXnum := "..."
		PCRnum := "..."
		value200DMA := 
		valueSP500 :=
		sp500RelValue := "..."
		temppath := A_MyDocuments . "\DTraderTools\resources\temp.txt"
		FileRead, fileContent, %temppath%
		FileReadLine, VIXnum, %temppath%, 1
		FileReadLine, PCRnum, %temppath%, 2
		FileReadLine, SP, %temppath%, 3
		FileReadLine, GASprc, %temppath%, 4
	}
	
	; Get the gradient images for the values
	vixImage := GetVIXGradientImage(VIXnum)
	putCallImage := GetPCRGradientImage(PCRnum)
	sp500RelImage := GetGradientImage(Round(SP), sp500RelThresholds)
	
	
    ; Update the GUI text with the obtained values
	
	GuiControl,, PutCall, %PCRnum%
	GuiControl,, VIX, %VIXnum%
	GuiControl,, SP, %SP%
	GuiControl,, VIXpic, %vixImage%
	GuiControl,, PutCallpic, %putCallImage%
	GuiControl,, SPpic, %sp500RelImage%
	GuiControl,, GAS, $%GASprc% gas
	
	; Stop the timer after updating the GUI text
	SetTimer, FetchAndUpdate, Off
	return
	
	
; Function to check and download images
	CheckAndDownloadImages(imageFiles, imageFolder) {
    ; Check if the folder exists, create it if it doesn't
		if !FileExist(imageFolder) {
			FileCreateDir, %imageFolder%
		}
		
		for index, imageFile in imageFiles {
        ; Check if the image file exists
			if !FileExist(imageFolder . imageFile) {
            ; Download the image file if it doesn't exist
            ; Replace the URL below with the actual URL where your images are hosted
				imageURL := "https://raw.githubusercontent.com/sxejno/DTraderTools/main/resources/images/" . imageFile
				error := URLDownloadToFile, %imageURL%, %imageFolder%%imageFile%
				
				
            ; Handle download errors
				if (error != 0) {
					MsgBox, 48, Image Download Error, An error occurred while downloading %imageFile%. Error code: %error%
				}
			}
		}
	}
	
	return
}