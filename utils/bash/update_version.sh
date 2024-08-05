#!/bin/bash
GALAXY_YML_PATH="$1"
current_version=$(grep '^version:' $GALAXY_YML_PATH | cut -d'"' -f2)
echo "Old version: $current_version"

IFS='.' read -ra parts <<< "$current_version"
continue=false
for (( i=${#parts[@]}-1; i>=0; i-- )); do
    part=$(( "${parts[i]}" + 1 ))  # part wird inkrementiert
    if [[ ${parts[i]} -gt 98 ]]; then # wenn über max dann continue und aktueller part wird auf null gesetzt
        part=0
        continue=true
    else
        continue=false
    fi
    parts[i]=$part
    if [ "$i" -ne $((${#parts[@]}-1)) ]; then # wenn nicht der letzte part dann kommt ein punkt danach
        part+="."
    fi
    if [ "$continue" = false ]; then # wenn continue falsch dann stop
        break
    fi
done

# Back to string
for (( i=0; i<${#parts[@]}; i++ )); do
    parts[i]=${parts[i]}
done

# Joining parts back into a single string
new_version=$(IFS=. ; echo "${parts[*]}")

echo "New version: $new_version"
sed -i "s/^version:.*/version: \"$new_version\"/" $GALAXY_YML_PATH
