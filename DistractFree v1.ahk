#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_Appdata% ; Ensures a consistent starting directory.
#SingleInstance, Force

Gui, +AlwaysOnTop +Resize
FileCreateDir, Distract Free

Gui, Font, s10

Gui, Add, Button, x0 y0 w100 h25 gBlock_URLs, URLs
Gui, Add, Button, x+0 w100 h25 gBlock_Programs, Programs
Gui, Add, Button, x+0 w100 h25 gOptions, Options

Gui, Add, Text, x10 vURLtext, Add the list of websites you want to block. `nExample: www.reddit.com
Gui, Add, Edit, x0 y70 w300 h300 vURL gSubmit_URL, URLs

Gui, Add, Text, x10 y32 vProgramtext, Add the list of programs you want to block. `nExample: Steam.exe
Gui, Add, Edit, x0 y70 w300 h300 vPROG gSubmit_Program, Programs

Gui, Add, Button, x25 y370 gSave, Save
Gui, Add, Button, x150 y370 gBlock, Block

Gui, Show, w300 h400, Distract Free

Block_URLs:
GuiControl, Hide, Programtext
GuiControl, Hide, PROG

GuiControl, Show, URLtext
GuiControl, Show, URL
return

Block_Programs:
GuiControl, Hide, URLtext
GuiControl, Hide, URL

GuiControl, Show, Programtext
GuiControl, Show, PROG
return

Options:
return

GuiClose:
	Gui, Cancel
	ProgramBlocker()
	return

Submit_URL:
	FileDelete, %A_Appdata%/Distract Free/urls.txt
    FileAppend, %URL%, %A_Appdata%/Distract Free/urls.txt ; Issues with deleting last char
	Gui, Submit, NoHide
	return

Submit_Program:
	FileDelete, %A_Appdata%/Distract Free/programs.txt
	FileAppend, %PROG%, %A_Appdata%/Distract Free/programs.txt
	Gui, Submit, NoHide
	return

Save:
Gosub, Submit_URL
Gosub, Submit_Program
return

Block:
Gosub, GuiClose
	
URLBlocker() {
	Loop, Read, %A_Appdata%/Distract Free/urls.txt
	{
		WinGetText, Var, Chrome
		IfInString, Var, %A_LoopReadLine%
			{
			WinClose, Chrome, %A_LoopReadLine%
			Run, calc.exe
		}
	}
}

ProgramBlocker() {
	Loop, Read, %A_Appdata%/Distract Free/programs.txt
	{
		Sleep, 100
		WinClose, ahk_exe %A_LoopReadLine%
	}
}