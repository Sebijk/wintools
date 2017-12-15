@echo off
title=Sebijk's Benutzerkonten...

:start
cls
echo ---------------------------------------------------------
echo  Hiermit werden Benutzerkonten des Systems eingerichtet. 
echo ---------------------------------------------------------
echo.
echo   Hauptmen:
echo.
echo   1. Administratoren erstellen
echo   2. Benutzer erstellen
echo   3. G„ste erstellen
echo   4. Hauptbenutzer erstellen
echo   5. Hilfedienstbenutzer erstellen
echo   6. Netzwerkkonfigurations-Operatoren erstellen
echo   7. Remotedesktopbenutzer erstellen
echo   8. Replikations-Operator erstellen
echo   9. Sicherungs-Operatoren erstellen
echo   ----------------------------------------------
echo   10. Automatische Anmeldung konfigurieren
echo   11. Anmeldeoberfl„che konfigurieren
echo   ----------------------------------------------
echo   12. Beenden
echo.
set /p auswahl=Geben Sie eine Option ein: 
cls
if "%auswahl%"=="1" goto makeadmin
if "%auswahl%"=="2" goto makeuser
if "%auswahl%"=="3" goto makeguest
if "%auswahl%"=="4" goto mainuser
if "%auswahl%"=="5" goto helpuser
if "%auswahl%"=="6" goto netuser
if "%auswahl%"=="7" goto remoteuser
if "%auswahl%"=="8" goto replikuser
if "%auswahl%"=="9" goto securityuser
if "%auswahl%"=="10" goto autologon
if "%auswahl%"=="11" goto logmenu
if "%auswahl%"=="12" goto end
goto start

:logmenu
cls
echo -------------------
echo  Anmeldeoberfl„che 
echo -------------------
echo.
echo   Hauptmen:
echo.
echo   1. Klassiche Anmeldungbildschirm verwenden
echo   2. Willkommenseite verwenden
echo   ----------------------------------------------
echo   3. Zurck zu Hauptmen
echo   ----------------------------------------------
echo   4. Beenden
echo.
set /p logauswahl=Geben Sie eine Option ein: 
cls
if "%logauswahl%"=="1" set logonui=1
if "%logauswahl%"=="2" set logonui=2
if "%logauswahl%"=="1" goto logonui
if "%logauswahl%"=="2" goto logonui
if "%logauswahl%"=="3" goto start
if "%logauswahl%"=="4" goto end
goto logmenu

:logonui
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon] >> %temp%\logonui.reg
if "%logonui%"=="1" echo "LogonType"=dword:00000000 >> %temp%\logonui.reg
if "%logonui%"=="2" echo "LogonType"=dword:00000001 >> %temp%\logonui.reg
regedit /s %temp%\logonui.reg
del /f %temp%\logonui.reg
echo Anmeldebildschirm konfiguriert.
pause
goto logmenu

:makeadmin
set /p name=Geben Sie den Namen des Administrator ein: 
net user %name% /add > nul
net localgroup Administratoren %name% /add > nul
echo.
echo Der Administrator "%name%" wurde erfolgreich erstellt!
echo.
echo Eine beliebige Taste drcken . . .
pause > NUL
goto start

:makeuser
set /p name=Geben Sie den Namen des Benutzer ein: 
net user %name% /add > nul
echo.
echo Der Benutzer "%name%" wurde erfolgreich erstellt!
echo.
echo Eine beliebige Taste drcken . . .
pause > NUL
goto start

:makeguest
set /p name=Geben Sie den Namen des Gast ein: 
net user %name% /add > nul
net localgroup G„ste %name% /add > nul
echo.
echo Der Gast "%name%" wurde erfolgreich erstellt!
echo.
echo Eine beliebige Taste drcken . . .
pause > NUL
goto start

:mainuser
set /p name=Geben Sie den Namen des Hauptbenutzer ein: 
net user %name% /add > nul
net localgroup Hauptbenutzer %name% /add > nul
echo.
echo Der Hauptbenutzer "%name%" wurde erfolgreich erstellt!
echo.
echo Eine beliebige Taste drcken . . .
pause > NUL
goto start

:helpuser
set /p name=Geben Sie den Namen des Hilfedienstbenutzer ein: 
net user %name% /add > nul
net localgroup Hilfedienstgruppe %name% /add > nul
echo.
echo Der Hilfedienstbenutzer "%name%" wurde erfolgreich erstellt!
echo.
echo Eine beliebige Taste drcken . . .
pause > NUL
goto start

:netuser
set /p name=Geben Sie den Namen des Netzwerkkonfigurations-Benutzer ein: 
net user %name% /add > nul
net localgroup Netzwerkkonfigurations-Operatoren %name% /add > nul
echo.
echo Der Netzwerkkonfigurations-Benutzer "%name%" wurde erfolgreich erstellt!
echo.
echo Eine beliebige Taste drcken . . .
pause > NUL
goto start

:remoteuser
set /p name=Geben Sie den Namen des Remotedesktopbenutzer ein: 
net user %name% /add > nul
net localgroup Remotedesktopbenutzer %name% /add > nul
echo.
echo Der Remotedesktopbenutzer "%name%" wurde erfolgreich erstellt!
echo.
echo Eine beliebige Taste drcken . . .
pause > NUL
goto start

:replikuser
set /p name=Geben Sie den Namen des Replikations-Benutzer ein: 
net user %name% /add > nul
net localgroup Replikations-Operator %name% /add > nul
echo.
echo Der Replikations-Benutzer "%name%" wurde erfolgreich erstellt!
echo.
echo Eine beliebige Taste drcken . . .
pause > NUL
goto start

:securityuser
set /p name=Geben Sie den Namen des Sicherungs-Benutzer ein: 
net user %name% /add > nul
net localgroup Sicherungs-Operatoren %name% /add > nul
echo.
echo Der Sicherungs-Benutzer "%name%" wurde erfolgreich erstellt!
echo.
echo Eine beliebige Taste drcken . . .
pause > NUL
goto start

:autologon
echo WICHTIG! Der Benutzer muss existieren
echo.
set /p name=Geben Sie den Namen ein, der fr die Automatische Anmeldung verwendet wird: 
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]>>%temp%\autologin.reg
echo "DefaultUserName"="%name%">>%systemRoot%\Install\autologin.reg
echo "DefaultPassword"="">>%temp%\autologin.reg
echo "AutoAdminLogon"="1">>%temp%\autologin.reg
regedit /s %temp%\autologin.reg
del /F %temp%\autologin.reg
echo.
echo Der Benutzer "%name%" wird beim n„chsten Start automatisch angemeldet!
echo.
echo Eine beliebige Taste drcken . . .
pause > NUL
goto start

:end
set name=
