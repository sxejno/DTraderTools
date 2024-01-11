#NoTrayIcon
#SingleInstance, Force
;created January 10, 2024

; Create GUI with ListView
Gui, Add, ListView, r15 vMyListView gItemClicked, Ticker|Fee|Fund Name|URL

; Add items to the ListView
LV_Add("", "GBTC","1.5%", "Grayscale Bitcoin Trust", "https://www.cnbc.com/quotes/GBTC")
LV_Add("", "ARKB","0.21%", "ARK 21Shares Bitcoin ETF", "https://www.cnbc.com/quotes/ARKB")
LV_Add("", "BITB","0.20%", "Bitwise Bitcoin ETP Trust", "https://www.cnbc.com/quotes/BITB")
LV_Add("", "IBIT","0.25%", "BlackRock's iShares Bitcoin Trust", "https://www.cnbc.com/quotes/IBIT")
LV_Add("", "BTCO","0.39%", "Invesco Galaxy Bitcoin ETF", "https://www.cnbc.com/quotes/BTCO")
LV_Add("", "HODL","0.25%", "VanEck Bitcoin Trust", "https://www.cnbc.com/quotes/HODL")
LV_Add("", "BTCW","0.30%", "WisdomTree Bitcoin Trust", "https://www.cnbc.com/quotes/BTCW")
LV_Add("", "FBTC","0.25%", "Fidelity Wise Origin Bitcoin Trust", "https://www.cnbc.com/quotes/FBTC")
LV_Add("", "BRRR","0.49%", "Valkyrie Bitcoin Fund", "https://www.cnbc.com/quotes/BRRR")
LV_Add("", "EZBC","0.29%", "Franklin Bitcoin ETF", "https://www.cnbc.com/quotes/EZBC")
LV_Add("", "DEFI","0.90%", "Hashdex Bitcoin Futures ETF", "https://www.cnbc.com/quotes/DEFI")
; ... add more items as needed

; Modify column widths
LV_ModifyCol(1, "Auto")  ; Auto-size first column based on content
LV_ModifyCol(2, "Auto")  ; Auto-size second column based on content
LV_ModifyCol(3, "Auto")  ; Auto-size third column based on content

; Show GUI
Gui, Show, w300 h300, Bitcoin ETFs
return

; Define action for item click
ItemClicked:
if (A_GuiEvent = "DoubleClick") {
    LV_GetText(url, A_EventInfo, 4) ; Get URL from the fourth column
    if (url != "") {
        Run, % url ; Open the URL in the default browser
    }
}
return

GuiClose:
ExitApp
