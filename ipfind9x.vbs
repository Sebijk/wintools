'Sebijks IP-Finder VBScript
'(c) 2005-2006 Home of the Sebijk.de.
'http://www.sebijk.de

Set MyShell = CreateObject("Wscript.Shell")
Set MyFiles = CreateObject("Scripting.FileSystemObject")
Set umgebung=MyShell.Environment("PROCESS")
temp=umgebung("temp")


domain = InputBox("Geben Sie eine Internetadresse (ohne http://) ein","Sebijks IP-Finder")
If domain = "" then MsgBox "Sie nichts eingegeben. Das Programm wird beendet!", 64, "Sebijks IP-Finder"
If domain = "" then WScript.Quit
set drop=wscript.arguments
if drop.count=0 then
	i=MyShell.popup("Sie haben " & domain & " eingegeben. Wollen Sie fortfahren?",,"Sebijks IP-Finder",4)
	if i = 6 then 
		Set ping = Myfiles.OpenTextFile( temp & "\ping.bat", 2, True)
		ping.Writeline "@echo off"
                ping.Writeline "echo Sebijks IP-Finder fÅr Windows"
		ping.Writeline "echo (c) 2005-2006 Home of the Sebijk.de."
		ping.Writeline "echo http://www.sebijk.de"
		ping.Writeline "REM Copyright-Hinweis nicht entfernen."
		ping.Writeline "echo."
		ping.Writeline "ping " & domain
		ping.Writeline "echo."
		ping.Writeline "pause"
		ping.Close
myShell.Run temp & "\ping.bat"
End if
else
End if
WScript.Quit