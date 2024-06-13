# Tect Starter made by Tect.host
# All rights reserved
Clear-Host

$global:version = "1.0.4"

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
    # CPU cores
    Write-Output unlimited >> options.txt
}

# Load variables
$global:lang = Get-Content "options.txt" | Select-Object -Index 0
$global:javav = Get-Content "options.txt" | Select-Object -Index 1
$global:gui = Get-Content "options.txt" | Select-Object -Index 2
$global:jar = Get-Content "options.txt" | Select-Object -Index 3
$global:mem = Get-Content "options.txt" | Select-Object -Index 4
$global:aikar = Get-Content "options.txt" | Select-Object -Index 5
$global:cpu = Get-Content "options.txt" | Select-Object -Index 6

# Definir la URL del archivo de versión
$vurl = "https://raw.githubusercontent.com/TectHost/Tect-Starter/main/version.txt"

# Comprobar si Invoke-WebRequest está disponible
if (-not (Get-Command Invoke-WebRequest -ErrorAction SilentlyContinue)) {
    if ($global:lang -eq "es") {
        Write-Output "[Tect-Starter] Error: Invoke-WebRequest no está disponible o no se puede encontrar en el sistema. [#7cdbs]"
    } else {
        Write-Output "[Tect-Starter] Error: Invoke-WebRequest is not available or cannot be found on the system. [#7cdbs]"
    }
    exit 1
}

# Extraer el contenido usando Invoke-WebRequest
$content = Invoke-WebRequest -Uri $vurl

# Comparar la versión actual con el contenido descargado
if ($global:version -ne $content) {
    if ($global:lang -eq "es") {
        Write-Output "Hay una actualización disponible"
        Write-Output "¿Quieres descargarla? [y/n]"
    } else {
        Write-Output "An update is available"
        Write-Output "Do you want to download it? [y/n]"
    }

    $choice = choice /c yn /N
    
    if ($choice -eq "y") {
        $url = "https://raw.githubusercontent.com/TectHost/Tect-Starter/main/PowerShell/Tect-Starter.ps1"
        $dest = "$PSScriptRoot\Tect-Starter.ps1"

        # Descargar el archivo usando Invoke-WebRequest
        Invoke-WebRequest -Uri $url -OutFile $dest

        # Verificar si la descarga fue exitosa
        if (Test-Path $dest) {
            if ($global:lang -eq "es") {
                Write-Output "El archivo se ha descargado correctamente."
            } else {
                Write-Output "The file has been downloaded successfully."
            }
        } else {
            if ($global:lang -eq "es") {
                Write-Output "[Tect-Starter] Error: Error al descargar el archivo. [#c78na]"
            } else {
                Write-Output "[Tect-Starter] Error: Error downloading file. [#c78na]"
            }
        }
        Read-Host -Prompt "Press Enter to continue..."
        exit
    }
}

$global:home0 = 0

