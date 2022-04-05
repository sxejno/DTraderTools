;Last updated 4-04-2022
#SingleInstance, Force
CV = 1.0
;FileCreateDir, %A_ScriptDir%\resources\
;SetWorkingDir, %A_ScriptDir%\resources\


FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\fbn.png, %a_temp%\fbn.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\webull.png, %a_temp%\webull.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\wbcn.png, %a_temp%\wbcn.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\cb.png, %a_temp%\cb.png, 1 
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\cd.png, %a_temp%\cd.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\cnn.png, %a_temp%\cnn.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\gf.png, %a_temp%\gf.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\gp.png, %a_temp%\gp.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\lfalogocustom.png, %a_temp%\lfalogocustom.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\ss.png, %a_temp%\ss.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\st.png, %a_temp%\st.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\fv.png, %a_temp%\fv.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\tr.png, %a_temp%\tr.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\STT.png, %a_temp%\STT.png, 1
FileInstall, C:\Users\Shane\Documents\TraderTools\img_dom\maria.png, %a_temp%\maria.png, 1


/*
FileInstall, img_dom\fbn.png, %A_WorkingDir%\fbn.png, 1
FileInstall, img_dom\webull.png, %A_WorkingDir%\webull.png, 1
FileInstall, img_dom\wbcn.png, %A_WorkingDir%\wbcn.png, 1
FileInstall, img_dom\cb.png, %A_WorkingDir%\cb.png, 1 
FileInstall, img_dom\cd.png, %A_WorkingDir%\cd.png, 1
FileInstall, img_dom\cnn.png, %A_WorkingDir%\cnn.png, 1
FileInstall, img_dom\gf.png, %A_WorkingDir%\gf.png, 1
FileInstall, img_dom\gp.png, %A_WorkingDir%\gp.png, 1
FileInstall, img_dom\lfalogocustom.png, %A_WorkingDir%\lfalogocustom.png, 1
FileInstall, img_dom\ss.png, %A_WorkingDir%\ss.png, 1
FileInstall, img_dom\st.png, %A_WorkingDir%\st.png, 1
FileInstall, img_dom\fv.png, %A_WorkingDir%\fv.png, 1
FileInstall, img_dom\tr.png, %A_WorkingDir%\tr.png, 1
FileInstall, img_dom\STT.png, %A_WorkingDir%\STT.png, 1
FileInstall, img_dom\maria.png, %A_WorkingDir%\maria.png, 1
*/

/*
imgFBN=%A_WorkingDir%\fbn.png
imgWB=%A_WorkingDir%\webull.png
imgCB=%A_WorkingDir%\cb.png
imgCD=%A_WorkingDir%\cd.png
imgCNN=%A_WorkingDir%\cnn.png
imgGF=%A_WorkingDir%\gf.png
imgGP=%A_WorkingDir%\gp.png
imgLFA=%A_WorkingDir%\lfalogocustom.png
imgSS=%A_WorkingDir%\ss.png
imgST=%A_WorkingDir%\st.png
imgFV=%A_WorkingDir%\fv.png
imgTR=%A_WorkingDir%\tr.png
imgSTT=%A_WorkingDir%\STT.png
imgWBCN=%A_WorkingDir%\wbcn.png
imgMaria=%A_WorkingDir%\maria.png
*/

imgMaria=%a_temp%/maria.png
imgFBN=%a_temp%/fbn.png
imgWB=%a_temp%/webull.png
imgWBCN=%a_temp%/wbcn.png
imgCB=%a_temp%/cb.png
imgCD=%a_temp%/cd.png
imgCNN=%a_temp%/cnn.png
imgGF=%a_temp%/gf.png
imgGP=%a_temp%/gp.png
imgLFA=%a_temp%/lfalogocustom.png
imgSS=%a_temp%/ss.png
imgST=%a_temp%/st.png
imgFV=%a_temp%/fv.png
imgTR=%a_temp%/tr.png
imgSTT=%a_temp%/STT.png



URLDownloadToVar(url) {
 WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
 WebRequest.Open("GET", url)
 WebRequest.Send()
 Return, WebRequest.ResponseText
}




accounts = 
(
Charles Schwab|Edward Jones|Chase|Robin Hood|Fundrise
)
I_Icon = %A_WorkingDir%\TraderTools_icons\STT_favicon.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%

;I_Pepe = %A_WorkingDir%\images\pepetrans.png
;IfExist, %I_Pepe%
;Gui, Add, Picture, x2 y9 w470 h420 BackgroundTrans +Border, %I_Pepe%




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
;Gui, Add, Button, x342 y99 w100 h30 , ShortableStocks
Gui, Add, Button, x392 y149 w50 h40 default, OPEN ALL
Gui, Add, Button, x372 y229 w70 h60 , Ultimate List of Market Resources
Gui, Add, DropDownList, x112 y379 w130 h200 vAcct Choose1, %accounts%
Gui, Add, Picture, gFBN x42 y239 w100 h100 vPicFox, %imgFBN%
Gui, Add, Picture, gWB x32 y169 w50 h40 vPicture, %imgWB%
Gui, Add, Picture, gCB x102 y159 w60 h60 , %imgCB%
Gui, Add, Picture, gCD x162 y239 w100 h20 , %imgCD%
Gui, Add, Picture, gCNN x162 y269 w100 h30 , %imgCNN%
Gui, Add, Picture, gGF x162 y309 w100 h30 , %imgGF%
Gui, Add, Picture, gGP x272 y249 w100 h20 , %imgGP%
Gui, Add, Picture, gLFA x282 y289 w140 h50 , %imgLFA%
Gui, Add, Picture, gSS x282 y29 w60 h60 , %imgSS%
Gui, Add, Picture, gST x352 y99 w90 h30 , %imgST%
Gui, Add, Picture, gFV x202 y39 w80 h30 , %imgFV%
Gui, Add, Picture, gTR x202 y89 w140 h50 , %imgTR%
Gui, Add, Picture, gSTT x22 y419 w230 h40 , %imgSTT%


