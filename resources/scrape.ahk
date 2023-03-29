; scrape.ahk
PCR_url := "https://ycharts.com/indicators/cboe_equity_put_call_ratio"
httpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
httpObj.Open("GET", PCR_url)
httpObj.Send()
response := httpObj.ResponseText
pattern := "(\d+\.\d+)\s+for\s+(\w+\s+\d+\s+\d+)"
RegExMatch(response, pattern, result)
PutCallRatio := Trim(result)
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
ResourcesFolder := A_MyDocuments . "\DTraderTools\resources\"
FileDelete, %ResourcesFolder%temp.txt
FileAppend, %VIXnum%`n%PCRnum%`n%newsp500RelValue%, %ResourcesFolder%temp.txt
ExitApp
