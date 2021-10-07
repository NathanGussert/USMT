@echo off
cls



set TOOLPATH=@USMTPath@\User State Migration Tool\%PROCESSOR_ARCHITECTURE%
set STOREPATH=@MigratedStore@\%COMPUTERNAME%
set days=@Days@

echo %TOOLPATH%

echo Will be Capturing all profiles that have signed in within the last %days% days to:
echo %STOREPATH%
echo.



"%TOOLPATH%\scanstate.exe" "%STOREPATH%" /c /i:"%TOOLPATH%\MigApp.xml" /i:"%TOOLPATH%\MigDocs.xml" /i:"%TOOLPATH%\MigUser.xml" /localonly /uel:%days%