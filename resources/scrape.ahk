; scrape.ahk

; Code for scraping Put/Call Ratio 
PCR_url := "https://ycharts.com/indicators/cboe_equity_put_call_ratio"
httpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
httpObj.Open("GET", PCR_url)
httpObj.Send()
response := httpObj.ResponseText
pattern := "(\d+\.\d+)\s+for\s+(\w+\s+\d+\s+\d+)"
RegExMatch(response, pattern, result)
PutCallRatio := Trim(result)

; Code for scraping average gas price
GAS_url := "https://ycharts.com/indicators/us_gas_price"
httpObj2 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
httpObj2.Open("GET", GAS_url)
httpObj2.Send()
response2 := httpObj2.ResponseText
pattern2 := "(\d+\.\d+(?=\sUSD/gal for Wk))"
RegExMatch(response2, pattern2, result2)
GAS := Trim(result2)

; Code for scraping average oil price
OIL_url := "https://ycharts.com/indicators/average_crude_oil_spot_price"
httpObj3 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
httpObj3.Open("GET", OIL_url)
httpObj3.Send()
response3 := httpObj3.ResponseText
pattern3 := "(\d+\.\d+(?=\sUSD/bbl for ))"
RegExMatch(response3, pattern3, result3)
OIL := Trim(result3)

;alternate way of getting BTC price.... more out of date than using googlefinance
/*
; Code for scraping btc price
BTC_url := "https://ycharts.com/indicators/bitcoin_price"
httpObj4 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
httpObj4.Open("GET", BTC_url)
httpObj4.Send()
response4 := httpObj4.ResponseText
pattern4 := "(\d+\.\d+(?=\sUSD for ))"
RegExMatch(response4, pattern4, result4)
BTC := Trim(result4)
*/

; Code for scraping VIX
VIX_url := "https://ycharts.com/indicators/vix_volatility_index"
httpObj5 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
httpObj5.Open("GET", VIX_url)
httpObj5.Send()
response5 := httpObj5.ResponseText
pattern5 := "(\d+\.\d+)\s+for\s+(\w+\s+\d+\s+\d+)"
RegExMatch(response5, pattern5, result5)
VIX := Trim(result5)

; Code for scraping 200 DMA from spreadsheet
200DMA_url := "https://docs.google.com/spreadsheets/d/1Wz02gvjyN-al5gULvqXyXGIrrgl1S6cMYL9cJEHGrVc/export?format=csv"
httpObj6 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
httpObj6.Open("GET", 200DMA_url, false)
httpObj6.Send()
csvData := httpObj6.ResponseText
; Parse the first two values from the A column in the CSV data (A1 and A2)
Loop, Parse, csvData, `n, `r
{
		StringSplit, rowData, A_LoopField, `,
		if (A_Index = 1)
			value200DMA := rowData1
		else if (A_Index = 2)
		{
			valueSP500 := rowData1
			break
		}
}

; get btc from spreadsheet
Loop, Parse, csvData, `n, `r
{
	StringSplit, rowData, A_LoopField, `,
	if (A_Index = 1)
		BTC2 := rowData1
	else if (A_Index = 9)
	{
		BTC := rowData1
		break
	}
}

newsp500RelValue := ((valueSP500 - value200DMA) / valueSP500) * 100
newsp500RelValue := Round(newsp500RelValue) . "%"
RegExMatch(PutCallRatio, "(\d+\.\d+)", PCRnum)
RegExMatch(VIX, "(\d+\.\d+)", VIXnum)
RegExMatch(GAS, "(\d+\.\d+)", GASprc)
RegExMatch(OIL, "(\d+\.\d+)", OIL)
RegExMatch(BTC, "(\d+\.\d+)", BTC)
ResourcesFolder := A_MyDocuments . "\DTraderTools\resources\"
FileDelete, %ResourcesFolder%temp.txt
FileAppend, %VIXnum%`n%PCRnum%`n%newsp500RelValue%`n%GASprc%`n%OIL%`n%BTC%, %ResourcesFolder%temp.txt
ExitApp
