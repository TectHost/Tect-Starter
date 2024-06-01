# Tect Starter made by Tect.host
# All rights reserved
Clear-Host

# Create options.txt file if not exist
if (-not (Test-Path options.txt)) {
    # Lang
    Write-Output en > options.txt
    # Java version
    $pathJava = "$env:ProgramFiles\Java"
    $directoryJava = Get-ChildItem -Path $pathJava -Directory | Select-Object -ExpandProperty Name

    if ($directoryJava.Count -gt 0) {
        $javav = $directoryJava[0]
    }
    Write-Output "$javav" >> options.txt
    # GUI enabled
    Write-Output false >> options.txt
    # Server jar
    Write-Output server.jar >> options.txt
    # Server memory
    Write-Output 2048 >> options.txt
    # Aikar flags
    Write-Output true >> options.txt
}

$global:home0 = 0

function Inicio {
    Clear-Host
    # Load variables
    $global:lang = Get-Content "options.txt" | Select-Object -Index 0
    $global:javav = Get-Content "options.txt" | Select-Object -Index 1
    $global:gui = Get-Content "options.txt" | Select-Object -Index 2
    $global:jar = Get-Content "options.txt" | Select-Object -Index 3
    $global:mem = Get-Content "options.txt" | Select-Object -Index 4
    $global:aikar = Get-Content "options.txt" | Select-Object -Index 5
    Write-Host "v1.0.0"
    Write-Host
    if ($global:lang -eq "en") {
        Write-Host "Select an option:"
        Write-Host "1. Start server            $home1"
        Write-Host "2. Configure options       $home2"
        Write-Host "3. Display options         $home3"
        Write-Host "4. Install Java            $home4"
        Write-Host "5. Support                 $home5"
        Write-Host "6. Exit                    $home6"
    } elseif ($global:lang -eq "es") {
        Write-Host "Selecciona una opcion:"
        Write-Host "1. Iniciar servidor        $home1"
        Write-Host "2. Configurar opciones     $home2"
        Write-Host "3. Mostrar opciones        $home3"
        Write-Host "4. Instalar Java           $home4"
        Write-Host "5. Soporte                 $home5"
        Write-Host "6. Salida                  $home6"
    }

    $option = choice /c 123456 /N

    if ($option -eq 1) {
        StartServer
    } elseif ($option -eq 2) {
        Options
    } elseif ($option -eq 3) {
        if ($global:home0 -eq 1) {
            $global:home0--
            $home1 = ""
            $home2 = ""
            $home3 = ""
            $home4 = ""
            $home5 = ""
            $home6 = ""
            Inicio
        } elseif ($global:home0 -eq 0) {
            $global:home0++
            if ($global:lang -eq "en") {
                $home1 = "Lang: $global:lang"
                $home2 = "Java Version: $global:javav"
                $home3 = "GUI enabled: $global:gui"
                $home4 = "Server JAR file: $global:jar"
                $home5 = "Server Memory: $global:mem MB"
                $home6 = "Aikar Flags: $global:aikar"
                Inicio
            } elseif ($global:lang -eq "es") {
                $home1 = "Idioma: $global:lang"
                $home2 = "Version de Java: $global:javav"
                $home3 = "GUI habilitado: $global:gui"
                $home4 = "Archivo server JAR: $global:jar"
                $home5 = "Memoria del servidor: $global:mem MB"
                $home6 = "Aikar Flags: $global:aikar"
                Inicio
            }
        }
    } elseif ($option -eq 4) {
        Clear-Host
        if ($global:lang -eq "en") {
            Write-Host Select Java version to download:
        } elseif ($global:lang -eq "es") {
            Write-Host Selecciona una version de Java para descargar:
        }
        Write-Host "1. jdk-22"
        Write-Host "2. jdk-21 [recommended]"
        Write-Host "3. jdk-17"

        $option = choice /c 123 /N

        if ($option -eq 1) {
            Start-Process "https://download.oracle.com/java/22/latest/jdk-22_windows-x64_bin.exe"
            Clear-Host
            if ($global:lang -eq "en") {
                Write-Host "When the file is downloaded, press Enter to execute it"
            } elseif ($global:lang -eq "es") {
                Write-Host "Cuando se haya descargado el archivo, pulse Intro para ejecutarlo"
            }

            Pause
            $fileName = "jdk-22_windows-x64_bin.exe"
            $startDirectory = [System.Environment]::GetFolderPath("UserProfile")
            $filePath = Get-ChildItem -Path $startDirectory -Recurse -Filter $fileName -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName

            # Check if the file was found
            if ($filePath) {
                Write-Host "File found: $filePath"
                # Execute the file
                Start-Process $filePath
                Inicio
            } else {
                Write-Host "[Tect-Starter] Error: File not found. (#0mb3c)" -ForegroundColor Red
                Start-Sleep -Milliseconds 1500
                Inicio
            }
        } elseif ($option -eq 2) {
            Start-Process "https://download.oracle.com/java/21/latest/jdk-21_windows-x64_bin.exe"
            Clear-Host
            if ($global:lang -eq "en") {
                Write-Host "When the file is downloaded, press Enter to execute it"
            } elseif ($global:lang -eq "es") {
                Write-Host "Cuando se haya descargado el archivo, pulse Intro para ejecutarlo"
            }

            Pause
            $fileName = "jdk-21_windows-x64_bin.exe"
            $startDirectory = [System.Environment]::GetFolderPath("UserProfile")
            $filePath = Get-ChildItem -Path $startDirectory -Recurse -Filter $fileName -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName

            # Check if the file was found
            if ($filePath) {
                Write-Host "File found: $filePath"
                # Execute the file
                Start-Process $filePath
                Inicio
            } else {
                Write-Host "[Tect-Starter] Error: File not found. (#8nb4j)" -ForegroundColor Red
                Start-Sleep -Milliseconds 1500
                Inicio
            }
        } elseif ($option -eq 3) {
            Start-Process "https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.exe"
            Clear-Host
            if ($global:lang -eq "en") {
                Write-Host "When the file is downloaded, press Enter to execute it"
            } elseif ($global:lang -eq "es") {
                Write-Host "Cuando se haya descargado el archivo, pulse Intro para ejecutarlo"
            }

            Pause
            $fileName = "jdk-17_windows-x64_bin.exe"
            $startDirectory = [System.Environment]::GetFolderPath("UserProfile")
            $filePath = Get-ChildItem -Path $startDirectory -Recurse -Filter $fileName -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName

            # Check if the file was found
            if ($filePath) {
                Write-Host "File found: $filePath"
                # Execute the file
                Start-Process $filePath
                Inicio
            } else {
                Write-Host "[Tect-Starter] Error: File not found. (#7dh3b)" -ForegroundColor Red
                Start-Sleep -Milliseconds 1500
                Inicio
            }
        }
    } elseif ($option -eq 5) {
        Clear-Host
        Start-Process "https://dc.tect.host/"
        Inicio
    } elseif ($option -eq 6) {
        exit
    }
}

