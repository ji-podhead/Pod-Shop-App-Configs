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

if __name__ == "__main__":
    dif()