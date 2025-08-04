# import os
# import subprocess
# import csv
# import re
# import argparse
# import shutil

# def run_yosys(design_file, liberty_file=None, top_module=None):
#     # Check if Yosys is available
#     if shutil.which('yosys') is None:
#         print("Error: Yosys is not found in the system PATH. Please ensure Yosys is installed and accessible.")
#         return None

#     if top_module is None:
#         top_module = os.path.splitext(os.path.basename(design_file))[0]
#         top_module = top_module.split('_HT')[0]
    
#     yosys_script = f"""
# # Read the design
# read_verilog {design_file}
# # Synthesize the design
# synth -top {top_module}
# """

#     if liberty_file:
#         yosys_script += f"""
# # Read the liberty file
# read_liberty -lib {liberty_file}
# # Map to specific cells
# abc -liberty {liberty_file}
# """
#     else:
#         yosys_script += """
# # Map to generic gates
# abc -g gates
# """

#     # Modify the netlist filename
#     netlist_file = design_file.replace('.v', '')
#     if '_A' in netlist_file:
#         netlist_file = netlist_file.split('_A')[0] + '_A' + netlist_file.split('_A')[1] + '_net.v'
#     else:
#         netlist_file += '_net.v'

#     yosys_script += f"""
# # Optimize it
# opt_clean -purge
# # Clean up
# clean
# # Generate netlist
# write_verilog -noattr {netlist_file}
# # Show statistics
# stat
# """

#     try:
#         process = subprocess.Popen(['yosys', '-Q', '-p', yosys_script], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
#         stdout, stderr = process.communicate()
#         if process.returncode != 0:
#             print(f"Error: Yosys exited with return code {process.returncode}")
#             print("Yosys stderr output:")
#             print(stderr.decode('utf-8'))
#             return None
#         return stdout.decode('utf-8')  # Decode bytes to string
#     except Exception as e:
#         print(f"Error running Yosys: {str(e)}")
#         return None

# def extract_total_cells(stats):
#     match = re.search(r'Number of cells:\s+(\d+)', stats)
#     if match:
#         return int(match.group(1))
#     return 0

# def extract_info_from_filename(filename):
#     parts = filename.split('_')
#     top_module = parts[0]
#     ht_type = ''
#     llm_model = ''
    
#     for i, part in enumerate(parts):
#         if part.startswith('HT'):
#             ht_type = part
#             if i+1 < len(parts):
#                 llm_model = parts[i+1]
#             break

#     return top_module, ht_type, llm_model

# def process_designs(directory, liberty_file=None, include_tb=False, include_txt=False, output_file='design_stats.csv', top_module=None):
#     csv_data = []
    
#     for filename in os.listdir(directory):
#         if ('_HT' in filename and 
#             filename.endswith('.v') and 
#             (include_tb or '_tb' not in filename) and 
#             (include_txt or not filename.endswith('.txt'))):
            
#             design_file = os.path.join(directory, filename)
#             print(f"Processing {filename}...")
            
#             # Run Yosys
#             stats = run_yosys(design_file, liberty_file, top_module)
            
#             if stats is None:
#                 print(f"Skipping {filename} due to Yosys error")
#                 continue
            
#             # Save stats
#             stats_file = os.path.join(directory, filename.replace('.v', '_stats.txt'))
#             with open(stats_file, 'w') as f:
#                 f.write(stats)
            
#             # Extract total cell count
#             total_cells = extract_total_cells(stats)
            
#             # Extract info from filename
#             file_top_module, ht_type, llm_model = extract_info_from_filename(filename)
            
#             # Use provided top_module if available, otherwise use the one extracted from filename
#             used_top_module = top_module if top_module else file_top_module
            
#             # Prepare CSV data
#             csv_data.append({
#                 'File Name': filename,
#                 'Top Module': used_top_module,
#                 'LLM Model': llm_model,
#                 'HT Type': ht_type,
#                 'Total Cells': total_cells
#             })
    
#     # Write CSV file
#     if csv_data:
#         csv_file = os.path.join(directory, output_file)
#         with open(csv_file, 'w', newline='') as f:
#             writer = csv.DictWriter(f, fieldnames=['File Name', 'Top Module', 'LLM Model', 'HT Type', 'Total Cells'])
#             writer.writeheader()
#             writer.writerows(csv_data)
#         print(f"CSV file saved as {csv_file}")
#     else:
#         print("No data to write to CSV. Please check if there were any errors processing the files.")

# if __name__ == "__main__":
#     parser = argparse.ArgumentParser(description='Process Verilog designs and generate synthesis statistics.')
#     parser.add_argument('directory', nargs='?', help='Directory path containing the design files')
#     parser.add_argument('-d', '--directory', dest='dir_flag', help='Directory path containing the design files (alternative to positional argument)')
#     parser.add_argument('-l', '--liberty', help='Path to the liberty file (optional)')
#     parser.add_argument('--include-tb', action='store_true', help='Include testbench files in processing')
#     parser.add_argument('--include-txt', action='store_true', help='Include .txt files in processing')
#     parser.add_argument('-o', '--output', default='design_stats.csv', help='Output CSV file name (default: design_stats.csv)')
#     parser.add_argument('-t', '--top', help='Specify the top module name')
    
#     args = parser.parse_args()
    
#     # Determine which directory path to use
#     if args.directory and args.dir_flag:
#         print("Error: Please specify the directory either as a positional argument or with -d, not both.")
#         parser.print_help()
#         exit(1)
#     elif args.directory:
#         directory = args.directory
#     elif args.dir_flag:
#         directory = args.dir_flag
#     else:
#         print("Error: Please specify the directory path.")
#         parser.print_help()
#         exit(1)
    