function StartServer {
    Clear-Host
    if ($global:lang -eq "en") {
        Write-Host "Starting Minecraft server with Java version $global:javav..."
    } elseif ($global:lang -eq "es") {
        Write-Host "Iniciando el servidor de Minecraft con la version de Java: $global:javav..."
    }

    if ($global:javav -and $global:javav.Trim() -ne '') {
        if ($global:gui -eq "false") {
            if ($global:lang -eq "en") {
                Write-Host "Starting server..."
                Write-Host "Options:"
                Write-Host "Java version: $global:javav"
                Write-Host "GUI enabled: false"
                Write-Host "Server JAR: $global:jar"
                Write-Host "Server Memory: $global:mem MB"
                Write-Host "Aikar Flags: $global:aikar"
            } elseif ($global:lang -eq "es") {
                Write-Host "Iniciando servidor..."
                Write-Host "Opciones:"
                Write-Host "Version de Java: $global:javav"
                Write-Host "GUI habilitado: false"
                Write-Host "Archivo JAR: $global:jar"
                Write-Host "Memoria del servidor: $global:mem MB"
                Write-Host "Aikar Flags: $global:aikar"
            }

            Write-Host
            if ($global:aikar -eq "true") {
                $javapath = "$env:ProgramFiles\Java\$global:javav\bin\java"
                $arguments = "-Xms${global:mem}M -Xmx${global:mem}M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -jar $global:jar --nogui"

                Start-Process -FilePath $javapath -ArgumentList $arguments
            } else {
                $javaPath = "$env:ProgramFiles\Java\$global:javav\bin\java"
                $arguments = "-Xmx${global:mem}M -Xms${global:mem}M -jar $global:jar --nogui"

                Start-Process -FilePath $javaPath -ArgumentList $arguments
            }
        } else {
            if ($global:lang -eq "en") {
                Write-Host "Starting server..."
                Write-Host "Options:"
                Write-Host "Java version: $global:javav"
                Write-Host "GUI enabled: false"
                Write-Host "Server JAR: $global:jar"
                Write-Host "Server Memory: $global:mem MB"
                Write-Host "Aikar Flags: $global:aikar"
            } elseif ($global:lang -eq "es") {
                Write-Host "Iniciando servidor..."
                Write-Host "Opciones:"
                Write-Host "Version de Java: $global:javav"
                Write-Host "GUI habilitado: false"
                Write-Host "Archivo JAR: $global:jar"
                Write-Host "Memoria del servidor: $global:mem MB"
                Write-Host "Aikar Flags: $global:aikar"
            }

            Write-Host
            if ($global:aikar -eq "true") {
                $javapath = "$env:ProgramFiles\Java\$global:javav\bin\java"
                $arguments = "-Xms${global:mem}M -Xmx${global:mem}M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -jar $global:jar"

                Start-Process -FilePath $javapath -ArgumentList $arguments
            } else {
                $javaPath = "$env:ProgramFiles\Java\$global:javav\bin\java"
                $arguments = "-Xmx${global:mem}M -Xms${global:mem}M -jar $global:jar"

                Start-Process -FilePath $javaPath -ArgumentList $arguments
            }
        }

        Pause
        Inicio
    } else {
        if ($global:lang -eq "en") {
            Write-Host "Error: Java version %javav% not found." -ForegroundColor Red
        } elseif ($global:lang -eq "es") {
            Write-Host "Error: La version de Java %javav% no se encontro." -ForegroundColor Red
        }

        Pause
        Inicio
    }
}

