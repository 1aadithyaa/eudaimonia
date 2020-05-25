#NoTrayIcon
#SingleInstance, Force
SetWorkingDir, %A_WorkingDir%

FileCreateDir, %A_AppData%\Eudaimonia
Run *RunAs "%A_WorkingDir%\Internal\URLBlocker.exe"
Run, %A_WorkingDir%\Internal\ProgramBlocker.exe
Gui, Add, Picture, x2 y5 w310 h260 , %A_WorkingDir%\Graphics\Logo.png
Gui, Color, B31B1B
Gui, Font, s10
Gui, Add, Button, gURL x42 y269 w230 h50, URL Settings
Gui, Add, Button, gProgram x42 y319 w230 h50, Program Settings
Gui, Add, Button, gWeb x42 y369 w230 h50, Web

Loop, 5 {
FileAppend,, %A_AppData%\Eudaimonia\set%A_Index%url.txt
FileAppend,, %A_AppData%\Eudaimonia\set%A_Index%prog.txt
FileAppend,, %A_AppData%\Eudaimonia\programs%A_Index%.txt
FileAppend,, %A_AppData%\Eudaimonia\urls%A_Index%.txt
}
Gui, Show, w317 h443, Eudaimonia
return

URL:
Run, URLSettings.exe
return

Program:
Run, ProgramSettings.exe
return

Web:
Run, https://eudaimoniaapp.weebly.com/
return

GuiClose:
ExitApp