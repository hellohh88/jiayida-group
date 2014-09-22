@echo off

set SETTINGS=c:\settings.xml
set VARS=
set VARC=
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

for /f %%i in ('dir /b *.patch.cp') do set CP_PATCH=%%i

if "%CP_PATCH%" == "" goto nocp

set CP_FILE=%CD%/%CP_PATCH%

cd %CLIENT_DIR%
echo decrypt %CP_PATCH% ...

if "%SETTINGS%" == "" goto default
call mvn -s %SETTINGS% test -Dtest=PatchClient -DargLine="-Dpatch.type=decrypt -Dpatch.file='%CP_FILE%'"
goto done

:default
call mvn test -Dtest=PatchClient -DargLine="-Dpatch.type=decrypt -Dpatch.file='%CP_FILE%'"

:done
echo decrypt done

cd ..

for /f %%i in ('dir /b *.patch') do set PATCH=%%i
if "%PATCH%" == "" goto nopatch

echo ****** check %PATCH% status ******
echo "git apply --stat %PATCH%"
git apply --stat %PATCH%
pause

echo test %PATCH% ...
echo "git apply --check %PATCH%"
git apply --check %PATCH%
if "%ERRORLEVEL%" == "1" goto fail

echo Continue to apply patch?[Y]
set /p VARC=
if "%VARC%" == "" goto apply
if "%VARC%" == "y" goto apply
if "%VARC%" == "Y" goto apply
goto abort

:apply
echo applying patch ...
echo git am < %PATCH%
git am < %PATCH%

echo apply patch done

goto end

:nocp
echo no xxx.patch.cp file was found
goto end

:nopatch
echo no xxx.patch file was generated
goto end

:fail
echo *** test apply patch failed, please resolve the conflit and try again ***
goto end

:abort
echo abort apply patch
pause
goto end

:end