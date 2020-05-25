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
global close := 2
Loop, 5 {
FileRead, savedURLs, %A_Appdata%/Eudaimonia/programs%A_Index%.txt
FileReadLine, savedName, %A_Appdata%/Eudaimonia/set%A_Index%prog.txt, 1
FileReadLine, savedTimePeriod, %A_Appdata%/Eudaimonia/set%A_Index%prog.txt, 2
FileReadLine, savedTimeLimit, %A_Appdata%/Eudaimonia/set%A_Index%prog.txt, 3
FileReadLine, savedMon, %A_Appdata%/Eudaimonia/set%A_Index%prog.txt, 4
FileReadLine, savedTue, %A_Appdata%/Eudaimonia/set%A_Index%prog.txt, 5
FileReadLine, savedWed, %A_Appdata%/Eudaimonia/set%A_Index%prog.txt, 6
FileReadLine, savedThu, %A_Appdata%/Eudaimonia/set%A_Index%prog.txt, 7
FileReadLine, savedFri, %A_Appdata%/Eudaimonia/set%A_Index%prog.txt, 8
FileReadLine, savedSat, %A_Appdata%/Eudaimonia/set%A_Index%prog.txt, 9
FileReadLine, savedSun, %A_Appdata%/Eudaimonia/set%A_Index%prog.txt, 10
FileReadLine, savedOver, %A_Appdata%/Eudaimonia/set%A_Index%prog.txt, 11
FileReadLine, savedEvery, %A_Appdata%/Eudaimonia/set%A_Index%prog.txt, 12

if ((A_DDDD = "Monday" and savedMon = 1) or (A_DDDD = "Tuesday" and savedTue = 1) or (A_DDDD = "Wednesday" and savedWed = 1) or (A_DDDD = "Thursday" and savedThu = 1) or (A_DDDD = "Friday" and savedFri = 1) or (A_DDDD = "Saturday" and savedSat = 1) or (A_DDDD = "Sunday" and savedSun = 1) or (A_Hour <= SubStr(savedTimePeriod, 1,2) and A_Min <= SubStr(savedTimePeriod, 3, 4)) or (A_Hour >= SubStr(savedTimePeriod, 1, 2) and A_Min >= SubStr(savedTimePeriod, 3, 4))) and (savedOver = 0)
	{
		global close := 3
		goto KillPrograms
	}
}
return

KillPrograms:
if close = 3
{
	Loop, 
	{
	Loop, Read, %A_Appdata%/Eudaimonia/programs1.txt
		{
			Sleep, 500
			WinClose, ahk_exe %A_LoopReadLine%
		}
	Loop, Read, %A_Appdata%/Eudaimonia/programs2.txt
		{
			Sleep, 500
			WinClose, ahk_exe %A_LoopReadLine%
		}
	Loop, Read, %A_Appdata%/Eudaimonia/programs3.txt
		{
			Sleep, 500
			WinClose, ahk_exe %A_LoopReadLine%
		}
	Loop, Read, %A_Appdata%/Eudaimonia/programs4.txt
		{
			Sleep, 500
			WinClose, ahk_exe %A_LoopReadLine%
		}
	Loop, Read, %A_Appdata%/Eudaimonia/programs5.txt
		{
			Sleep, 500
			WinClose, ahk_exe %A_LoopReadLine%
		}
	}
}