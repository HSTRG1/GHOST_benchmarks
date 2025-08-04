import re
import os
import argparse

def get_includes(content):
    include_pattern = r'`include\s+"(.+?)"'
    return re.findall(include_pattern, content)

def get_file_content(file_path):
    with open(file_path, 'r') as file:
        return file.read()

def process_verilog_file(file_path, processed_files, exclude_files):
    if file_path in processed_files:
        return get_file_content(file_path)
    
    processed_files.add(file_path)
    
    content = get_file_content(file_path)
    includes = get_includes(content)
    
    for include in includes:
        if include in exclude_files:
            continue
        include_path = os.path.join(os.path.dirname(file_path), include)
        if os.path.exists(include_path):
            include_content = get_file_content(include_path)
            include_pattern = f'`include\\s+"{include}"'
            content = re.sub(include_pattern, include_content, content)
    
    return content

def process_directory(directory, exclude_files):
    processed_files = set()
    
    for filename in os.listdir(directory):
        if filename.endswith('.v') and 'tb' not in filename.lower():
            file_path = os.path.join(directory, filename)
            print(f"Processing {filename}")
            processed_content = process_verilog_file(file_path, processed_files, exclude_files)
            
            # Write the processed content back to a new file
            output_filename = f"processed_{filename}"
            output_path = os.path.join(directory, output_filename)
            with open(output_path, 'w') as file:
                file.write(processed_content)
            
            print(f"Processed content written to {output_filename}")

def main():
    parser = argparse.ArgumentParser(description="Process Verilog files by including submodule contents.")
    parser.add_argument("-d", "--directory", default=os.getcwd(), help="Target directory containing Verilog files (default: current directory)")
    parser.add_argument("-e", "--exclude", nargs='+', default=[], help="Submodule files to exclude from processing")
    args = parser.parse_args()

    if not os.path.isdir(args.directory):
        print(f"Error: {args.directory} is not a valid directory.")
        return

    process_directory(args.directory, set(args.exclude))

if __name__ == "__main__":
    main()