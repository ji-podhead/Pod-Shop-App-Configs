import yaml
import json
import sys
import subprocess
import os

def dif():
    # Get current commit ID
    result = subprocess.run(['git', 'rev-parse', 'HEAD'], capture_output=True, text=True)
    os.environ['COMMIT_ID'] = result.stdout.strip()

    # Get previous commit ID
    result = subprocess.run(['git', 'rev-list', '--max-parents=0', 'HEAD'], capture_output=True, text=True)
    os.environ['PREV_COMMIT_ID'] = result.stdout.strip().split('\n')[0]

    # Check if requirements.yml has changed
    result = subprocess.run(['git', 'diff', 'HEAD', 'requirements.yml'], capture_output=True, text=True)
    os.environ['CHANGED'] = 'true' if result.stdout.strip() else 'false'


def sort_objects(data):
    """
    Converts the formatted data dictionary into a JSON string.
    """
    for key,val in data.items():
        
    
        print(val)
    #return json.dumps(data, indent=2)

def main():
    """
    Main function to check for command line arguments and execute the necessary steps.
    """
    if len(sys.argv) < 2:
        print("Usage: python script.py <path_to_yml_file>")
        sys.exit(1)
    try:
        dif()
        with open(sys.argv[1], 'r') as file:
            data = json.load(file)
            print(data)
        
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
