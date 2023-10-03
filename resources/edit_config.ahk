#SingleInstance, Force

; Initialize
configFile := A_MyDocuments "\DTraderTools\config.ini"

; Function to load the config file into the GUI
LoadConfig:
Gui, Destroy
Gui, Add, Button, x10 y10 gReload, Reload Config
Gui, Add, Button, x110 y10 gSave, Save
Gui, Add, Button, x210 y10 gCancel, Cancel

; Read config and populate GUI
FileRead, fileContent, %configFile%
if ErrorLevel
{
    MsgBox, File does not exist or could not be read.
    ExitApp
}
lines := StrSplit(fileContent, "`n", "`r")
section := ""
yPos := 40
col := 1
for index, line in lines
{
    line := Trim(line)
    if (line = "")
        continue
    if (SubStr(line, 1, 1) = "[" and SubStr(line, 0) = "]")
    {
        section := SubStr(line, 2, StrLen(line) - 2)
        Gui, Add, Text, x10 y%yPos%, % "---- " section " ----"
        yPos += 30
        continue
    }
    ; Otherwise, parse key-value pairs
    parts := StrSplit(line, "=")
    key := Trim(parts[1])
    value := Trim(parts[2])
    if (col = 1)
    {
        Gui, Add, Text, x10 y%yPos%, %key%
        Gui, Add, Edit, x110 y%yPos% v%section%_%key%, %value%
        col := 2
    }
    else
    {
        Gui, Add, Text, x250 y%yPos%, %key%
        Gui, Add, Edit, x350 y%yPos% v%section%_%key%, %value%
        col := 1
        yPos += 30
    }
}
Gui, Show, w500 h%yPos%, Advanced Config Editor
return

; Reload button
Reload:
Goto, LoadConfig
return

; Save button
Save:
Gui, Submit, NoHide
newConfig := ""
section := ""
Loop, Read, %configFile%
{
    line := Trim(A_LoopReadLine)
    if (line = "")
        continue
    if (SubStr(line, 1, 1) = "[" and SubStr(line, 0) = "]")
    {
        section := SubStr(line, 2, StrLen(line) - 2)
        newConfig .= "[" section "]" "`n"
        continue
    }
    ; Otherwise, parse key-value pairs
    parts := StrSplit(line, "=")
    key := Trim(parts[1])
    GuiControlGet, value, , %section%_%key%
    newConfig .= key "=" value "`n"
}
FileDelete, %configFile%
FileAppend, %newConfig%, %configFile%
MsgBox, Data saved.
return

; Cancel button
Cancel:
Gui, Destroy
ExitApp
return

; Initial call to load the config
Goto, LoadConfig