#     process_designs(directory, args.liberty, args.include_tb, args.include_txt, args.output, args.top)


import os
import subprocess
import csv
import re
import argparse
import shutil

def run_yosys(design_file, liberty_file=None, top_module=None):
    # Check if Yosys is available
    if shutil.which('yosys') is None:
        print("Error: Yosys is not found in the system PATH. Please ensure Yosys is installed and accessible.")
        return None

    if top_module is None:
        top_module = os.path.splitext(os.path.basename(design_file))[0]
        top_module = top_module.split('_HT')[0]
    
    yosys_script = f"""
# Read the design
read_verilog {design_file}
# Synthesize the design
synth -top {top_module}
"""

    if liberty_file:
        yosys_script += f"""
# Read the liberty file
read_liberty -lib {liberty_file}
# Map to specific cells
abc -liberty {liberty_file}
"""
    else:
        yosys_script += """
# Map to generic gates
abc -g gates
"""

    # Modify the netlist filename
    netlist_file = design_file.replace('.v', '')
    if '_A' in netlist_file:
        netlist_file = netlist_file.split('_A')[0] + '_A' + netlist_file.split('_A')[1] + '_net.v'
    else:
        netlist_file += '_net.v'

    yosys_script += f"""
# Optimize it
opt_clean -purge
# Clean up
clean
# Generate netlist
write_verilog -noattr {netlist_file}
# Show statistics
stat
"""

    try:
        process = subprocess.Popen(['yosys', '-Q', '-p', yosys_script], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout, stderr = process.communicate()
        if process.returncode != 0:
            print(f"Error: Yosys exited with return code {process.returncode}")
            print("Yosys stderr output:")
            print(stderr.decode('utf-8'))
            return None
        return stdout.decode('utf-8')  # Decode bytes to string
    except Exception as e:
        print(f"Error running Yosys: {str(e)}")
        return None

def extract_total_cells(stats):
    # Split the stats by 'abc' to get the last section
    sections = stats.split('abc')
    if len(sections) > 1:
        last_section = sections[-1]
    else:
        last_section = stats

    # Find the last occurrence of 'Number of cells' in the last section
    matches = list(re.finditer(r'Number of cells:\s+(\d+)', last_section))
    if matches:
        return int(matches[-1].group(1))
    return 0

def extract_info_from_filename(filename):
    parts = filename.split('_')
    top_module = parts[0]
    ht_type = ''
    llm_model = ''
    
    for i, part in enumerate(parts):
        if part.startswith('HT'):
            ht_type = part
            if i+1 < len(parts):
                llm_model = parts[i+1]
            break

    return top_module, ht_type, llm_model

def process_designs(directory, liberty_file=None, include_tb=False, include_txt=False, output_file='design_stats.csv', top_module=None):
    csv_data = []
    
    for filename in os.listdir(directory):
        if ('_HT' in filename and 
            filename.endswith('.v') and 
            (include_tb or '_tb' not in filename) and 
            (include_txt or not filename.endswith('.txt'))):
            
            design_file = os.path.join(directory, filename)
            print(f"Processing {filename}...")
            
            # Run Yosys
            stats = run_yosys(design_file, liberty_file, top_module)
            
            if stats is None:
                print(f"Skipping {filename} due to Yosys error")
                continue
            
            # Save stats
            stats_file = os.path.join(directory, filename.replace('.v', '_stats.txt'))
            with open(stats_file, 'w') as f:
                f.write(stats)
            
            # Extract total cell count
            total_cells = extract_total_cells(stats)
            
            # Extract info from filename
            file_top_module, ht_type, llm_model = extract_info_from_filename(filename)
            
            # Use provided top_module if available, otherwise use the one extracted from filename
            used_top_module = top_module if top_module else file_top_module
            
            # Prepare CSV data
            csv_data.append({
                'File Name': filename,
                'Top Module': used_top_module,
                'LLM Model': llm_model,
                'HT Type': ht_type,
                'Total Cells': total_cells
            })
    
    # Write CSV file
    if csv_data:
        csv_file = os.path.join(directory, output_file)
        with open(csv_file, 'w', newline='') as f:
            writer = csv.DictWriter(f, fieldnames=['File Name', 'Top Module', 'LLM Model', 'HT Type', 'Total Cells'])
            writer.writeheader()
            writer.writerows(csv_data)
        print(f"CSV file saved as {csv_file}")
    else:
        print("No data to write to CSV. Please check if there were any errors processing the files.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Process Verilog designs and generate synthesis statistics.')
    parser.add_argument('directory', nargs='?', help='Directory path containing the design files')
    parser.add_argument('-d', '--directory', dest='dir_flag', help='Directory path containing the design files (alternative to positional argument)')
    parser.add_argument('-l', '--liberty', help='Path to the liberty file (optional)')
    parser.add_argument('--include-tb', action='store_true', help='Include testbench files in processing')
    parser.add_argument('--include-txt', action='store_true', help='Include .txt files in processing')
    parser.add_argument('-o', '--output', default='design_stats.csv', help='Output CSV file name (default: design_stats.csv)')
    parser.add_argument('-t', '--top', help='Specify the top module name')
    
    args = parser.parse_args()
    
    # Determine which directory path to use
    if args.directory and args.dir_flag:
        print("Error: Please specify the directory either as a positional argument or with -d, not both.")
        parser.print_help()
        exit(1)
    elif args.directory:
        directory = args.directory
    elif args.dir_flag:
        directory = args.dir_flag
    else:
        print("Error: Please specify the directory path.")
        parser.print_help()
        exit(1)
    
    process_designs(directory, args.liberty, args.include_tb, args.include_txt, args.output, args.top)