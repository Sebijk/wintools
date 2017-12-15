'Sebijks Windows-Datei Extrahierer Beta 0.4
'(c) 2005-2017 Home of the Sebijk.com.
'http://www.sebijk.com
'Licensed under the GPL

Set MyShell = CreateObject("Wscript.Shell")
Set MyFiles = CreateObject("Scripting.FileSystemObject")
Set AppShell = CreateObject("Shell.Application")
Set umgebung=MyShell.Environment("PROCESS")
windir=umgebung("windir")
temp=umgebung("temp")
title="Sebijks Windows-Datei Extrahierer Beta 0.4"
Set BrowsePfad = Appshell.BrowseForFolder(0, "Bitte wählen Sie ein Ordner aus, wo sich die Windows-Installationsdateien befinden!",  &H0001, 17)
On Error Resume Next
If BrowsePfad = "" Then wscript.quit
Ordner = BrowsePfad.ParentFolder.ParseName(BrowsePfad.Title).Path
	If err.number > 0 Then
	i=instr(BrowsePfad, ":")
	Ordner = mid(BrowsePfad, i - 1, 1) & ":\"
	End If
	
If not (MyFiles.FolderExists(Ordner)) Then
	g = msgbox("Wählen Sie bitte einen gültigen Ordner aus.",vbCritical,title)
	wscript.quit
End If
quellpfad = Ordner
If quellpfad = "" then MsgBox "Sie haben kein Quellpfad eingegeben. Das Programm wird beendet!", vbExclamation, title
If quellpfad = "" then WScript.Quit
zielpfad = InputBox("Bitte geben Sie den Zielpfad wo die Datei entpackt werden soll ein!",title,"")
If zielpfad = "" then WScript.Quit
datei = InputBox("Geben Sie die Dateiname ein die entpackt werden soll! (Unter Windows NT/2000/XP muss das Dateiformat z.b shell32.dl_ heißen!)",title,"shell32.dll")
If datei = "" then WScript.Quit
set drop=wscript.arguments
if drop.count=0 then
	i=MyShell.popup("Sie haben als Quellpfad " & quellpfad & ", den Zielpfad " & zielpfad & " und die Datei die Extrahiert werden soll " & datei & " eingegeben! Sebijks Windows-Datei Extrahierer startet jetzt den Vorgang! Wollen Sie fortfahren?",,title,4)
	if i = 6 then 
		Set wexsjBatch = Myfiles.OpenTextFile( temp & "\Extract.bat", 2, True)
		wexsjbatch.Writeline "@echo off"
		wexsjbatch.Writeline "echo Sebijks Windows-Datei Extrahierer Beta 0.4"
		wexsjbatch.Writeline "echo (c)2005-2017. Licensed under GPL"
		wexsjbatch.Writeline "echo http://www.sebijk.com"
		wexsjbatch.Writeline "echo."
		wexsjbatch.Writeline "md " & zielpfad
		wexsjbatch.Writeline "if exist " & quellpfad & "\win95\extract.exe set winsource=" & quellpfad &  "\win95"
		wexsjbatch.Writeline "if exist " & quellpfad & "\win98\extract.exe set winsource=" & quellpfad &  "\win98"
		wexsjbatch.Writeline "if exist " & quellpfad & "\win9x\extract.exe set winsource=" & quellpfad &  "\win9x"
		wexsjbatch.Writeline "if exist " & quellpfad & "\i386\expand.exe set winsource=" & quellpfad &  "\i386"
		wexsjbatch.Writeline "if exist " & quellpfad & "\win95\extract.exe %winsource%\extract.exe /A %winsource%\win95_02.cab " & datei & " /L " & zielpfad
		wexsjbatch.Writeline "if exist " & quellpfad & "\win98\extract.exe %winsource%\extract.exe /A %winsource%\win98_28.cab " & datei & " /L " & zielpfad
		wexsjbatch.Writeline "if exist " & quellpfad & "\win9x\extract.exe %winsource%\extract.exe /A %winsource%\win_8.cab " & datei & " /L " & zielpfad
		wexsjbatch.Writeline "if exist " & quellpfad & "\i386\expand.exe %winsource%\expand.exe %winsource%\" & datei & " " & zielpfad
		wexsjbatch.Writeline "if exist " & zielpfad & "\*.dl_ ren " & zielpfad & "\*.dl_ *.dll"
		wexsjbatch.Writeline "if exist " & zielpfad & "\*.ex_ ren " & zielpfad & "\*.ex_ *.exe"
		wexsjbatch.Writeline "if exist " & zielpfad & "\*.jp_ ren " & zielpfad & "\*.jp_ *.jpg"
		wexsjbatch.Writeline "if exist " & zielpfad & "\*.cp_ ren " & zielpfad & "\*.cp_ *.cpl"
		wexsjbatch.Writeline "if exist " & zielpfad & "\*.oc_ ren " & zielpfad & "\*.oc_ *.ocx"
		wexsjbatch.Writeline "if exist " & zielpfad & "\*.wa_ ren " & zielpfad & "\*.wa_ *.wav"
		wexsjbatch.Writeline "if exist " & zielpfad & "\*.in_ ren " & zielpfad & "\*.in_ *.inf"
		wexsjbatch.Writeline "pause"
		wexsjbatch.Close
		MyShell.Run temp & "\Extract.bat",,true
		myfiles.DeleteFile temp & "\Extract.bat"
		MsgBox "Die Datei " & datei & "wurde in " & zielpfad & " entpackt! Das Programm wird beendet!", 64, title
		End If
	wscript.quit
end if