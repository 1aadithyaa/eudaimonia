If not A_IsAdmin { ; Runs script as Administrator for UAC in Windows Vista and 7+
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
  }
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
#NoTrayIcon
#SingleInstance, Force

Gosub, UpdateStatus

SetTimer, UpdateStatus, 60000
return

UpdateStatus:
global count := 0
Loop, 5 {
count++
global close := 2
FileRead, savedURLs, %A_Appdata%/Eudaimonia/urls%A_Index%.txt
FileReadLine, savedName, %A_Appdata%/Eudaimonia/set%A_Index%url.txt, 1
FileReadLine, savedTimePeriod, %A_Appdata%/Eudaimonia/set%A_Index%url.txt, 2
FileReadLine, savedTimeLimit, %A_Appdata%/Eudaimonia/set%A_Index%url.txt, 3
FileReadLine, savedMon, %A_Appdata%/Eudaimonia/set%A_Index%url.txt, 4
FileReadLine, savedTue, %A_Appdata%/Eudaimonia/set%A_Index%url.txt, 5
FileReadLine, savedWed, %A_Appdata%/Eudaimonia/set%A_Index%url.txt, 6
FileReadLine, savedThu, %A_Appdata%/Eudaimonia/set%A_Index%url.txt, 7
FileReadLine, savedFri, %A_Appdata%/Eudaimonia/set%A_Index%url.txt, 8
FileReadLine, savedSat, %A_Appdata%/Eudaimonia/set%A_Index%url.txt, 9
FileReadLine, savedSun, %A_Appdata%/Eudaimonia/set%A_Index%url.txt, 10
FileReadLine, savedOver, %A_Appdata%/Eudaimonia/set%A_Index%url.txt, 11
FileReadLine, savedEvery, %A_Appdata%/Eudaimonia/set%A_Index%url.txt, 12

if ((A_DDDD = "Monday" and savedMon = 1) or (A_DDDD = "Tuesday" and savedTue = 1) or (A_DDDD = "Wednesday" and savedWed = 1) or (A_DDDD = "Thursday" and savedThu = 1) or (A_DDDD = "Friday" and savedFri = 1) or (A_DDDD = "Saturday" and savedSat = 1) or (A_DDDD = "Sunday" and savedSun = 1) or (A_Hour <= SubStr(savedTimePeriod, 1,2) and A_Min <= SubStr(savedTimePeriod, 3, 4)) or (A_Hour >= SubStr(savedTimePeriod, 1, 2) and A_Min >= SubStr(savedTimePeriod, 3, 4))) and (savedOver = 0)
{
		global close := 3
}

	if (close = 3)
	{
		Loop, Read, %A_AppData%/Eudaimonia/urls%count%.txt 
		{
			str := "127.0.0.1 " A_LoopReadLine " #" count " Eudaimonia - Leave this comment here so Eudamonia can remove the block."
			FileAppend, `n%str%, %A_WinDir%\System32\drivers\etc\hosts
		}
	}
	if (close = 2)
	{
		Loop, Read, %A_WinDir%\System32\drivers\etc\hosts
		{
			If InStr(A_LoopReadLine, " #" count)
				FileAppend, %Text_To_Insert%`n, %A_Temp%\Temp.txt
			Else
				FileAppend, %A_LoopReadLine%`n, %A_Temp%\Temp.txt
		}
		FileMove, %A_Temp%\Temp.txt, %A_WinDir%\System32\drivers\etc\hosts, 1
	}
}


