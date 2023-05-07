@echo off
chcp 65001

setlocal enabledelayedexpansion

Set firstParametr="%~1"

if %firstParametr% == "help" (goto help)
if %firstParametr% == "/?" (goto help)


Set startDirectory=""
set SHF=0

:parse_args
    if "%~1"=="" goto end_parse_args

    if /i "%~1"=="/SHF" (
        set SHF=1
    ) else Set startDirectory="%~1"

    shift
    goto parse_args
:end_parse_args

echo. 

if %startDirectory% == "" (
    echo У файл не було передано параметр із директорією,&echo тому виконання відбувається відносно поточної папки
    Set startDirectory="%CD%"
) else echo Директорія, що отримана параметром: %startDirectory%

echo. 

rem виклик функції для поточної директорії
call :calcFilesInDirectory %startDirectory% %SHF%

rem рекурсивний перебір усіх підкаталогів
for /d /r %%i in (*) do (
    call :calcFilesInDirectory "%%i" %SHF%
)

:end
pause
exit /b

:calcFilesInDirectory
    cd %1
    Set /a c=0
    echo. 
    cd
    echo. 
    if %2 == 1 echo Файли:
    
    for %%f in (*) do ( 
        if %2 == 1 echo %%f
        Set /a c+=1
    )
    
    echo. 
    echo Кількість файлів: !c!
    echo. 
exit /b

:help
    echo.
    echo Цей batch-скрипт рахує кількість файлів у всіх підкаталогах окремо, починаючи з поточного&echo (або з переданого параметром)

    echo.
    echo Програма приймає першим параметром адресу директорії, в якій необхідно виконати підрахунок.
    echo Якщо цей параметр не задано, програма буде працювати починаючи з поточної директорії.

    echo.
    echo Синтаксис:
    echo Lab3.bat [path] [flag]
    echo.
    echo Серед додаткових прапорів у програми є:
    echo    /SHF - showFile. Програма виводить на екран окрім суми також вміст файлів кожного каталогу.
    echo.
    echo У випадку, коли флаг не вказується, програма не показує імена файлів.
    echo.
    echo Параметри можуть передаватися довільним чином.
    echo.


goto end