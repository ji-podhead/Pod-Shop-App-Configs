import yaml
import sys

def read_and_print_yaml(file_path):
    """
    Reads a YAML file and prints its contents, explicitly showing versions and adhering to the hierarchy defined within the file.
    This function accounts for varying complexities in the YAML structure, ensuring accurate representation of nested dictionaries and lists.
    """
    try:
        with open(file_path, 'r') as file:
            data = yaml.safe_load(file)
            
            # Recursive function to print the nested structure of the YAML data
            def print_structure(data, level=0):
                """
                Traverses the data structure recursively, printing each element based on its type and hierarchy level.
                Handles dictionaries, lists, and scalar values distinctly, maintaining the original structure's integrity.
                """
                if isinstance(data, dict):
                    for key, value in data.items():
                        print('  ' * level + f"{key}:")
                        print_structure(value, level + 1)
                elif isinstance(data, list):
                    for index, item in enumerate(data):
                        print('  ' * level + f"[{index}]:")
                        print_structure(item, level + 1)
                else:
                    print('  ' * level + str(data))
            
            print_structure(data)
    except FileNotFoundError:
        print(f"File '{file_path}' not found.")
    except yaml.YAMLError as error:
        print(f"Error reading YAML file: {error}")

if __name__ == "__main__":
    # Checks if a file path has been passed as an argument
    if len(sys.argv) > 1:
        file_path = sys.argv[1]
        read_and_print_yaml(file_path)
    else:
        print("No file path provided. Specify the path as an argument.")
