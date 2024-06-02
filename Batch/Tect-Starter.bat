:: Tect Starter made by Tect.host
:: All rights reserved
@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

rem Script version
set "version=1.0.3"

rem Set title
title Tect Starter - Windows

rem If the options file does not exist, create it
if not exist options.txt (
    rem Lang
    echo en > options.txt
    rem Java version
    for /d %%d in ("%ProgramFiles%\Java\*") do (
        set "javav=%%~nd"
    )
    echo !javav! >> options.txt
    rem GUI enabled
    echo false >> options.txt
    rem Server jar
    echo server.jar >> options.txt
    rem Server memory
    echo 2048 >> options.txt
    rem Aikar flags
    echo true >> options.txt
)

rem Get file contents
for /f "usebackq delims=" %%a in ("options.txt") do (
    set /a "lineaCont+=1"
    if !lineaCont! equ 1 (
        set "lang=%%a"
        if defined lang set "lang=!lang:~0,-1!"
    ) else if !lineaCont! equ 2 (
        set "javav=%%a"
        if defined javav set "javav=!javav:~0,-1!"
    ) else if !lineaCont! equ 3 (
        set "gui=%%a"
        if defined gui set "gui=!gui:~0,-1!"
    ) else if !lineaCont! equ 4 (
        set "jar=%%a"
        if defined jar set "jar=!jar:~0,-1!"
    ) else if !lineaCont! equ 5 (
        set "mem=%%a"
        if defined mem set "mem=!mem:~0,-1!"
    ) else if !lineaCont! equ 6 (
        set "aikar=%%a"
        if defined aikar set "aikar=!aikar:~0,-1!"
    )
)

rem Auto Update
set "vurl=https://raw.githubusercontent.com/TectHost/Tect-Starter/main/version.txt"

