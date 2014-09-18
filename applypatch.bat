@echo off

set SETTINGS=c:\settings.xml
set VARS=
set VARC=
set CLIENT_DIR=jiayida-admin

echo Input maven settings.xml location[%SETTINGS%]
set /p VARS=
if "%VARS%" == "" goto patch
SETTINGS=%VARS%

:patch
cd %~dp0

echo clean previous patch files...
del /Q *.patch

for /f %%i in ('dir /b *.patch.cp') do set CP_PATCH=%%i

if "%CP_PATCH%" == "" goto nocp

set CP_FILE=%CD%/%CP_PATCH%

cd %CLIENT_DIR%
echo decrypt %CP_PATCH% ...
call mvn -s %SETTINGS% exec:java -Dexec.mainClass="com.joinway.cobot.tools.CipherClient" -Dexec.args="decrypt '%CP_FILE%'"
echo decrypt done

cd ..

for /f %%i in ('dir /b *.patch') do set PATCH=%%i
if "%PATCH%" == "" goto nopatch

echo ****** check %PATCH% status ******
git apply --stat %PATCH%
pause

echo test %PATCH% ...
@rem for /f %%i in ('call git apply --check %PATCH%') do set RESULT=%%i
git apply --check %PATCH%
if "%ERRORLEVEL%" == "1" goto fail

echo Continue to apply patch?[Y]
set /p VARC=
if "%VARC%" == "" goto apply
goto abort

:apply
echo applying patch ...
git apply am %PATCH%

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
goto end

:end