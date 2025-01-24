@echo off
title Hexam Toolbox - Windows App Installer & Optimizer
color 0A

:: ANSI escape codes for colors
set RED=[31m
set GREEN=[32m
set YELLOW=[33m
set BLUE=[34m
set MAGENTA=[35m
set CYAN=[36m
set NC=[0m

:: Function to print colored text
:print_color
    echo %~1%~2%NC%
    exit /b

:: Main menu
:main_menu
    cls
    call :print_color "%CYAN%" "============================================="
    call :print_color "%YELLOW%" "    Hexam Toolbox - Windows App Installer"
    call :print_color "%CYAN%" "============================================="
    echo.
    call :print_color "%GREEN%" "Select a category to proceed:"
    echo.
    call :print_color "%BLUE%" "1. Install Apps"
    call :print_color "%BLUE%" "2. Optimize Windows"
    call :print_color "%BLUE%" "3. Exit"
    echo.
    set /p choice="Enter your choice (1-3): "

    if "%choice%"=="1" goto install_apps
    if "%choice%"=="2" goto optimize_windows
    if "%choice%"=="3" exit
    goto main_menu

:: Install apps menu
:install_apps
    cls
    call :print_color "%CYAN%" "============================================="
    call :print_color "%YELLOW%" "    Install Apps"
    call :print_color "%CYAN%" "============================================="
    echo.
    call :print_color "%GREEN%" "Select a category to proceed:"
    echo.
    call :print_color "%BLUE%" "1. Install Browsers"
    call :print_color "%BLUE%" "2. Install Media Apps"
    call :print_color "%BLUE%" "3. Install Productivity Apps"
    call :print_color "%BLUE%" "4. Install Development Tools"
    call :print_color "%BLUE%" "5. Install Games"
    call :print_color "%BLUE%" "6. Back to Main Menu"
    echo.
    set /p choice="Enter your choice (1-6): "

    if "%choice%"=="1" goto install_browsers
    if "%choice%"=="2" goto install_media
    if "%choice%"=="3" goto install_productivity
    if "%choice%"=="4" goto install_development
    if "%choice%"=="5" goto install_games
    if "%choice%"=="6" goto main_menu
    goto install_apps

:: Install browsers
:install_browsers
    cls
    call :print_color "%CYAN%" "============================================="
    call :print_color "%YELLOW%" "    Install Browsers"
    call :print_color "%CYAN%" "============================================="
    echo.
    call :print_color "%GREEN%" "Select a browser to install:"
    echo.
    call :print_color "%BLUE%" "1. Google Chrome"
    call :print_color "%BLUE%" "2. Mozilla Firefox"
    call :print_color "%BLUE%" "3. Microsoft Edge"
    call :print_color "%BLUE%" "4. Brave Browser"
    call :print_color "%BLUE%" "5. Opera"
    call :print_color "%BLUE%" "6. Back to Install Apps Menu"
    echo.
    set /p choice="Enter your choice (1-6): "

    if "%choice%"=="1" (
        echo Installing Google Chrome...
        winget install Google.Chrome
        pause
        goto install_browsers
    )
    if "%choice%"=="2" (
        echo Installing Mozilla Firefox...
        winget install Mozilla.Firefox
        pause
        goto install_browsers
    )
    if "%choice%"=="3" (
        echo Installing Microsoft Edge...
        winget install Microsoft.Edge
        pause
        goto install_browsers
    )
    if "%choice%"=="4" (
        echo Installing Brave Browser...
        winget install Brave.Brave
        pause
        goto install_browsers
    )
    if "%choice%"=="5" (
        echo Installing Opera...
        winget install Opera.Opera
        pause
        goto install_browsers
    )
    if "%choice%"=="6" goto install_apps
    goto install_browsers

:: Install media apps
:install_media
    cls
    call :print_color "%CYAN%" "============================================="
    call :print_color "%YELLOW%" "    Install Media Apps"
    call :print_color "%CYAN%" "============================================="
    echo.
    call :print_color "%GREEN%" "Select a media app to install:"
    echo.
    call :print_color "%BLUE%" "1. VLC Media Player"
    call :print_color "%BLUE%" "2. Spotify"
    call :print_color "%BLUE%" "3. OBS Studio"
    call :print_color "%BLUE%" "4. GIMP"
    call :print_color "%BLUE%" "5. Audacity"
    call :print_color "%BLUE%" "6. Back to Install Apps Menu"
    echo.
    set /p choice="Enter your choice (1-6): "

    if "%choice%"=="1" (
        echo Installing VLC Media Player...
        winget install VideoLAN.VLC
        pause
        goto install_media
    )
    if "%choice%"=="2" (
        echo Installing Spotify...
        winget install Spotify.Spotify
        pause
        goto install_media
    )
    if "%choice%"=="3" (
        echo Installing OBS Studio...
        winget install OBSProject.OBSStudio
        pause
        goto install_media
    )
    if "%choice%"=="4" (
        echo Installing GIMP...
        winget install GIMP.GIMP
        pause
        goto install_media
    )
    if "%choice%"=="5" (
        echo Installing Audacity...
        winget install Audacity.Audacity
        pause
        goto install_media
    )
    if "%choice%"=="6" goto install_apps
    goto install_media

:: Optimize Windows
:optimize_windows
    cls
    call :print_color "%CYAN%" "============================================="
    call :print_color "%YELLOW%" "    Optimize Windows"
    call :print_color "%CYAN%" "============================================="
    echo.
    call :print_color "%GREEN%" "Select an optimization option:"
    echo.
    call :print_color "%BLUE%" "1. Disable Telemetry"
    call :print_color "%BLUE%" "2. Clean Temporary Files"
    call :print_color "%BLUE%" "3. Disable Cortana"
    call :print_color "%BLUE%" "4. Disable Windows Tips"
    call :print_color "%BLUE%" "5. Back to Main Menu"
    echo.
    set /p choice="Enter your choice (1-5): "

    if "%choice%"=="1" (
        echo Disabling Telemetry...
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
        echo Telemetry disabled!
        pause
        goto optimize_windows
    )
    if "%choice%"=="2" (
        echo Cleaning Temporary Files...
        rd /s /q %temp%
        del /s /q %systemroot%\temp\*.*
        echo Temporary files cleaned up!
        pause
        goto optimize_windows
    )
    if "%choice%"=="3" (
        echo Disabling Cortana...
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
        echo Cortana disabled!
        pause
        goto optimize_windows
    )
    if "%choice%"=="4" (
        echo Disabling Windows Tips...
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
        echo Windows Tips disabled!
        pause
        goto optimize_windows
    )
    if "%choice%"=="5" goto main_menu
    goto optimize_windows
