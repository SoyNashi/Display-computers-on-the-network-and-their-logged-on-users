    @ECHO OFF

    ECHO.

     

    :: Windows version check

    IF NOT "%OS%"=="Windows_NT" GOTO Syntax

    ECHO.%* | FIND "?" >NUL

    :: Command line parameter check

    IF NOT ERRORLEVEL 1 GOTO Syntax

    IF NOT [%2]==[] GOTO Syntax

     

    :: Keep variable local

    SETLOCAL

     

    :: Initialize variable

    SET WSS=

     

    :: Parse command line parameter

    IF NOT [%1]==[] FOR /F "tokens=1 delims=\ " %%A IN ('ECHO.%~1') DO SET WSS=%%A

     

    :: Use NET VIEW and NBTSTAT to find computers and logged on users

    FOR /F "tokens=1 delims=\ " %%a IN ('NET VIEW ^| FIND /I "\\%WSS%"') DO FOR /F "tokens=1 delims= " %%A IN ('NBTSTAT -a %%a ^| FIND /I /V "%%a" ^| FIND "<03>"') DO ECHO.%%a    %%A

     

    :: Done

    ENDLOCAL

    GOTO:EOF

     

    :Syntax

    ECHO ACTive USeRs, Version 1.00 for Windows NT

    ECHO Display logged on users and their workstations.

    ECHO.

    ECHO Usage:    ACTUSR  [ filter ]

    ECHO.

    IF     "%OS%"=="Windows_NT" ECHO Where:    filter is the first part of the computer name^(s^) to be displayed

    IF NOT "%OS%"=="Windows_NT" ECHO Where:    filter is the first part of the computer name(s) to be displayed

    ECHO.

    ECHO Example:  ACTUSR PC

    ECHO.

    ECHO PC0001    USERID_1

    ECHO PC0004    USERID_4

    ECHO PC0102    ADMINISTRATOR

    ECHO.

