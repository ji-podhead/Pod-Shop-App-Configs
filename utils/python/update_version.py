import sys
import re
from pathlib import Path

def increment_version(yml_path):
    with open(yml_path, 'r') as file:
        content = file.read()
    
    match = re.search(r'^version:\s*"([^"]+)"', content, re.MULTILINE)
    if not match:
        print("Version not found in the YAML file.")
        return
    
    current_version = match.group(1)
    new_version = increment_version_number(current_version)
    
    updated_content = re.sub(r'^version:\s*".*"', f'version: "{new_version}"', content, flags=re.MULTILINE)
    
    with open(yml_path, 'w') as file:
        file.write(updated_content)

def increment_version_number(version_str):
    parts = version_str.split('.')
    major = int(parts[0])
    minor = int(parts[1])
    patch = int(parts[2])
    
    if patch < 99:
        patch += 1
    elif minor < 99:
        minor += 1
        patch = 0
    else:
        major += 1
        minor = 0
        patch = 0
    
    return f"{major}.{minor}.{patch}"

if __name__ == "__main__":
    yml_path = sys.argv[1]
    increment_version(Path(yml_path))
