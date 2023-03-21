; DownloadImage.ahk

; Check if the required command line arguments are present
if (0 = A_Args.MaxIndex())
	ExitApp

ImageName := A_Args[1]
ImageURL := A_Args[2]
ImageFolder := A_Args[3]
ImageExt := (ImageName = "favicon") ? ".ico" : ".png"
ImagePath := ImageFolder . "\" . ImageName . ImageExt

; Download the image
UrlDownloadToFile, % ImageURL, % ImagePath

; Exit the script after downloading
ExitApp
