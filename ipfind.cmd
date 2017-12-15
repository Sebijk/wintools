@echo off
title=Sebijk's IP-Finder
echo ---------------------------------------------------------
echo                     Sebijk's IP-Finder
echo ---------------------------------------------------------

:ping
set /p pingip=Geben Sie die Dom„ne oder eine Internetadresse (ohne http://) ein: 
if "%pingip%"=="" echo Es wurde nichts angegeben.
echo.
if "%pingip%"=="" goto ping
ping %pingip%
echo.
echo Eine beliebige Taste drcken . . .
pause > NUL

:end
set pingip=
