
# import os
# import subprocess
# import csv
# import shutil
# import argparse
# import tempfile

# def create_tcl_script():
#     tcl_content = """
# set verilog_file [lindex $argv 0]
# set top_module [lindex $argv 1]
# set constraint_file [lindex $argv 2]

# create_project -force project_1 ./project_1 -part xc7z020clg400-1
# add_files $verilog_file
# if {$constraint_file != ""} {
#     add_files -fileset constrs_1 $constraint_file
# }
# set_property top $top_module [current_fileset]
# synth_design -top $top_module
# report_utilization -file utilization.rpt
# close_project
# """
#     with tempfile.NamedTemporaryFile(mode='w', suffix='.tcl', delete=False) as temp_file:
#         temp_file.write(tcl_content)
#     return temp_file.name

# def run_vivado(verilog_file, top_module, constraint_file, vivado_path, tcl_script):
#     vivado_cmd = [
#         vivado_path,
#         "-mode", "batch",
#         "-source", tcl_script,
#         "-tclargs",
#         verilog_file,
#         top_module,
#         constraint_file if constraint_file else ""
#     ]
#     result = subprocess.run(vivado_cmd, capture_output=True, text=True)
#     if result.returncode != 0:
#         print(f"Vivado process failed for {verilog_file}. Check the output for errors.")
#         return False
#     return True

# def parse_utilization(file_name):
#     resources = {
#         "Slice LUTs*": "0", "Slice Registers": "0", "DSPs": "0", 
#         "RAMB36/FIFO*": "0", "RAMB18": "0", "Bonded IOB": "0"
#     }
#     try:
#         with open(file_name, 'r') as f:
#             for line in f:
#                 if "|" in line:
#                     parts = line.split("|")
#                     if len(parts) >= 6:
#                         resource = parts[1].strip()
#                         used = parts[2].strip()
#                         if resource in resources:
#                             resources[resource] = used
#     except FileNotFoundError:
#         print(f"Report file {file_name} not found")
#     return resources

# def cleanup_files():
#     if os.path.exists("project_1"):
#         shutil.rmtree("project_1")
#     for file in os.listdir('.'):
#         if file.endswith(('.jou', '.log', '.str', '.dcp')):
#             os.remove(file)

# def process_verilog_files(folder_path, top_module, constraint_file, vivado_path, tcl_script):
#     csv_data = []
#     for filename in os.listdir(folder_path):
#         if filename.endswith('.v') and 'tb' not in filename.lower():
#             file_path = os.path.join(folder_path, filename)
            
#             print(f"Processing {filename}...")
#             if run_vivado(file_path, top_module, constraint_file, vivado_path, tcl_script):
#                 utilization = parse_utilization("utilization.rpt")
                
#                 report_filename = os.path.join(folder_path, f"{top_module}_resource_utilization.txt")
#                 with open(report_filename, 'w') as f:
#                     f.write(f"Resource Utilization for {filename} (Top Module: {top_module}):\n")
#                     f.write(f"Constraint File: {constraint_file if constraint_file else 'None'}\n")
#                     f.write("======================================\n\n")
#                     for resource, used in utilization.items():
#                         f.write(f"{resource}: {used}\n")
                
#                 csv_data.append([filename, top_module, constraint_file if constraint_file else "None"] + list(utilization.values()))
#                 cleanup_files()
    
#     csv_path = os.path.join(folder_path, 'resource_utilization_summary.csv')
#     with open(csv_path, 'w', newline='') as csvfile:
#         writer = csv.writer(csvfile)
#         writer.writerow(['File Name', 'Top Module', 'Constraint File', 'Slice LUTs*', 'Slice Registers', 'DSPs', 'RAMB36/FIFO*', 'RAMB18', 'Bonded IOB'])
#         writer.writerows(csv_data)

#     print(f"Processing complete. Results saved in {csv_path}")

# def main():
#     parser = argparse.ArgumentParser(
#         description="Process Verilog files and generate resource utilization reports using Vivado.",
#         epilog="Example usage: python script.py --top_module counter_top --directory /path/to/verilog/files --constraint_file /path/to/constraints.xdc --vivado_path /path/to/vivado"
#     )
#     parser.add_argument("--directory", default=".", 
#                         help="Directory containing Verilog files (default: current directory)")
#     parser.add_argument("--top_module", required=True, 
#                         help="Name of the top module in the Verilog design")
#     parser.add_argument("--constraint_file", 
#                         help="Path to the constraint file (.xdc) for the design")
#     parser.add_argument("--vivado_path", default="vivado", 
#                         help="Path to Vivado executable (default: 'vivado', assumes it's in system PATH)")
    
#     args = parser.parse_args()

#     # Ensure the specified directory exists
#     os.makedirs(args.directory, exist_ok=True)

#     # Change the current working directory to the specified directory
#     os.chdir(args.directory)

#     tcl_script = create_tcl_script()
#     try:
#         process_verilog_files(args.directory, args.top_module, args.constraint_file, args.vivado_path, tcl_script)
#     finally:
#         os.unlink(tcl_script)

