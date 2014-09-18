@echo off

set SETTINGS=c:\settings.xml
set VARS=
set CLIENT_DIR=jiayida-admin

echo Input maven settings.xml location[%SETTINGS%]
set /p VARS=
if "%VARS%" == "" goto patch
set SETTINGS=%VARS%

:patch
cd %~dp0

echo clean previous patch files...
del /Q *.patch
del /Q *.patch.cp

echo generate last commit patch ...
echo "git format-patch -1"
git format-patch -1
echo generated patch file done

dir /o *.patch

for /f %%i in ('dir /b *.patch') do set PATCH=%%i
set PATCH_FILE=%CD%\%PATCH%

cd %CLIENT_DIR%

echo encrypting %PATCH% ...
call mvn -s %SETTINGS% test -Dtest=PatchClient -Dpatch.type=encrypt -Dpatch.file="%PATCH_FILE%"
echo encrypt done

cd ..
pause
echo opening file %PATCH_FILE%.cp
notepad %PATCH_FILE%.cp