function Options {
    Clear-Host

    if ($global:lang -eq "en") {
        Write-Host "Select an option to change:"
        Write-Host "1. Lang [$global:lang]"
        Write-Host "2. Java version [$global:javav]"
        Write-Host "3. GUI [$global:gui]"
        Write-Host "4. Server JAR [$global:jar]"
        Write-Host "5. Server memory [$global:mem MB]"
        Write-Host "6. Aikar Flags [$global:aikar]"
        Write-Host
        Write-Host "0. Back"
    } elseif ($global:lang -eq "es") {
        Write-Host "Selecciona una opcion para cambiar:"
        Write-Host "1. Idioma [$global:lang]"
        Write-Host "2. Version de Java [$global:javav]"
        Write-Host "3. GUI [$global:gui]"
        Write-Host "4. Archivo JAR [$global:jar]"
        Write-Host "5. Memoria del servidor [$global:mem MB]"
        Write-Host "6. Aikar Flags [$global:aikar]"
        Write-Host
        Write-Host "0. Atras"
    }

    $option = choice /c 0123456 /N

    Clear-Host

    if ($option -eq 0) {
        Inicio
    } elseif ($option -eq 1) {
        if ($global:lang -eq "en") {
            Write-Host "Options:"
            Write-Host "- en [default]"
            Write-Host "- es"

            $global:lang = Read-Host "Select an available lang"
        } elseif ($global:lang -eq "es") {
            Write-Host "Opciones:"
            Write-Host "- en [default]"
            Write-Host "- es"

            $global:lang = Read-Host "Selecciona un idioma disponible"
        }
    } elseif ($option -eq 2) {
        if ($global:lang -eq "en") {
            Write-Host "Options:"

            Get-ChildItem "$env:ProgramFiles\Java" -Directory | ForEach-Object {
                $javaFolder = $_.Name -replace "Java", ""
                Write-Output $javaFolder
            }

            $global:javav = Read-Host "Select an available java version (jdk... | example: jdk-17)"
        } elseif ($global:lang -eq "es") {
            Write-Host "Opciones:"

            Get-ChildItem "$env:ProgramFiles\Java" -Directory | ForEach-Object {
                $javaFolder = $_.Name -replace "Java", ""
                Write-Output $javaFolder
            }

            $global:javav = Read-Host "Selecciona una version valida de Java (jdk... | ejemplo: jdk-17)"
        }
    } elseif ($option -eq 3) {
        if ($global:lang -eq "en") {
            Write-Host Options:
            Write-Host "- true"
            Write-Host "- false [recommended]"

            $global:gui = Read-Host "Select an available option"
        } elseif ($global:lang -eq "es") {
            Write-Host Opciones:
            Write-Host "- true"
            Write-Host "- false [recomendado]"

            $global:gui = Read-Host "Selecciona una opcion valida"
        }
    } elseif ($option -eq 4) {
        if ($global:lang -eq "en") {
            Write-Host "Options:"
            Write-Host "- server.jar [recommended]"
            Write-Host "- *.jar"

            $global:jar = Read-Host "Select an available JAR"
        } elseif ($global:lang -eq "es") {
            Write-Host "Opciones:"
            Write-Host "- server.jar [recomendado]"
            Write-Host "- *.jar"

            $global:jar = Read-Host "Selecciona un JAR"
        }
    } elseif ($option -eq 5) {
        if ($global:lang -eq "en") {
            Write-Host "Options:"
            Write-Host "- 1024 [minimum]"
            Write-Host "- 4096 [recommended]"
            Write-Host "- *"

            $global:mem = Read-Host "Select an available amount of RAM"
        } elseif ($global:lang -eq "es") {
            Write-Host "Opciones:"
            Write-Host "- 1024 [minimo]"
            Write-Host "- 4096 [recomendado]"
            Write-Host "- *"

            $global:mem = Read-Host "Selecciona una cantidad de RAM"
        }
    } elseif ($option -eq 6) {
        if ($global:lang -eq "en") {
            Write-Host "Options:"
            Write-Host "- true [recommended]"
            Write-Host "- false"

            $global:aikar = Read-Host "Select an available option"
        } elseif ($global:lang -eq "es") {
            Write-Host "Opciones:"
            Write-Host "- true [recomendado]"
            Write-Host "- false"

            $global:aikar = Read-Host "Selecciona una opcion valida"
        }
    }

    Write-Output $global:lang > options.txt
    Write-Output $global:javav >> options.txt
    Write-Output $global:gui >> options.txt
    Write-Output $global:jar >> options.txt
    Write-Output $global:mem >> options.txt
    Write-Output $global:aikar >> options.txt
    Options
}

Inicio