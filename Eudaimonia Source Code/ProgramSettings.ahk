#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

Reader1:
str := 1
FileRead, savedURLs, %A_Appdata%/Eudaimonia/programs1.txt
FileReadLine, savedName, %A_Appdata%/Eudaimonia/set1prog.txt, 1
FileReadLine, savedTimePeriod, %A_Appdata%/Eudaimonia/set1prog.txt, 2
FileReadLine, savedTimeLimit, %A_Appdata%/Eudaimonia/set1prog.txt, 3
FileReadLine, savedMon, %A_Appdata%/Eudaimonia/set1prog.txt, 4
FileReadLine, savedTue, %A_Appdata%/Eudaimonia/set1prog.txt, 5
FileReadLine, savedWed, %A_Appdata%/Eudaimonia/set1prog.txt, 6
FileReadLine, savedThu, %A_Appdata%/Eudaimonia/set1prog.txt, 7
FileReadLine, savedFri, %A_Appdata%/Eudaimonia/set1prog.txt, 8
FileReadLine, savedSat, %A_Appdata%/Eudaimonia/set1prog.txt, 9
FileReadLine, savedSun, %A_Appdata%/Eudaimonia/set1prog.txt, 10
FileReadLine, savedOver, %A_Appdata%/Eudaimonia/set1prog.txt, 11
FileReadLine, savedEvery, %A_Appdata%/Eudaimonia/set1prog.txt, 12

Gui:
Gui, Add, Button, x10 w80 vButton1 gReaderChange, Block Set 1
if savedname !=
	GuiControl, Text, Button%count%, %savedName%
count := 1
Loop, 4 {
	count++
	FileReadLine, savedName, %A_Appdata%/Eudaimonia/set%count%url.txt, 1
	Gui, Add, Button, x+0 w80 vButton%count% gReaderChange, Block Set %count%
	if savedName != 
	GuiControl, Text, Button%count%, %savedName%
}

; What to block
Gui, Add, Text, x10, Enter a custom name for this block set (optional):
Gui, Add, Edit, y+8 w100 vSet1 gPrefs, %savedName%
Gui, Add, Text,, Enter the names of the applications to block (one item per line):
Gui, Add, Edit, y+8 w400 h100 vURL gSubmit_URL, %savedURLs%

; When to block
Gui, Add, Text,, Enter the time periods within which to block these applications (optional):
Gui, Add, Edit, y+8 w200 vAllDayField gPrefs limit9, %savedTimePeriod%
Gui, Add, Button, x+10 w50 h25 gAllDay, All day

Gui, Add, Text, x10, Enter a time limit after which to block these applications (optional):
Gui, Add, Edit, y+8 w50 vMins gPrefs limit2, %savedTimeLimit%
Gui, Add, Text, x+10, minutes in every
Gui, Add, DropDownList, x+10 gPrefs vEvery, quarter-hour (15 nins)|half-hour (30 mins)|hour|2 hours|3 hours|4 hours|6 hours|8 hours|12 hours|24 hours
Gui, Add, Text, x10 y+8, Select the days on which to block these applications:

Gui, Add, Checkbox,y+8 x10 gPrefs vMon Checked%savedMon%, Mon
Gui, Add, Checkbox,x+8 gPrefs vTue Checked%savedTue%, Tue
Gui, Add, Checkbox,x+8 gPrefs vWed Checked%savedWed%, Wed
Gui, Add, Checkbox,x+8 gPrefs vThu Checked%savedThu%, Thu
Gui, Add, Checkbox,x+8 gPrefs vFri Checked%savedFri%, Fri
Gui, Add, Checkbox,x+8 gPrefs vSat Checked%savedSat%, Sat
Gui, Add, Checkbox,x+8 gPrefs vSun Checked%savedSun%, Sun
Gui, Add, Checkbox,x10 y+12 gPrefs vOver Checked%savedOver%, Allow temporary override for these applications

Gui, Add, Button, x100 y+8 gSubmit_URL, Save Options
Gui, Add, Button, x+0 gSaveAndClose, Save Options And Close

Gui, Show, w425 h415, Block Programs
;Gosub, ProgramBlocker
return

