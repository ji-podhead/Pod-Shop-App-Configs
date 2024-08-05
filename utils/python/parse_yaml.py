import yaml
import sys

def read_and_format_yaml(file_path):
    """
    Reads a YAML file and formats its contents into a specific dictionary structure, reflecting the hierarchy of package managers and their packages.
    """
    try:
        with open(file_path, 'r') as file:
            data = yaml.safe_load(file)
            
            # Function to format the data structure into the desired output format
            def format_data(data, parent_key='', result={}):
                for key, value in data.items():
                    full_key = f'{parent_key}.{key}' if parent_key else key
                    if isinstance(value, dict):
                        format_data(value, full_key, result)
                    else:
                        result[full_key] = value
                return result
            
            formatted_data = format_data(data)
            return formatted_data
    except FileNotFoundError:
        print(f"File '{file_path}' not found.")
    except yaml.YAMLError as error:
        print(f"Error reading YAML file: {error}")

if __name__ == "__main__":
    # Checks if a file path has been passed as an argument
    if len(sys.argv) > 1:
        file_path = sys.argv[1]
        formatted_data = read_and_format_yaml(file_path)
        print(formatted_data)
    else:
        print("No file path provided. Specify the path as an argument.")