# if __name__ == "__main__":
#     main()

import os
import subprocess
import csv
import shutil
import argparse
import tempfile

def create_tcl_script():
    tcl_content = """
set verilog_file [lindex $argv 0]
set top_module [lindex $argv 1]
set constraint_file [lindex $argv 2]

create_project -force project_1 ./project_1 -part xc7z020clg400-1
add_files $verilog_file
if {$constraint_file != ""} {
    add_files -fileset constrs_1 $constraint_file
}
set_property top $top_module [current_fileset]
synth_design -top $top_module
report_utilization -file utilization.rpt
close_project
"""
    with tempfile.NamedTemporaryFile(mode='w', suffix='.tcl', delete=False) as temp_file:
        temp_file.write(tcl_content)
    return temp_file.name

def run_vivado(verilog_file, top_module, constraint_file, vivado_path, tcl_script):
    vivado_cmd = [
        vivado_path,
        "-mode", "batch",
        "-source", tcl_script,
        "-tclargs",
        verilog_file,
        top_module,
        constraint_file if constraint_file else ""
    ]
    result = subprocess.run(vivado_cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Vivado process failed for {verilog_file}. Check the output for errors.")
        return False
    return True

def parse_utilization(file_name):
    resources = {
        "Slice LUTs*": "0", "Slice Registers": "0", "DSPs": "0", 
        "RAMB36/FIFO*": "0", "RAMB18": "0", "Bonded IOB": "0"
    }
    try:
        with open(file_name, 'r') as f:
            for line in f:
                if "|" in line:
                    parts = line.split("|")
                    if len(parts) >= 6:
                        resource = parts[1].strip()
                        used = parts[2].strip()
                        if resource in resources:
                            resources[resource] = used
    except FileNotFoundError:
        print(f"Report file {file_name} not found")
    return resources

def cleanup_files():
    if os.path.exists("project_1"):
        shutil.rmtree("project_1")
    for file in os.listdir('.'):
        if file.endswith(('.jou', '.log', '.str', '.dcp')):
            os.remove(file)

def process_verilog_files(folder_path, top_module, constraint_file, vivado_path, tcl_script, ignore_files):
    csv_data = []
    for filename in os.listdir(folder_path):
        if filename.endswith('.v') and 'tb' not in filename.lower() and filename not in ignore_files:
            file_path = os.path.join(folder_path, filename)
            
            print(f"Processing {filename}...")
            if run_vivado(file_path, top_module, constraint_file, vivado_path, tcl_script):
                utilization = parse_utilization("utilization.rpt")
                
                report_filename = os.path.join(folder_path, f"{top_module}_resource_utilization.txt")
                with open(report_filename, 'w') as f:
                    f.write(f"Resource Utilization for {filename} (Top Module: {top_module}):\n")
                    f.write(f"Constraint File: {constraint_file if constraint_file else 'None'}\n")
                    f.write("======================================\n\n")
                    for resource, used in utilization.items():
                        f.write(f"{resource}: {used}\n")
                
                csv_data.append([filename, top_module, constraint_file if constraint_file else "None"] + list(utilization.values()))
                cleanup_files()
        elif filename in ignore_files:
            print(f"Ignoring file: {filename}")
    
    csv_path = os.path.join(folder_path, 'resource_utilization_summary.csv')
    with open(csv_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['File Name', 'Top Module', 'Constraint File', 'Slice LUTs*', 'Slice Registers', 'DSPs', 'RAMB36/FIFO*', 'RAMB18', 'Bonded IOB'])
        writer.writerows(csv_data)

    print(f"Processing complete. Results saved in {csv_path}")

def main():
    parser = argparse.ArgumentParser(
        description="Process Verilog files and generate resource utilization reports using Vivado.",
        epilog="Example usage: python script.py --top_module counter_top --directory /path/to/verilog/files --constraint_file /path/to/constraints.xdc --vivado_path /path/to/vivado --ignore file1.v file2.v"
    )
    parser.add_argument("--directory", default=".", 
                        help="Directory containing Verilog files (default: current directory)")
    parser.add_argument("--top_module", required=True, 
                        help="Name of the top module in the Verilog design")
    parser.add_argument("--constraint_file", 
                        help="Path to the constraint file (.xdc) for the design")
    parser.add_argument("--vivado_path", default="vivado", 
                        help="Path to Vivado executable (default: 'vivado', assumes it's in system PATH)")
    parser.add_argument("--ignore", nargs='+', default=[],
                        help="List of Verilog files to ignore (space-separated)")
    
    args = parser.parse_args()

    # Ensure the specified directory exists
    os.makedirs(args.directory, exist_ok=True)

    # Change the current working directory to the specified directory
    os.chdir(args.directory)

    tcl_script = create_tcl_script()
    try:
        process_verilog_files(args.directory, args.top_module, args.constraint_file, args.vivado_path, tcl_script, args.ignore)
    finally:
        os.unlink(tcl_script)

if __name__ == "__main__":
    main()