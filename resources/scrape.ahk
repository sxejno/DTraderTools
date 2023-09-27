; scrape.ahk
; Version: 3.0
; This script scrapes various financial data from different websites.
; It is a helper script for Shane's Trader Tools - https://github.com/sxejno/DTraderTools

; Initialize variables for logging
logFile := A_MyDocuments . "\DTraderTools\log.txt"

; Function to append log
Log(msg) {
    FileAppend, %A_Now% - %msg%`n, %logFile%
}

; Initialize Resources Folder
ResourcesFolder := A_MyDocuments . "\DTraderTools\resources\"

; Function to scrape data
ScrapeData(url, pattern, ByRef result) {
    try {
        httpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        httpObj.Open("GET", url)
        httpObj.Send()
        response := httpObj.ResponseText
        RegExMatch(response, pattern, result)
        return true
    } catch {
        Log("Error while scraping " . url)
        return false
    }
}

; Scrape Put/Call Ratio
if (ScrapeData("https://ycharts.com/indicators/cboe_equity_put_call_ratio", "(\d+\.\d+)\s+for\s+(\w+\s+\d+\s+\d+)", PCR))
    RegExMatch(PCR, "(\d+\.\d+)", PCRnum)

; Scrape Average Gas Price
if (ScrapeData("https://ycharts.com/indicators/us_gas_price", "(\d+\.\d+(?=\sUSD/gal for Wk))", GAS))
    RegExMatch(GAS, "(\d+\.\d+)", GASprc)

; Scrape Average Oil Price
if (ScrapeData("https://ycharts.com/indicators/average_crude_oil_spot_price", "(\d+\.\d+(?=\sUSD/bbl for ))", OIL))
    RegExMatch(OIL, "(\d+\.\d+)", OILprc)

; Scrape VIX
if (ScrapeData("https://ycharts.com/indicators/vix_volatility_index", "(\d+\.\d+)\s+for\s+(\w+\s+\d+\s+\d+)", VIX))
    RegExMatch(VIX, "(\d+\.\d+)", VIXnum)

; Scrape Data from Google Spreadsheet
try {
    httpObj6 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    httpObj6.Open("GET", "https://docs.google.com/spreadsheets/d/1Wz02gvjyN-al5gULvqXyXGIrrgl1S6cMYL9cJEHGrVc/export?format=csv", false)
    httpObj6.Send()
    csvData := httpObj6.ResponseText
    
    ; Initialize variables to check if both values have been found
    found200DMA := false
    foundBTC := false

    ; Parse Google Spreadsheet CSV data
    Loop, Parse, csvData, `n, `r
    {
        StringSplit, rowData, A_LoopField, `,
        if (A_Index = 1) {
            value200DMA := rowData1
            found200DMA := true
        } else if (A_Index = 2) {
            valueSP500 := rowData1
        } else if (A_Index = 9) {
            BTC := rowData1
            foundBTC := true
        }
        
        ; Exit loop if both values have been found
        if (found200DMA && foundBTC)
            break
    }
    
    ; Calculate new S&P 500 relative value
    newsp500RelValue := ((valueSP500 - value200DMA) / valueSP500) * 100
    newsp500RelValue := Round(newsp500RelValue) . "%"

    ; Write to temp.txt
    FileDelete, %ResourcesFolder%temp.txt
    FileAppend, %VIXnum%`n%PCRnum%`n%newsp500RelValue%`n%GASprc%`n%OILprc%`n%BTC%, %ResourcesFolder%temp.txt
    
} catch {
    Log("Error while processing Google Spreadsheet data.")
}

; Exit the script
ExitApp
