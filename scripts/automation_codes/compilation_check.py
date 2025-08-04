import os
import sys
import subprocess
import csv
import argparse

def process_verilog_files(directory):
    verilog_files = [f for f in os.listdir(directory) if f.endswith('.v') and 'tb' not in f]
    total_files = len(verilog_files)
    successful_compilations = 0
    results = []

    for file in verilog_files:
        print(f"Processing: {file}")
        filepath = os.path.join(directory, file)
        result = subprocess.run(['iverilog', '-o', '/dev/null', filepath], capture_output=True, text=True)
        
        if result.returncode == 0:
            successful_compilations += 1
            results.append((file, 'Passed'))
        else:
            results.append((file, 'Failed'))

    eval_o = (successful_compilations / total_files) * 100 if total_files > 0 else 0

    print(f"\nStats:")
    print(f"Total .v files processed: {total_files}")
    print(f"Files compiled without errors: {successful_compilations}")
    print(f"EvalO (Code Correctness): {eval_o:.2f}%")

    # Save results to CSV
    csv_path = os.path.join(directory, 'verilog_compilation_results.csv')
    try:
        with open(csv_path, 'w', newline='') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(['Filename', 'Compilation Result'])
            writer.writerows(results)
        print(f"Results saved to {csv_path}")
    except IOError as e:
        print(f"Error writing CSV file: {e}")

def main():
    parser = argparse.ArgumentParser(description="Check Verilog designs compilation using iverilog")
    parser.add_argument('-d', '--directory', required=True, help='Directory containing Verilog files')
    args = parser.parse_args()

    if not os.path.isdir(args.directory):
        print(f"Error: {args.directory} is not a valid directory")
        sys.exit(1)

    process_verilog_files(args.directory)

if __name__ == "__main__":
    main()