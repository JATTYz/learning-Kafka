@echo off
setlocal

set mode=%1

if "%~1" EQU "/m" goto start
goto autoTask
goto option9

:start
echo ****************************MENU****************************
echo * 1. Find Veracrypt.exe location and Set VERAPATH variable *
echo * 2. Set VERAPASS for mounting processing                  *
echo * 3. Display VERAPATH and VERAPASS environment variable    * 
echo * 4. Check the sentinel file path                          *                             
echo * 5. Mount the encrypted container                         *
echo * 6. Dismount the encrypted container                      *
echo * 7. Remove VERAPATH environment variable                  *
echo * 8. Remove VERAPASS environment variable                  * 
echo * 9. Exit                                                  *
echo ************************************************************
set /p choice=Enter your choice (1-9):
if "%choice%"=="1" goto option1
if "%choice%"=="2" goto option2
if "%choice%"=="3" goto option3
if "%choice%"=="4" goto option4
if "%choice%"=="5" goto option5
if "%choice%"=="6" goto option6
if "%choice%"=="7" goto option7
if "%choice%"=="8" goto option8
if "%choice%"=="9" goto :eof

echo Invalid choice. Please try again.
goto start

:option1
where /R "C:\Program Files" veracrypt.exe > %TEMP%\temp.txt
set /P VERA_PATH= < %TEMP%\temp.txt
del %TEMP%\temp.txt
echo The location of VeraCrypt is %VERA_PATH%
goto start

:option2
set /p "Password=Enter your encrypted container passowrd: "
echo You entered: %Password%
goto start

:option3
echo Veracrypt Path: %VERA_PATH%
echo Veracyrpt Container Password: %Password%
goto start

:option4
set "pathCheck=Z:\103803422.txt"

if exist "%pathCheck%" (
    echo File "103803422.txt" exists in the Z:/ drive.
) else (
    echo File "103803422.txt" does not exist in the Z:/ drive.
)
goto start

:option5
set CONTAINER_PATH=C:\Apps\103803422.tc
set SENTINEL_PATH=Z:\103803422.txt

REM Sentinel file does not exist, the system will dismount the container
REM CHECK EXIST REFERENCE: https://superuser.com/questions/1511126/batchfile-about-using-if-exist
if not exist "%SENTINEL_PATH%" (

    REM Mount the 103803422 container in Z: volumn
    REM Command line reference: https://www.veracrypt.fr/en/Command%20Line%20Usage.html
    "%VERA_PATH%" /q /v "%CONTAINER_PATH%" /l z /p "%Password%"

    echo Container %CONTAINER_PATH% mounted successfully in Z: volumn.

) else (
    echo Cannot mount the container due to the drive is already mounted.
)
goto start

:option6
set CONTAINER_PATH=C:\Apps\103803422.tc
set SENTINEL_PATH=Z:\103803422.txt

REM Sentinel file exists, the system will dismount the container
REM CHECK EXIST REFERENCE: https://superuser.com/questions/1511126/batchfile-about-using-if-exist
if exist "%SENTINEL_PATH%" (
   
    REM Dismount the VeraCrypt container
    REM Command line reference: https://www.veracrypt.fr/en/Command%20Line%20Usage.html
    "%VERA_PATH%" /q /d "%SENTINEL_PATH%"
  
    echo Container %CONTAINER_PATH% dismounted successfully.

) else (
    echo Can not dismount the container due to the sentinel value does not exist.
)
goto start


:option7
set VERA_PATH=
echo Successfully Remove VERA PATH
goto start

:option8
set Password=
echo Successfully Remove Password
goto start

:option9
endlocal

:autoTask
set CONTAINER_PATH=C:\Apps\103803422.tc
set SENTINEL_PATH=Z:\103803422.txt
set VERA_LOCATION=C:\Program Files\VeraCrypt\VeraCrypt.exe
set VERA_PASSWORD=103803422

REM Sentinel file exists, will dismount the container
if exist "%SENTINEL_PATH%" (
   
    REM Dismount the VeraCrypt container
    REM Command line reference: https://www.veracrypt.fr/en/Command%20Line%20Usage.html
    "%VERA_LOCATION%" /q /d "%SENTINEL_PATH%"
  
    echo Container %CONTAINER_PATH% dismounted successfully.

)else (

    REM Mount the 103803422 container in Z: volumn
    REM Command line reference: https://www.veracrypt.fr/en/Command%20Line%20Usage.html
    "%VERA_LOCATION%" /q /v "%CONTAINER_PATH%" /l z /p "%VERA_PASSWORD%"

    echo Container %CONTAINER_PATH% mounted successfully in Z: volumn.
)