function Inicio {
    Clear-Host

    Write-Host "$global:version"
    Write-Host
    if ($global:lang -eq "en") {
        Write-Host "Select an option:"
        Write-Host "1. Start server            $home1"
        Write-Host "2. Configure options       $home2"
        Write-Host "3. Display options         $home3"
        Write-Host "4. Install Java            $home4"
        Write-Host "5. Support                 $home5"
        Write-Host "6. Exit                    $home6"
        if ($global:home0 -eq 1) {
            Write-Host "                           $home7"
        }
    } elseif ($global:lang -eq "es") {
        Write-Host "Selecciona una opcion:"
        Write-Host "1. Iniciar servidor        $home1"
        Write-Host "2. Configurar opciones     $home2"
        Write-Host "3. Mostrar opciones        $home3"
        Write-Host "4. Instalar Java           $home4"
        Write-Host "5. Soporte                 $home5"
        Write-Host "6. Salida                  $home6"
        if ($global:home0 -eq 1) {
            Write-Host "                           $home7"
        }
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
            $home7 = ""
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
                $home7 = "CPU: $global:cpu cores"
                Inicio
            } elseif ($global:lang -eq "es") {
                $home1 = "Idioma: $global:lang"
                $home2 = "Version de Java: $global:javav"
                $home3 = "GUI habilitado: $global:gui"
                $home4 = "Archivo server JAR: $global:jar"
                $home5 = "Memoria del servidor: $global:mem MB"
                $home6 = "Aikar Flags: $global:aikar"
                $home7 = "CPU: $global:cpu nucleos"
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

    # CPU number to CPU hex code, ex: 0x3
    if ($global:cpu -ne "unlimited") {
        $affinityValue = [math]::pow(2, $global:cpu) - 1
        $global:cpu_affinity = "0x{0:X}" -f $affinityValue.ToString()
    }

    if (-not (Test-Path eula.txt)) {
        Write-Output "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA)." > eula.txt
        Write-Output "#$(Get-Date)" >> eula.txt
        Write-Output "eula=false" >> eula.txt
    }

    if (Test-Path eula.txt) {
        $global:eula = Get-Content "eula.txt" | Select-Object -Index 2
        $global:eula = $global:eula.Substring(5)
    }

    if ($global:eula -eq "false") {
        if ($global:lang -eq "en") {
            Write-Host "Do you accept the eula? [y/n] (https://aka.ms/MinecraftEULA)"
        } elseif ($global:lang -eq "es") {
            Write-Host "Aceptas el eula? [y/n] (https://aka.ms/MinecraftEULA)"
        }

        $option = choice /c yn /N

        if ($option -eq "y") {
            Write-Output "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA)." | Out-File -FilePath "eula.txt" -Encoding utf8
            Write-Output "#$(Get-Date)" | Out-File -FilePath "eula.txt" -Append -Encoding utf8
            Write-Output "eula=true" | Out-File -FilePath "eula.txt" -Append -Encoding utf8
        } elseif ($option -eq "n") {
            Inicio
        }
    }

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
                Write-Host "CPU: $global:cpu cores"
            } elseif ($global:lang -eq "es") {
                Write-Host "Iniciando servidor..."
                Write-Host "Opciones:"
                Write-Host "Version de Java: $global:javav"
                Write-Host "GUI habilitado: false"
                Write-Host "Archivo JAR: $global:jar"
                Write-Host "Memoria del servidor: $global:mem MB"
                Write-Host "Aikar Flags: $global:aikar"
                Write-Host "CPU: $global:cpu nucleos"
            }

            Write-Host
            if ($global:aikar -eq "true") {
                $javapath = "$env:ProgramFiles\Java\$global:javav\bin\java"
                $arguments = "-Xms${global:mem}M -Xmx${global:mem}M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -jar $global:jar --nogui"

                if ($global:cpu -ne "unlimited") {
                    $arguments += " -affinity $global:cpu_affinity"
                }

                Start-Process -FilePath $javapath -ArgumentList $arguments
            } else {
                $javaPath = "$env:ProgramFiles\Java\$global:javav\bin\java"
                $arguments = "-Xmx${global:mem}M -Xms${global:mem}M -jar $global:jar --nogui"

                if ($global:cpu -ne "unlimited") {
                    $arguments += " -affinity $global:cpu_affinity"
                }

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
                Write-Host "CPU: $global:cpu cores"
            } elseif ($global:lang -eq "es") {
                Write-Host "Iniciando servidor..."
                Write-Host "Opciones:"
                Write-Host "Version de Java: $global:javav"
                Write-Host "GUI habilitado: false"
                Write-Host "Archivo JAR: $global:jar"
                Write-Host "Memoria del servidor: $global:mem MB"
                Write-Host "Aikar Flags: $global:aikar"
                Write-Host "CPU: $global:cpu nucleos"
            }

            Write-Host
            if ($global:aikar -eq "true") {
                $javapath = "$env:ProgramFiles\Java\$global:javav\bin\java"
                $arguments = "-Xms${global:mem}M -Xmx${global:mem}M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -jar $global:jar"

                if ($global:cpu -ne "unlimited") {
                    $arguments += " -affinity $global:cpu_affinity"
                }

                Start-Process -FilePath $javapath -ArgumentList $arguments
            } else {
                $javaPath = "$env:ProgramFiles\Java\$global:javav\bin\java"
                $arguments = "-Xmx${global:mem}M -Xms${global:mem}M -jar $global:jar"

                if ($global:cpu -ne "unlimited") {
                    $arguments += " -affinity $global:cpu_affinity"
                }

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
        Write-Host "7. CPU [$global:cpu cores]"
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
        Write-Host "7. CPU [$global:cpu nucleos]"
        Write-Host
        Write-Host "0. Atras"
    }

    $option = choice /c 01234567 /N

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
    } elseif ($option -eq 7) {
        if ($global:lang -eq "en") {
            Write-Host "Options:"
            Write-Host "- *"
            Write-Host "- unlimited [recommended]"

            $global:cpu = Read-Host "Select a valid number of cores"
        } elseif ($global:lang -eq "es") {
            Write-Host "Opciones:"
            Write-Host "- *"
            Write-Host "- unlimited [recomendado]"

            $global:cpu = Read-Host "Ingresa una cantidad de nucleos valida"
        }
    }

    Write-Output $global:lang > options.txt
    Write-Output $global:javav >> options.txt
    Write-Output $global:gui >> options.txt
    Write-Output $global:jar >> options.txt
    Write-Output $global:mem >> options.txt
    Write-Output $global:aikar >> options.txt
    Write-Output $global:cpu >> options.txt
    Options
}

Inicio