Prefs:
	FileDelete, %A_Appdata%/Eudaimonia/set%str%prog.txt
    FileAppend, %Set1%`n%AllDayField%`n%Mins%`n%Mon%`n%Tue%`n%Wed%`n%Thu%`n%Fri%`n%Sat%`n%Sun%`n%Over%`n%Every%, %A_Appdata%/Eudaimonia/set%str%prog.txt
	Gui, Submit, NoHide
	FileDelete, %A_Appdata%/Eudaimonia/set%str%prog.txt
    FileAppend, %Set1%`n%AllDayField%`n%Mins%`n%Mon%`n%Tue%`n%Wed%`n%Thu%`n%Fri%`n%Sat%`n%Sun%`n%Over%`n%Every%, %A_Appdata%/Eudaimonia/set%str%prog.txt
	Gui, Submit, NoHide
	return

Submit_URL:
	FileDelete, %A_Appdata%/Eudaimonia/programs%str%.txt
    FileAppend, %URL%, %A_Appdata%/Eudaimonia/programs%str%.txt ; Issues with deleting last char
	Gui, Submit, NoHide
	FileDelete, %A_Appdata%/Eudaimonia/programs%str%.txt
    FileAppend, %URL%, %A_Appdata%/Eudaimonia/programs%str%.txt ; Issues with deleting last char
	Gui, Submit, NoHide
	return

AllDay:
	GuiControl, Text, AllDayField, 0000-2400
	return

GuiClose:
	Gosub, Submit_URL
	Gosub, Prefs
	ExitApp
	return
	
SaveAndClose:
	Gosub, GuiClose
	return

ReaderChange:
GuiControlGet, str, Name, %A_GuiControl%
str := SubStr(str, 7, 7)
FileRead, savedURLs, %A_Appdata%/Eudaimonia/programs%str%.txt
FileReadLine, savedName, %A_Appdata%/Eudaimonia/set%str%prog.txt, 1
FileReadLine, savedTimePeriod, %A_Appdata%/Eudaimonia/set%str%prog.txt, 2
FileReadLine, savedTimeLimit, %A_Appdata%/Eudaimonia/set%str%prog.txt, 3
FileReadLine, savedMon, %A_Appdata%/Eudaimonia/set%str%prog.txt, 4
FileReadLine, savedTue, %A_Appdata%/Eudaimonia/set%str%prog.txt, 5
FileReadLine, savedWed, %A_Appdata%/Eudaimonia/set%str%prog.txt, 6
FileReadLine, savedThu, %A_Appdata%/Eudaimonia/set%str%prog.txt, 7
FileReadLine, savedFri, %A_Appdata%/Eudaimonia/set%str%prog.txt, 8
FileReadLine, savedSat, %A_Appdata%/Eudaimonia/set%str%prog.txt, 9
FileReadLine, savedSun, %A_Appdata%/Eudaimonia/set%str%prog.txt, 10
FileReadLine, savedOver, %A_Appdata%/Eudaimonia/set%str%prog.txt, 11
FileReadLine, savedEvery, %A_Appdata%/Eudaimonia/set%str%prog.txt, 12
if savedname !=
	GuiControl, Text, %A_GuiControl%, %savedName%
else
	GuiControl, Text, %A_GuiControl%, Block Set %str%
GuiControl, Text, URL, %savedURLs%
GuiControl, Text, Set1, %savedName%
GuiControl, Text, AllDayField, %savedTimePeriod%
GuiControl, Text, Every, %savedTimeLimit%
GuiControl,, Mon, %savedMon%
GuiControl, Text, Mon, Mon
GuiControl,, Tue, %savedTue%
GuiControl, Text, Tue, Tue
GuiControl,, Wed, %savedWed%
GuiControl, Text, Wed, Wed
GuiControl,, Thu, %savedThu%
GuiControl, Text, Thu, Thu
GuiControl,, Fri, %savedFri%
GuiControl, Text, Fri, Fri
GuiControl,, Sat, %savedSat%
GuiControl, Text, Sat, Sat
GuiControl,, Sun, %savedSun%
GuiControl, Text, Sun, Sun
GuiControl,, Over, %savedOver%
GuiControl, Text, Over, Allow temporary override for these sites
return
