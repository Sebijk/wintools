' Skript:	sjuser2konto.js'
' Anwendung: 	Befördert die Verknüpfung zu Benutzer und Kennwörter'
'		unter Windows XP und höher in die Systemsteuerung.'
'		Based on pcwTweakcp.js von'
'		http://www.pcwelt.de'
'Autor:	Sebijk	(sebijk@web.de)'
'(c) 2005 - 2022 Home of the Sebijk.com'
'http://www.sebijk.com'
'Licensed under the GPL'

//Ein paar allgemeine Objekte, die das Script benötigt:
var oWs = WScript.CreateObject("WScript.Shell");

var strwindir = oWs.ExpandEnvironmentStrings("%WINDIR%");

//Versions-Check. Wenn kein XP und höher, dann quit().

if (winxpchk() == 0) {
  oWs.Popup("Dieses Skript läuft nur unter Windows XP und höher. Das Programm wird beendet", 0, "Sebijks Benutzer und Kennwörter", 16);
  WScript.Quit();
}


//Soll das Icon von Benutzer und Kennwörter in der Systemsteuerung entfernt oder erstellt werden?

if (KeyExists("HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\ControlPanel\\NameSpace\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\") == true) {
  delreg();
}
else { writereg(); }

//Funktionen zum Schreibzugriff auf die Registry:

function writereg() {
  try {
    oWs.RegWrite("HKCR\\CLSID\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\","Benutzer und Kennwörter");
    oWs.RegWrite("HKCR\\CLSID\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\InfoTip","Verwaltet Benutzer und Kennwörter für diesen Computer.");
    oWs.RegWrite("HKCR\\CLSID\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\DefaultIcon\\","%SystemRoot%\\System32\\shell32.dll,-220", "REG_EXPAND_SZ");
    oWs.RegWrite("HKCR\\CLSID\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\Shell\\Open\\Command\\", "control.exe userpasswords2");
    oWs.RegWrite("HKCR\\CLSID\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\ShellFolder\\Attributes", 48, "REG_DWORD");
    oWs.RegWrite("HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\ControlPanel\\NameSpace\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\", "Benutzer und Kennwörter");
  }
  catch(error) { oWs.Popup("Kein Schreibzugriff auf die Registry möglich. Sie müssen als Administrator angemeldet sein.", 0, "Sebijks Benutzer und Kennwörter", 16); WScript.Quit(); }
  oWs.Popup("Benutzer und Kennwörter ist jetzt über die Systemsteuerung verfügbar. Sie müssen sich dazu aber erneut am System anmelden.", 0, "Sebijks Benutzer und Kennwörter", 64);
}

function delreg() {
  try {
    oWs.RegDelete("HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\ControlPanel\\NameSpace\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\");
    oWs.RegDelete("HKCR\\CLSID\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\ShellFolder\\");
    oWs.RegDelete("HKCR\\CLSID\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\Shell\\Open\\Command\\");
    oWs.RegDelete("HKCR\\CLSID\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\Shell\\Open\\");
    oWs.RegDelete("HKCR\\CLSID\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\Shell\\");
    oWs.RegDelete("HKCR\\CLSID\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\DefaultIcon\\");
    oWs.RegDelete("HKCR\\CLSID\\{CA41B6BE-E945-4DDD-BC0B-977E626DE521}\\");
  }
  catch(error) { oWs.Popup("Kein Schreibzugriff auf die Registry möglich. Sie müssen als Administrator angemeldet sein.", 0, "Sebijks Benutzer und Kennwörter", 16); WScript.Quit(); }
  oWs.Popup("Das Symbol von Benutzer und Kennwörter ist aus der Systemsteuerung entfernt. Die Änderung tritt aber erst nach der nächsten Anmeldung in Kraft.", 0, "Sebijks Benutzer und Kennwörter", 64);
}

//Versions-Check

function winxpchk() {
  var strver = true;
  try {
   if (oWs.RegRead("HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\CurrentVersion") < "5.1") {
       
      strver = false;
   
    }

  }
  catch(error) { strver = false; }
  return strver

}

/* KeyExists überprüft, ob ein Schlüssel in der Registry existiert */
function KeyExists(key) { 
  findstate = true;
  try {oWs.RegRead(key);}
  catch(error) {findstate = false;}
  return findstate
}
