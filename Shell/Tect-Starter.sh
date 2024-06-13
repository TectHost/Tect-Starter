#!/bin/bash

# Set UTF-8 encoding
export LANG=en_US.UTF-8

version="1.0.4"

# Function to create options file if it doesn't exist
create_options_file() {
    if [ ! -f options.txt ]; then
        echo "en" > options.txt
        
        # Find Java version
        for d in /usr/lib/jvm/*; do
            if [ -d "$d" ]; then
                javav=$(basename "$d")
                break
            fi
        done
        
        echo "$javav" >> options.txt
        echo "false" >> options.txt
        echo "server.jar" >> options.txt
        echo "2048" >> options.txt
        echo "true" >> options.txt
        echo "2" >> options.txt
    fi
}

# Function to read options file
read_options_file() {
    lineaCont=0
    while IFS= read -r line; do
        ((lineaCont++))
        case $lineaCont in
            1) lang=${line} ;;
            2) javav=${line} ;;
            3) gui=${line} ;;
            4) jar=${line} ;;
            5) mem=${line} ;;
            6) aikar=${line} ;;
            7) cpu=${line}
        esac
    done < options.txt
}

# Create options file if it doesn't exist
create_options_file

# Read options file
read_options_file

# Auto update
vurl="https://raw.githubusercontent.com/TectHost/Tect-Starter/main/version.txt"

# Check if curl is available
if ! command -v curl &> /dev/null; then
    if [ "$lang" == "en" ]; then
        echo "[Tect-Starter] Error: curl is not installed or cannot be found on the system. [#7cdbs]"
    elif [ "$lang" == "es" ]; then
        echo "[Tect-Starter] Error: curl no está instalado o no se puede encontrar en el sistema. [#7cdbs]"
    fi
    exit 1
fi

# Extract content using curl
content=$(curl -s "$vurl")

# Compare current version with downloaded content
if [ "$version" != "$content" ]; then
    clear
    if [ "$lang" == "en" ]; then
        echo "An update is available"
        echo "Do you want to download it? [y/n]"
    elif [ "$lang" == "es" ]; then
        echo "Hay una actualización disponible"
        echo "¿Quieres descargarla? [y/n]"
    fi

    read -r -p "" choice

    if [ "$choice" == "y" ]; then
        url="https://raw.githubusercontent.com/TectHost/Tect-Starter/main/Shell/Tect-Starter.sh"
        dest="$(dirname "$0")/Tect-Starter.sh"

        # Descargar el archivo usando wget
        wget -q -O "$dest" "$url"

        # Verificar si la descarga fue exitosa
        if [ -f "$dest" ]; then
            if [ "$lang" == "en" ]; then
                echo "The file has been downloaded successfully."
            elif [ "$lang" == "es" ]; then
                echo "El archivo se ha descargado correctamente."
            fi
        else
            if [ "$lang" == "en" ]; then
                echo "[Tect-Starter] Error: Error downloading file. [#c78na]"
            elif [ "$lang" == "es" ]; then
                echo "[Tect-Starter] Error: Error al descargar el archivo. [#c78na]"
            fi
        fi
    fi
fi

home=0

# Function to display home menu
display_home_menu() {
    clear
    echo "████████ ███████  ██████ ████████     ███████ ████████  █████  ██████  ████████ ███████ ██████  "
    echo "   ██    ██      ██         ██        ██         ██    ██   ██ ██   ██    ██    ██      ██   ██ "
    echo "   ██    █████   ██         ██        ███████    ██    ███████ ██████     ██    █████   ██████  v$version"
    echo "   ██    ██      ██         ██             ██    ██    ██   ██ ██   ██    ██    ██      ██   ██ "
    echo "   ██    ███████  ██████    ██        ███████    ██    ██   ██ ██   ██    ██    ███████ ██   ██ "
    echo
    if [ "$lang" = "en" ]; then
        echo "Select an option:"
        echo "1. Start server"
        echo "2. Configure options"
        echo "3. Display options"
        echo "4. Install Java"
        echo "5. Support"
        echo "6. Exit"
    elif [ "$lang" = "es" ]; then
        echo "Selecciona una opción:"
        echo "1. Iniciar servidor"
        echo "2. Configurar opciones"
        echo "3. Mostrar opciones"
        echo "4. Instalar Java"
        echo "5. Soporte"
        echo "6. Salir"
    fi
}

# Function to display options menu
display_options_menu() {
    clear
    if [ "$lang" = "en" ]; then
        echo "Select an option to change:"
        echo "1. Lang [${lang}]"
        echo "2. Java version [${javav}]"
        echo "3. GUI [${gui}]"
        echo "4. Server JAR [${jar}]"
        echo "5. Server memory [${mem} MB]"
        echo "6. Aikar Flags [${aikar}]"
        echo "7. CPU [${cpu} cores]"
        echo
        echo "0. Back"
    elif [ "$lang" = "es" ]; then
        echo "Selecciona una opción para cambiar:"
        echo "1. Idioma [${lang}]"
        echo "2. Versión de Java [${javav}]"
        echo "3. GUI [${gui}]"
        echo "4. Archivo JAR [${jar}]"
        echo "5. Memoria del servidor [${mem} MB]"
        echo "6. Aikar Flags [${aikar}]"
        echo "7. CPU [${cpu} núcleos]"
        echo
        echo "0. Atrás"
    fi
}

# Function to handle changing options
change_option() {
    case $1 in
        1)
            if [ "$lang" = "en" ]; then
                echo "Options:"
                echo "- en [default]"
                echo "- es"
                read -p "Select an available lang: " lang
            elif [ "$lang" = "es" ]; then
                echo "Opciones:"
                echo "- en [por defecto]"
                echo "- es"
                read -p "Selecciona un idioma disponible: " lang
            fi
            ;;
        2)
            if [ "$lang" = "en" ]; then
                echo "Options:"
                for d in /usr/lib/jvm/*; do
                    if [ -d "$d" ]; then
                        echo "- $(basename "$d")"
                    fi
                done
                read -p "Select an available java version: " javav
            elif [ "$lang" = "es" ]; then
                echo "Opciones:"
                for d in /usr/lib/jvm/*; do
                    if [ -d "$d" ]; then
                        echo "- $(basename "$d")"
                    fi
                done
                read -p "Selecciona una versión de java disponible: " javav
            fi
            ;;
        3)
            if [ "$lang" = "en" ]; then
                echo "Options:"
                echo "- true"
                echo "- false [recommended]"
                read -p "Select an available option: " gui
            elif [ "$lang" = "es" ]; then
                echo "Opciones:"
                echo "- true"
                echo "- false [recomendado]"
                read -p "Selecciona una opción válida: " gui
            fi
            ;;
        4)
            if [ "$lang" = "en" ]; then
                echo "Options:"
                echo "- server.jar [recommended]"
                echo "- *.jar"
                read -p "Select an available JAR: " jar
            elif [ "$lang" = "es" ]; then
                echo "Opciones:"
                echo "- server.jar [recomendado]"
                echo "- *.jar"
                read -p "Selecciona un JAR: " jar
            fi
            ;;
        5)
            if [ "$lang" = "en" ]; then
                echo "Options:"
                echo "- 1024 [minimum]"
                echo "- 4096 [recommended]"
                echo "- *"
                read -p "Select an available amount of RAM: " mem
            elif [ "$lang" = "es" ]; then
                echo "Opciones:"
                echo "- 1024 [mínimo]"
                echo "- 4096 [recomendado]"
                echo "- *"
                read -p "Selecciona una cantidad de RAM: " mem
            fi
            ;;
        6)
            if [ "$lang" = "en" ]; then
                echo "Options:"
                echo "- true [recommended]"
                echo "- false"
                read -p "Select an available option: " aikar
            elif [ "$lang" = "es" ]; then
                echo "Opciones:"
                echo "- true [recomendado]"
                echo "- false"
                read -p "Selecciona una opción válida: " aikar
            fi
            ;;
        7)
            if [ "$lang" = "en" ]; then
                echo "Options:"
                echo "- *"
                echo "- unlimited [recommended]"
                read -p "Select an available option: " cpu
            elif [ "$lang" = "es" ]; then
                echo "Opciones:"
                echo "- *"
                echo "- unlimited [recomendado]"
                read -p "Selecciona una opción válida: " cpu
            fi
            ;;
    esac

    # Save options to file
    echo "$lang" > options.txt
    echo "$javav" >> options.txt
    echo "$gui" >> options.txt
    echo "$jar" >> options.txt
    echo "$mem" >> options.txt
    echo "$aikar" >> options.txt
    echo "$cpu" >> options.txt
}

# Function to start the server
start_server() {
    clear

    if [ "$cpu" != "unlimited" ]; then
        affinityValue=$(( (1 << cpu) - 1 ))
        cpu_affinity=$(printf "0x%x" "$affinityValue")
    fi

    if [ ! -f eula.txt ]; then
        echo "#By changing the setting below to TRUE you are indicating your agreement to our EULA [https://aka.ms/MinecraftEULA]" > eula.txt
        echo "#$(date)" >> eula.txt
        echo "eula=false" >> eula.txt
    fi

    eula=$(grep -i 'eula=' eula.txt | cut -d= -f2)
    
    if [ "$eula" = "false" ]; then
        if [ "$lang" = "en" ]; then
            echo "Do you accept the eula? [y/n] [https://aka.ms/MinecraftEULA]"
        elif [ "$lang" = "es" ]; then
            echo "¿Aceptas el eula? [y/n] [https://aka.ms/MinecraftEULA]"
        fi
        
        read -n 1 -s choice
        echo
        
        if [ "$choice" = "y" ]; then
            echo "#By changing the setting below to TRUE you are indicating your agreement to our EULA [https://aka.ms/MinecraftEULA]" > eula.txt
            echo "#$(date)" >> eula.txt
            echo "eula=true" >> eula.txt
        else
            return
        fi
    fi

    if [ "$lang" = "en" ]; then
        echo "Starting Minecraft server with Java version ${javav}..."
    elif [ "$lang" = "es" ]; then
        echo "Iniciando servidor de Minecraft con la versión de Java ${javav}..."
    fi
    
    command="java -Xms${mem}M -Xmx${mem}M"

    if [ "$aikar" = "true" ]; then
        command="${command} -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"
    fi

    command="${command} -jar ${jar}"

    if [ "$gui" = "false" ]; then
        command="${command} nogui"
    fi

    if [ -n "$cpu_affinity" ]; then
        if [ "$lang" = "en" ]; then
            echo "Starting Java Server with CPU affinity $cpu_affinity ($cpu cores)"
        elif [ "$lang" = "es" ]; then
            echo "Iniciando servidor de Java con CPU affinity $cpu_affinity ($cpu núcleos)"
        fi
        eval "taskset $cpu_affinity $command"
    else
        if [ "$lang" = "en" ]; then
            echo "Starting Java Server without CPU affinity"
        elif [ "$lang" = "es" ]; then
            echo "Iniciando servidor de Java sin CPU affinity"
        fi
        eval "$command"
    fi
}

# Java versions installer
install_java() {
    clear
    if [ "$lang" = "en" ]; then
        echo "Select a Java version to install:"
        echo "1. Java 17"
        echo "2. Java 21"
        echo "3. Java 22"
        echo "0. Back"
    elif [ "$lang" = "es" ]; then
        echo "Selecciona una versión de Java para instalar:"
        echo "1. Java 17"
        echo "2. Java 21"
        echo "3. Java 22"
        echo "0. Atrás"
    fi
    
    read -n 1 -s java_choice
    echo
    
    case $java_choice in
        1)
            if [ "$lang" = "en" ]; then
                echo "Installing Java 17..."
            elif [ "$lang" = "es" ]; then
                echo "Instalando Java 17..."
            fi
            sudo apt-get update
            sudo apt-get install -y openjdk-17-jre-headless
            ;;
        2)
            if [ "$lang" = "en" ]; then
                echo "Installing Java 21..."
            elif [ "$lang" = "es" ]; then
                echo "Instalando Java 21..."
            fi
            sudo add-apt-repository -y ppa:openjdk-r/ppa
            sudo apt-get update
            sudo apt-get install -y openjdk-21-jre-headless
            ;;
        3)
            if [ "$lang" = "en" ]; then
                echo "Installing Java 22..."
            elif [ "$lang" = "es" ]; then
                echo "Instalando Java 22..."
            fi
            sudo add-apt-repository -y ppa:openjdk-r/ppa
            sudo apt-get update
            sudo apt-get install -y openjdk-22-jre-headless
            ;;
        0)
            return
            ;;
    esac
}

# Main loop
while [ "$home" -eq 0 ]; do
    display_home_menu
    
    read -n 1 -s choice
    echo
    
    case $choice in
        1) start_server ;;
        2)
            display_options_menu
            read -n 1 -s option_choice
            echo
            if [ "$option_choice" -ne 0 ]; then
                change_option $option_choice
            fi
            ;;
        3)
            clear
            cat options.txt
            read -n 1 -s
            ;;
        4)
            install_java
            ;;
        5)
            clear
            xdg-open "https://dc.tect.host/"
            ;;
        6) home=1 ;;
    esac
done
