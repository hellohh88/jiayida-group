@echo off

set SETTINGS=c:\settings.xml
set VARS=
set CLIENT_DIR=jiayida-admin

echo Input maven settings.xml location[%SETTINGS%]
set /p VARS=
if "%VARS%" == "" goto patch
set SETTINGS=%VARS%

:patch
if exist %SETTINGS% (echo %SETTINGS% check passed) else (echo check %SETTINGS% failed && echo use default settings.xml ... && set SETTINGS=)

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
if "%SETTINGS%" == "" goto default
call mvn -s %SETTINGS% -Dtest=PatchClient test -Dpatch.type="encrypt" -Dpatch.file="%PATCH_FILE%" 
goto done

:default
call mvn -Dtest=PatchClient test -Dpatch.type="encrypt" -Dpatch.file="%PATCH_FILE%" 

:done
echo encrypt done

cd ..

echo opening file %PATCH_FILE%.cp
notepad %PATCH_FILE%.cp

pause
