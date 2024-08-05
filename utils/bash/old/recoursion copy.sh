#!/bin/bash

increment_version_recursive() {
    local parts2=$1
    local index=$2
    local final_version=$3
    echo "Rekursion"

   # echo "${parts2[@]}"
    if (( index > 0 )); then
    echo "Index $index reached sections max val"
    index=$((index - 1))    
    fi
    if (( parts2[index] >= 99 )); then
        parts2[index]=0
        if (( index > 0 )); then
            final_version=($(increment_version_recursive "${parts2}" "$index" "${final_version}"))
        fi
    elif (( parts2[index] < 99 )); then
        parts2[index]=$((parts2[index] + 1))
    fi
        temp="${final_version[$index]}"
        echo $temp
        temp=$((temp - 1))
        echo new $temp    
    if ((index != 2)); then
        final_version[index]="${temp}."
    else
        final_version[index]="${temp}"
    fi
    
   # echo "New Length: ${#final_version[@]}"
   # echo "${final_version[@]}"
    return "${final_version}"
}

echo "------ >> start << -----"
GALAXY_YML_PATH="./galaxy.yml"
current_version=$(grep '^version:' $GALAXY_YML_PATH | cut -d'"' -f2)

IFS='.' read -ra parts <<< "$current_version"
# Initialisieren Sie final_version als Array
final_version=("${parts[@]}")
echo "Old Version: $current_version in String:" "${parts[@]}"
# Passen Sie den Funktionsaufruf an, um das Array korrekt zu behandeln
final_version=($(increment_version_recursive "${parts}" "${#parts[@]}" "${final_version}"))

echo New Version: "${final_version[@]}"
# Optional: Aktualisieren Sie die Datei mit der neuen Version
# sed -i "s/^version:.*/version: \"${final_version[0]}.${final_version[1]}.${final_version[2]}\"/" $GALAXY_YML_PATH
