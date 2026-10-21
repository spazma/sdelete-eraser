@echo off
color E0
chcp 65001 >nul
TITLE SDelete - Secure File Eraser

:: ==========================================
::         SEKCJA KONFIGURACJI ZMIENNYCH
:: ==========================================
set "SDELETE_BIN=sdelete64.exe"
set "START_WAIT=10"
set "END_WAIT=10"
:: ==========================================

echo.
echo    ========================================================================================================
echo   ░██████╗██████╗░███████╗██╗░░░░░███████╗████████╗███████╗  ███████╗██████╗░░█████╗░░██████╗███████╗██████╗░
echo   ██╔════╝██╔══██╗██╔════╝██║░░░░░██╔════╝╚══██╔══╝██╔════╝  ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗
echo   ╚█████╗░██║░░██║█████╗░░██║░░░░░█████╗░░░░░██║░░░█████╗░░  █████╗░░██████╔╝███████║╚█████╗░█████╗░░██████╔╝
echo   ░╚═══██╗██║░░██║██╔══╝░░██║░░░░░██╔══╝░░░░░██║░░░██╔══╝░░  ██╔══╝░░██╔══██╗██╔══██║░╚═══██╗██╔══╝░░██╔══██╗
echo   ██████╔╝██████╔╝███████╗███████╗███████╗░░░██║░░░███████╗  ███████╗██║░░██║██║░░██║██████╔╝███████╗██║░░██║
echo   ╚═════╝░╚═════╝░╚══════╝╚══════╝╚══════╝░░░╚═╝░░░╚══════╝  ╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░╚═╝
echo    ========================================================================================================
echo.
echo  [+] SYSTEM      : Inicjalizacja procedury niszczenia danych...
echo  [+] TARGET      : ^> [%~nx1] ^<
echo  [+] ALGORYTM    : DoD 5220.22-M (1-pass overwrite)
echo.
echo  ----------------------------------------------------------------------

:: Sprawdzenie czy wybrano plik czy katalog
IF EXIST "%~1\*" (
    REM To jest katalog - zliczamy pliki rekurencyjnie
    echo  [*] Skanowanie struktury katalogu...
    set /a count=0
    for /R "%~1" %%F in (*) do set /a count+=1
) ELSE (
    REM To jest pojedynczy plik
    set /a count=1
)

echo  [*] Wykryto plików do przetworzenia : ^> %count% ^<
echo  ----------------------------------------------------------------------
echo.

echo  ======================================================================
echo   [!] WARNING: BEZPOWROTNA UTRATA DANYCH!
echo   [!] Wybrany [%~nx1] (ilość: ^> %count% ^<) 
echo   [!] zostanie trwale i nieodwracalnie usunięty!
echo   [!] Naciśnij CTRL+C, aby ANULOWAĆ lub X myszą!
echo  ======================================================================
echo.
echo ANULUJ masz (%START_WAIT% sekund):
echo.

setlocal enabledelayedexpansion
set "bar="

:: Pasek startowy rośnie po 1 znaczku co sekundę
for /L %%i in (1,1,%START_WAIT%) do (
    set "bar=!bar!█"
    <nul set /p "=!bar!"
    timeout /t 1 >nul
)
endlocal
cls

echo.
echo    ========================================================================================================
echo   ░██████╗██████╗░███████╗██╗░░░░░███████╗████████╗███████╗  ███████╗██████╗░░█████╗░░██████╗███████╗██████╗░
echo   ██╔════╝██╔══██╗██╔════╝██║░░░░░██╔════╝╚══██╔══╝██╔════╝  ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗
echo   ╚█████╗░██║░░██║█████╗░░██║░░░░░█████╗░░░░░██║░░░█████╗░░  █████╗░░██████╔╝███████║╚█████╗░█████╗░░██████╔╝
echo   ░╚═══██╗██║░░██║██╔══╝░░██║░░░░░██╔══╝░░░░░██║░░░██╔══╝░░  ██╔══╝░░██╔══██╗██╔══██║░╚═══██╗██╔══╝░░██╔══██╗
echo   ██████╔╝██████╔╝███████╗███████╗███████╗░░░██║░░░███████╗  ███████╗██║░░██║██║░░██║██████╔╝███████╗██║░░██║
echo   ╚═════╝░╚═════╝░╚══════╝╚══════╝╚══════╝░░░╚═╝░░░╚══════╝  ╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░╚═╝
echo    ========================================================================================================
echo.
echo  [+] SYSTEM      : Inicjalizacja procedury niszczenia danych...
echo  [+] TARGET      : ^> [%~nx1] ^<
echo  [+] ALGORYTM    : DoD 5220.22-M (1-pass overwrite)
echo.
echo  ----------------------------------------------------------------------

color 0A

:: Wywołanie SDelete dla pliku lub katalogu z rekurencją (-s) i wymuszeniem (-r)
IF EXIST "%~1\*" (
    %SDELETE_BIN% -s -r -p 1 -q "%~1"
) else (
    %SDELETE_BIN% -p 1 -q "%~1"
)

set "EXIT_CODE=%ERRORLEVEL%"

if %EXIT_CODE% EQU 0 (
    color 0A
    echo  [ OK ] EXECUTION SUCCESSFUL!
    echo  [ OK ] Bezpiecznie skasowano łącznie: ^> %count% ^< plików.
) else (
    color 4F
    echo  [ FAIL ] EXECUTION ERROR!
    echo  [ FAIL ] Operacja przerwana. Kod błędu: %EXIT_CODE%
)

echo  ----------------------------------------------------------------------
echo.

setlocal enabledelayedexpansion
set "bar="

:: Pasek zamknięcia rośnie po 1 znaczku co sekundę
for /L %%i in (1,1,%END_WAIT%) do (
    set "bar=!bar!█"
    <nul set /p "=!bar!"
    timeout /t 1 >nul
)
endlocal