@echo off
cls


set TOOLPATH=@USMTPath@\User State Migration Tool\%PROCESSOR_ARCHITECTURE%
set SOURCEPCNAME=@SourcePCName@
set STOREPATH=@MigratedStore@\%SOURCEPCNAME%

echo Will be restoring all profiles from %STOREPATH% 
echo.


"%TOOLPATH%\loadstate.exe" "%STOREPATH%" /c /i:"%TOOLPATH%\MigApp.xml" /i:"%TOOLPATH%\MigDocs.xml" /i:"%TOOLPATH%\MigUser.xml" /sf

