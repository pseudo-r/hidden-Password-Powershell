echo off & setlocal DisableDelayedExpansion
Title %~n0
Mode 50,5 & Color 0E
echo Please Type your Username (example EMA12345)
set /p U="Enter Username : "
Call:InputPassword "Enter Password" P


setlocal EnableDelayedExpansion
sc.exe config RTACDB obj= "EMERA\!U!" password= !P!
TIMEOUT /T 5 /NOBREAK
net start RTACDB
pause
::***********************************
:InputPassword
Cls
echo.
echo.
set "psCommand=powershell -Command "$pword = read-host '%1' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
      [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
        for /f "usebackq delims=" %%p in (`%psCommand%`) do set %2=%%p
)
goto :eof     
::***********************************
sc.exe config RTACDB obj= "EMERA\%U%" password= %P%
TIMEOUT /T 5 /NOBREAK
net start RTACDB