Gui, Add, Button, x422 y429 w20 h20 , ?
Gui, Add, Button, x372 y389 w70 h20 , 200DMA
Gui, Add, Button, x372 y369 w70 h20 , StockRow
;Gui, Add, Button, x302 y369 w70 h20 , unused3
;Gui, Add, Button, x302 y389 w70 h20 , unused4
;Gui, Add, CheckBox, x372 y429 w60 h20 , enhance


; Generated using SmartGUI Creator 4.0
Gui, Show, x878 y358 h461 w479, Shane's Trader Tools
Return

FBN:
GuiControl, -Redraw, PicFox
GuiControl,, PicFox, %imgMaria%
GuiControl, +Redraw, PicFox
KeyWait, LButton, UP
GuiControl, -Redraw, PicFox
GuiControl,, PicFox, %imgFBN%
GuiControl, +Redraw, PicFox
GuiControlGet, ticker
site = https://ustv247.tv/foxbusinesslive/
Run %site%
return 

WB:
GuiControl, -Redraw, Picture
GuiControl,, Picture, %imgWBCN%
GuiControl, +Redraw, Picture
KeyWait, LButton, UP
GuiControl, -Redraw, Picture
GuiControl,, Picture, %imgWB%
GuiControl, +Redraw, Picture
GuiControlGet, ticker
site = https://www.webull.com/
Run %site%
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

LFA:
GuiControlGet, ticker
site = https://www.lazyfa.com/
Run %site%
return

SS:
GuiControlGet, ticker
site = https://swaggystocks.com/dashboard/stocks/terminal/%ticker%
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
MsgBox,4,Update Shane's Trader Tools,Check for update now?, 5
IfMsgBox No
	return
else IfMsgBox Timeout
	return
else IfMsgBox Yes
	NV:= URLDownloadToVar("https://pastebin.com/raw/QL0NgcCM")
	;msgbox % NV
If NV != CV
	MsgBox,4,Update Checker,Your current version is %CV% and the newest version is %NV%.`n`nUpdate Shane's Trader Tools to the newest version now?
IfMsgBox No
	return
IfMsgBox Yes
	MsgBox,,,Saving a copy of this current version to `n%A_ScriptDir%\TraderTools_for_Dom-backup,3
FileMove,%A_ScriptDir%/TraderTools_for_Dom.*,%A_ScriptDir%/TraderTools_for_Dom-backup,1
MsgBox,,,Current version should now be backed up.,3
UrlDownloadToFile,"https://drive.google.com/uc?export=download&id=1tjv5J372sSTd43XuuQfslcKlW3yirAY9",%A_ScriptDir%/TT_for_Dom.ahk
Sleep 5000
Run %A_ScriptDir%\TT_for_Dom.ahk
ExitApp
MsgBox,,,Should be updated! Check the ? button to be sure.,5
If NV == CV
	MsgBox,,Update Checker,Your current version is %CV% and the newest version is %NV%.`n`nShane's Trader Tools is up to date!
return

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

;ButtonShortableStocks:
;GuiControlGet, ticker
;site = https://shortablestocks.com/
;Run %site%
;return

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

ButtonUltimateListofMarketResources:
GuiControlGet, ticker
site = https://github.com/ckz8780/market-toolkit
Run %site%
return

Button200DMA:
GuiControlGet, ticker
site = https://www.yardeni.com/pub/stmkt200dma.pdf
Run %site%
return

Button?:
MsgBox,,Shane's Trader Tools v%CV% - about, Shane's Trader Tools was originally created on 4/04/2022 as a collection of tools that may be helpful for stock and option trading. `n`nThe author of this software accepts no responsibility for damages `nresulting from the use of this product and makes no warranty or representation, either express or implied, including but not limited to, any implied warranty of merchantability or fitness for a particular purpose.`n`nThis software is provided "AS IS", and you, its user, `nassume all risks when using it.`n`n`nCurrent Version: %CV% `n`n`n          © 2022 Kassandra, LLC                   https://kassandra.llc
return

ButtonGo:
Gui,Submit,NoHide
If Acct = Charles Schwab
	Run "https://client.schwab.com/clientapps/accounts/summary/"
If Acct = Edward Jones
	Run "https://edwardjones.com/"
If Acct = Chase
	Run "https://chase.com"
If Acct = Robin Hood
	Run "https://robinhood.com/us/en/"
If Acct = Fundrise
	Run "https://fundrise.com"
return

GuiClose:
ExitApp