rem Check if curl is available
where curl >nul 2>nul
if errorlevel 1 (
    if "%lang%" == "en" (
        echo [Tect-Starter] Error: curl is not installed or cannot be found on the system. [#7cdbs]
    ) else if "%lang%" == "es" (
        echo [Tect-Starter] Error: curl no está instalado o no se puede encontrar en el sistema. [#7cdbs]
    )
    exit /b 1
)

rem Extract content using curl
set "content="
for /f "usebackq delims=" %%a in (`curl -s "%vurl%"`) do (
    set "content=!content!%%a"
)

rem Compare current version with downloaded content
if "%version%" neq "%content%" (
    if "%lang%" == "en" (
        echo An update is available
        echo Do you want to download it? [y/n]
    ) else if "%lang%" == "es" (
        echo Hay una actualización disponible
        echo ¿Quieres descargarla? [y/n]
    )

    choice /c yn /N

    if errorlevel 1 (
        set "url=https://raw.githubusercontent.com/TectHost/Tect-Starter/main/Batch/Tect-Starter.bat"
        set "dest=%~dp0Tect-Starter.bat"

        rem Descargar el archivo usando PowerShell
        powershell -Command "Invoke-WebRequest -Uri \"!url!\" -OutFile \"!dest!\""

        rem Verificar si la descarga fue exitosa
        if exist "!dest!" (
            if "%lang%" == "en" (
                echo The file has been downloaded successfully.
            ) else if "%lang%" == "es" (
                echo El archivo se ha descargado correctamente.
            )
        ) else (
            if "%lang%" == "en" (
                echo [Tect-Starter] Error: Error downloading file. [#c78na]
            ) else if "%lang%" == "es" (
                echo [Tect-Starter] Error: Error al descargar el archivo. [#c78na]
            )
        )

        pause
        exit
    )
)

set "home1="
set "home2="
set "home3="
set "home4="
set "home5="
set "home6="

set "home=0"

set "javavexist="

for /d %%d in ("%ProgramFiles%\Java\*") do (
    set "javaFolder=%%~nd"
    if "!javaFolder:Java=!"=="%javav%" (
        set "javavexist=%%~nd"
    )
)

rem ------------------------ { HOME } ------------------------
:HOME
cls
echo ████████ ███████  ██████ ████████     ███████ ████████  █████  ██████  ████████ ███████ ██████  
echo    ██    ██      ██         ██        ██         ██    ██   ██ ██   ██    ██    ██      ██   ██ 
echo    ██    █████   ██         ██        ███████    ██    ███████ ██████     ██    █████   ██████  v!version!
echo    ██    ██      ██         ██             ██    ██    ██   ██ ██   ██    ██    ██      ██   ██ 
echo    ██    ███████  ██████    ██        ███████    ██    ██   ██ ██   ██    ██    ███████ ██   ██ 
echo.
if "!lang!" == "en" (
    echo Select an option:
    echo 1. Start server            %home1%
    echo 2. Configure options       %home2%
    echo 3. Display options         %home3%
    echo 4. Install Java            %home4%
    echo 5. Support                 %home5%
    echo 6. Exit                    %home6%
) else if "!lang!" == "es" (
    echo Selecciona una opción:
    echo 1. Iniciar servidor        %home1%
    echo 2. Configurar opciones     %home2%
    echo 3. Mostrar opciones        %home3%
    echo 4. Instalar Java           %home4%
    echo 5. Soporte                 %home5%
    echo 6. Salida                  %home6%
)

choice /c 123456 /N

if !errorlevel! == 1 (
    goto STARTSERVER
) else if !errorlevel! == 2 (
    goto OPTIONS
) else if !errorlevel! == 3 (
    if !home! == 1 (
        set "home=0"
        set "home1="
        set "home2="
        set "home3="
        set "home4="
        set "home5="
        set "home6="
        goto HOME
    ) else if !home! == 0 (
        set "home=1"
        if "!lang!" == "en" (
            set "home1=Lang: %lang%"
            set "home2=Java Version: %javav%"
            set "home3=GUI enabled: %gui%"
            set "home4=Server JAR file: %jar%"
            set "home5=Server memory: %mem% MB"
            set "home6=Aikar Flags: %aikar%"
        ) else if "!lang!" == "es" (
            set "home1=Idioma: %lang%"
            set "home2=Versión de Java: %javav%"
            set "home3=GUI habilitado: %gui%"
            set "home4=Archivo server JAR: %jar%"
            set "home5=Memoria del servidor: %mem% MB"
            set "home6=Aikar Flags: %aikar%"
        )
        
        goto HOME
    )
) else if !errorlevel! == 4 (
    cls
    if "!lang!" == "en" (
        echo Select Java version to download:
    ) else if "!lang!" == "es" (
        echo Selecciona una versión de Java para descargar:
    )
    echo 1. jdk-22
    echo 2. jdk-21 [recommended]
    echo 3. jdk-17

    choice /c 123 /N

    if !errorlevel! == 1 (
        start "" "https://download.oracle.com/java/22/latest/jdk-22_windows-x64_bin.exe"
        cls
        if "!lang!" == "en" (
            echo When the file is downloaded, press Enter to execute it
        ) else if "!lang!" == "es" (
            echo Cuando se haya descargado el archivo, pulse Intro para ejecutarlo
        )
        pause

        set "archive=jdk-22_windows-x64_bin.exe"
        set "directory=%USERPROFILE%"

        for /r "!archive!" %%a in ("!directory!") do (
            start "" "%%a"
            goto HOME
        )

        if "!lang!" == "en" (
            echo [Tect-Starter] Error: File not found [#c7djs] [!directory!] [!archive!]
        ) else if "!lang!" == "es" (
            echo [Tect-Starter] Error: Archivo no encontrado [#c7djs] [!directory!] [!archive!]
        )
    ) else if !errorlevel! == 2 (
        start "" "https://download.oracle.com/java/21/latest/jdk-21_windows-x64_bin.exe"
        cls
        if "!lang!" == "en" (
            echo When the file is downloaded, press Enter to execute it
        ) else if "!lang!" == "es" (
            echo Cuando se haya descargado el archivo, pulse Intro para ejecutarlo
        )
        pause

        set "archive=jdk-21_windows-x64_bin.exe"
        set "directory=%USERPROFILE%"

        for /r "!archive!" %%a in ("!directory!") do (
            start "" "%%a"
            goto HOME
        )

        if "!lang!" == "en" (
            echo [Tect-Starter] Error: File not found [#g8md1] [!directory!] [!archive!]
        ) else if "!lang!" == "es" (
            echo [Tect-Starter] Error: Archivo no encontrado [#g8md1] [!directory!] [!archive!]
        )
    ) else if !errorlevel! == 3 (
        start "" "https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.exe"
        cls
        if "!lang!" == "en" (
            echo When the file is downloaded, press Enter to execute it
        ) else if "!lang!" == "es" (
            echo Cuando se haya descargado el archivo, pulse Intro para ejecutarlo
        )
        pause

        set "archive=jdk-22_windows-x64_bin.exe"
        set "directory=%USERPROFILE%"

        for /r "!archive!" %%a in ("!directory!") do (
            start "" "%%a"
            goto HOME
        )

        if "!lang!" == "en" (
            echo [Tect-Starter] Error: File not found [#7bd5x] [!directory!] [!archive!]
        ) else if "!lang!" == "es" (
            echo [Tect-Starter] Error: Archivo no encontrado [#7bd5x] [!directory!] [!archive!]
        )
    )

    goto HOME
) else if !errorlevel! == 5 (
    start "" "https://dc.tect.host"
    goto HOME
) else if !errorlevel! == 6 (
    exit
)

rem ------------------------ { START SERVER } ------------------------
:STARTSERVER
cls

if not exist eula.txt (
    echo #By changing the setting below to TRUE you are indicating your agreement to our EULA [https://aka.ms/MinecraftEULA] > eula.txt
    echo #%DATE% >> eula.txt
    echo eula=false >> eula.txt
) 

if exist eula.txt (
    set "eula="
    set lineaCont=0
    for /f "usebackq delims=" %%a in ("eula.txt") do (
        set /a "lineaCont+=1"
        if !lineaCont! equ 3 (
            set "eula=%%a"
            if defined eula (
                set "eula=!eula:~5!"
                set "eula=!eula:~0,-1!"
            )
        )
    )
)

if "!eula!" equ "false" (
    if "!lang!" == "en" (
        echo Do you accept the eula? [y/n] [https://aka.ms/MinecraftEULA]
    ) else if "!lang!" == "es" (
        echo ¿Aceptas el eula? [y/n] [https://aka.ms/MinecraftEULA]
    )

    choice /c yn /N

    if "!errorlevel!" == "1" (
        echo #By changing the setting below to TRUE you are indicating your agreement to our EULA [https://aka.ms/MinecraftEULA] > eula.txt
        echo #%DATE% >> eula.txt
        echo|set /p="eula=true" >> eula.txt

        goto START1
    ) else if "!errorlevel!" == "2" (
        goto HOME
    )
)

:START1
if "!lang!" == "en" (
    echo Starting Minecraft server with Java version %javav%...
) else if "!lang!" == "es" (
    echo Iniciando el servidor de Minecraft con la versión de Java: %javav%...
)

if defined javavexist (
    if "!gui!" == "false" (
        if "!lang!" == "en" (
            echo Starting server...
            echo Options:
            echo Java version: %javav%
            echo GUI enabled: false
            echo Server JAR: !jar!
            echo Server Memory: !mem! MB
            echo Aikar Flags: !aikar!
        ) else if "!lang!" == "es" (
            echo Iniciando servidor...
            echo Opciones:
            echo Versión de Java: %javav%
            echo GUI habilitado: false
            echo Archivo JAR: !jar!
            echo Memoria del servidor: !mem! MB
            echo Aikar Flags: !aikar!
        )
        
        echo.
        if "!aikar!" == "true" (
            "%ProgramFiles%\Java\%javav%\bin\java" -Xms%mem%M -Xmx%mem%M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -jar !jar! --nogui
        ) else (
            "%ProgramFiles%\Java\%javav%\bin\java" -Xmx%mem%M -Xms%mem%M -jar !jar! --nogui
        )
    ) else (
        if "!lang!" == "en" (
            echo Starting server...
            echo Options:
            echo Java version: %javav%
            echo GUI enabled: false
            echo Server JAR: !jar!
            echo Server Memory: !mem! MB
            echo Aikar Flags: !aikar!
        ) else if "!lang!" == "es" (
            echo Iniciando servidor...
            echo Opciones:
            echo Versión de Java: %javav%
            echo GUI habilitado: false
            echo Archivo JAR: !jar!
            echo Memoria del servidor: !mem! MB
            echo Aikar Flags: !aikar!
        )

        echo.
        if "!aikar!" == "true" (
            "%ProgramFiles%\Java\%javav%\bin\java" -Xms%mem%M -Xmx%mem%M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -jar !jar!
        ) else (
            "%ProgramFiles%\Java\%javav%\bin\java" -Xmx%mem%M -Xms%mem%M -jar !jar!
        )
    )
    pause
    goto HOME
) else (
    if "!lang!" == "en" (
        echo Error: Java version %javav% not found.
    ) else if "!lang!" == "es" (
        echo Error: La versión de Java %javav% no se encontró.
    )
    
    pause
    goto HOME
)

rem ------------------------ { OPTIONS } ------------------------
:OPTIONS
cls
if "!lang!" equ "en" (
    echo Select an option to change:
    echo 1. Lang [!lang!]
    echo 2. Java version [!javav!]
    echo 3. GUI [!gui!]
    echo 4. Server JAR [!jar!]
    echo 5. Server memory [!mem! MB]
    echo 6. Aikar Flags [!aikar!]
    echo.
    echo 0. Back
) else if "!lang!" equ "es" (
    echo Selecciona una opción para cambiar:
    echo 1. Idioma [!lang!]
    echo 2. Versión de Java [!javav!]
    echo 3. GUI [!gui!]
    echo 4. Archivo JAR [!jar!]
    echo 5. Memoria del servidor [!mem! MB]
    echo 6. Aikar Flags [!aikar!]
    echo.
    echo 0. Atrás
)

choice /c 0123456 /N

cls

if !errorlevel! equ 1 (
    goto HOME
) else if !errorlevel! == 2 (
    if "!lang!" == "en" (
        echo Options:
        echo - en [default]
        echo - es

        set /p "lang=Select an available lang: "
    ) else if "!lang!" == "es" (
        echo Opciones:
        echo - en [por defecto]
        echo - es

        set /p "lang=Selecciona un idioma disponible: "
    )

    goto OPTIONSFINAL
) else if !errorlevel! == 3 (
    if "!lang!" == "en" (
        echo Options:

        for /d %%d in ("%ProgramFiles%\Java\*") do (
            set "javaFolder=%%~nd"
            echo - !javaFolder:Java=!
        )

        set /p "javav=Select an available java version (jdk... | example: jdk-17): "
    ) else if "!lang!" == "es" (
        echo Opciones:

        for /d %%d in ("%ProgramFiles%\Java\*") do (
            set "javaFolder=%%~nd"
            echo - !javaFolder:Java=!
        )

        set /p "javav=Selecciona una versión de java disponible (jdk... | ejemplo: jdk-17): "
    )

    goto OPTIONSFINAL
) else if !errorlevel! == 4 (
    if "!lang!" == "en" (
        echo Options:
        echo - true
        echo - false [recommended]

        set /p "gui=Select an available option: "
    ) else if "!lang!" == "es" (
        echo Opciones:
        echo - true
        echo -false [recomendado]

        set /p "gui=Selecciona una opción válida: "
    )

    goto OPTIONSFINAL
) else if !errorlevel! == 5 (
    if "!lang!" == "en" (
        echo Options:
        echo - server.jar [recommended]
        echo - *.jar

        set /p "jar=Select an available JAR: "
    ) else if "!lang!" == "es" (
        echo Opciones:
        echo - server.jar [recomendado]
        echo - *.jar

        set /p "jar=Selecciona un JAR: "
    )

    goto OPTIONSFINAL
) else if !errorlevel! == 6 (
    if "!lang!" == "en" (
        echo Options:
        echo - 1024 [minimum]
        echo - 4096 [recommended]
        echo - *

        set /p "mem=Select an available amount of RAM: "
    ) else if "!lang!" == "es" (
        echo Opciones:
        echo - 1024 [mínimo]
        echo - 4096 [recomendado]
        echo - *

        set /p "mem=Selecciona una cantidad de RAM: "
    )

    goto OPTIONSFINAL
) else if !errorlevel! == 7 (
    if "!lang!" == "en" (
        echo Options:
        echo - true [recommended]
        echo - false

        set /p "aikar=Select an available option: "
    ) else if "!lang!" == "es" (
        echo Opciones:
        echo - true [recomendado]
        echo - false

        set /p "aikar=Selecciona una opción válida: "
    )

    goto OPTIONSFINAL
)

:OPTIONSFINAL
echo !lang! > options.txt
echo !javav! >> options.txt
echo !gui! >> options.txt
echo !jar! >> options.txt
echo !mem! >> options.txt
echo !aikar! >> options.txt

goto OPTIONS

rem All rights reserved to Tect.host
endlocal
exit