@echo off

for /f "tokens=2*" %%a in ('reg query HKEY_CURRENT_USER\Software\Node.js /v InstallPath') do set "node_path=%%b\node.exe"

if  exist "%node_path%" (
  "%node_path%" "%~dp0\..\lib\cli.js" %1 %2
  if "%1" == "use" (
    call :set_enviroment %1
  ) else if "%1" == "deactivate" (
    call :set_enviroment %1
  )
  exit /b %ERRORLEVEL%
) else (
  echo The system version of Node not found
  exit /b 1
)

:set_enviroment
  if %ERRORLEVEL% == 0 (
      if "%1" == "deactivate" (
        set "NVMW="
      ) else (
        for /f "tokens=* delims=" %%i in (%TMP%\NVMW) do set "NVMW=%%i"
      )
      for /f "tokens=* delims=" %%i in (%TMP%\PATH) do set "PATH=%%i"
  )
exit /b 0