; scrape.ahk
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

; Code for scraping VIX
VIX_url := "https://ycharts.com/indicators/vix_volatility_index"
httpObj2 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
httpObj2.Open("GET", VIX_url)
httpObj2.Send()
response2 := httpObj2.ResponseText
pattern2 := "(\d+\.\d+)\s+for\s+(\w+\s+\d+\s+\d+)"
RegExMatch(response2, pattern2, result2)
VIX := Trim(result2)
200DMA_url := "https://docs.google.com/spreadsheets/d/1Wz02gvjyN-al5gULvqXyXGIrrgl1S6cMYL9cJEHGrVc/export?format=csv"
httpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
httpObj.Open("GET", 200DMA_url, false)
httpObj.Send()
csvData := httpObj.ResponseText
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
newsp500RelValue := ((valueSP500 - value200DMA) / valueSP500) * 100
newsp500RelValue := Round(newsp500RelValue) . "%"
RegExMatch(PutCallRatio, "(\d+\.\d+)", PCRnum)
RegExMatch(VIX, "(\d+\.\d+)", VIXnum)
RegExMatch(GAS, "(\d+\.\d+)", GASprc)
ResourcesFolder := A_MyDocuments . "\DTraderTools\resources\"
FileDelete, %ResourcesFolder%temp.txt
FileAppend, %VIXnum%`n%PCRnum%`n%newsp500RelValue%`n%GASprc%`n%OIL%, %ResourcesFolder%temp.txt
ExitApp
