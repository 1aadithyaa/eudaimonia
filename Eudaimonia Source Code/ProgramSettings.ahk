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
Gui, Add, Button, x10 w80 vButton1 gReaderChange, %savedName%
count := 1
Loop, 4 {
	count++
	FileReadLine, savedName, %A_Appdata%/Eudaimonia/set%count%prog.txt, 1
	Gui, Add, Button, x+0 w80 vButton%count% gReaderChange, %savedName%
}

; What to block
Gui, Add, Text, x10, Enter a custom name for this block set (optional):
FileReadLine, savedName, %A_Appdata%/Eudaimonia/set1prog.txt, 1
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
Gui, Add, DropDownList, x+10 gPrefs vEvery, quarter-hour (15 nins)|half-hour (30 mins)|hour|2 hours|3 hours|4 hours|6 hours|8 hours|12 hours|24 hours|
Gui, Add, Text, x10 y+8, Select the days on which to block these applications:

Gui, Add, Checkbox,y+8 x10 gPrefs vMon Checked%savedMon%, Mon
Gui, Add, Checkbox,x+8 gPrefs vTue Checked%savedTue%, Tue
Gui, Add, Checkbox,x+8 gPrefs vWed Checked%savedWed%, Wed
Gui, Add, Checkbox,x+8 gPrefs vThu Checked%savedThu%, Thu
Gui, Add, Checkbox,x+8 gPrefs vFri Checked%savedFri%, Fri
Gui, Add, Checkbox,x+8 gPrefs vSat Checked%savedSat%, Sat
Gui, Add, Checkbox,x+8 gPrefs vSun Checked%savedSun%, Sun
Gui, Add, Checkbox,x10 y+12 gPrefs gPrompt vOver Checked%savedOver%, Allow temporary override for these applications

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
	
Prompt:
	arr := ["HU*4itdJ1LQ!bE1GdHdkpveN#8m&@$1j", "SdF@LyF^EhulYYiw5xxsjvMtBk0B#!sH", "SdF@LyF^EhulYYiw5xxsjvMtBk0B#!sH", "J6E%aCfnf&DMBV$^4!Jns^2qiaXY$M7w", "rg*b8LLVt517a%BLk34XhOjFnJtZQ@n4", "rg*b8LLVt517a%BLk34XhOjFnJtZQ@n4", "Ee87%4^NpclSKr!sZxr88wb8LUkA*Abk", "sJF$A&RpbaNTV!N*Q^XsL8t5jV^Gmo4l"]
	Random, number, 1, 8
	var := arr[number]

OverrideCode:
	GuiControlGet, state,, %A_GuiControl%
	if (state = 1) {
		InputBox, str, Enable Override, To enable override`, please type in the following 32-character code:`n%var%
		if (str = var) {
			MsgBox, Temporary override enabled for 15 minutes!
			GuiControl,, Over, 1
			GuiControl, Text, Over, Allow temporary override for these applications
			Goto, Prefs			
		}
		if (ErrorLevel = 1) {
			GuiControl,, Over, 0
			Gosub, Prefs
		}
		else {
			MsgBox, Try again!
			GuiControl,, Over, 0
			GuiControl, Text, Over, Allow temporary override for these applications
			Gosub, OverrideCode
		}
	}
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
	Gosub, ReaderChange
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
