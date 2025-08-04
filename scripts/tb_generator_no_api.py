import os
import openai
import glob
import argparse
import time

import os
from dotenv import load_dotenv
import google.generativeai as genai
from google.generativeai.types import HarmCategory, HarmBlockThreshold
import glob
import argparse
import time

# Load environment variables from .env file
load_dotenv()

# Set up OpenAI API key
# openai.api_key = ''

# def model_inference(prompt):
#     print("Sending request to ChatGPT...")
#     model_name = "gpt-3.5-turbo"
#     start_time = time.time()
#     completion = openai.ChatCompletion.create(
#         model=model_name,
#         messages=[
#             {"role": "system", "content": "You are an expert in hardware design and verification, specializing in detecting and activating hardware trojans."},
#             {"role": "user", "content": prompt}
#         ]
#     )
#     end_time = time.time()
#     print(f"Received response from ChatGPT (took {end_time - start_time:.2f} seconds)")
#     return completion.choices[0].message['content'], model_name


#Gemini
# import google.generativeai as genai
# import os
# GOOGLE_API_KEY=''
# genai.configure(api_key=GOOGLE_API_KEY)
# from google.generativeai.types import HarmCategory, HarmBlockThreshold


# def model_inference(prompt):
#     print("Sending request to Gemini...")
#     model_name = 'gemini-1.5-pro'  # You can change this to the specific Gemini model you want to use
    
#     # Configure the model
#     model = genai.GenerativeModel(model_name=model_name)
    
#     # Set up safety settings
#     safety_settings = {
#         HarmCategory.HARM_CATEGORY_HATE_SPEECH: HarmBlockThreshold.BLOCK_NONE,
#         HarmCategory.HARM_CATEGORY_HARASSMENT: HarmBlockThreshold.BLOCK_NONE,
#         HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT: HarmBlockThreshold.BLOCK_NONE,
#         HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT: HarmBlockThreshold.BLOCK_NONE
#     }
    
#     start_time = time.time()
#     response = model.generate_content(
#         prompt,
#         safety_settings=safety_settings
#     )
#     end_time = time.time()
    
#     print(f"Received response from Gemini (took {end_time - start_time:.2f} seconds)")
#     return response.text, model_name

#CaludeAI
import os
from anthropic import Anthropic

client = Anthropic(
    # This is the default and can be omitted
    api_key=os.environ.get("ANTHROPIC_API_KEY"),
)


#ClaudeAI
def model_inference(prompt):
    # model_name = "claude-3-opus-20240229"
    model_name = "claude-3-sonnet-20240229"
    # model_name = "claude-3-haiku-20240307"
    
    
    message = client.messages.create(
        max_tokens=4096,
        messages=[
            {
                "role": "user",
                "content": prompt,
            }
        ],
        model=model_name,
    )
    # Extract the text content from the message
    content = message.content[0].text if message.content else ""
    print(content)
    return content, model_name



def clean_testbench_content(content):
    # Remove triple backticks if present (from markdown formatting)
    if content.startswith("```"):
        content = content.split("\n", 1)[-1]
    if content.endswith("```"):
        content = content.rsplit("\n", 1)[0]
    
    # Split the content into lines
    lines = content.strip().split("\n")
    
    # Find the start of the module (including timescale)
    start_index = 0
    for i, line in enumerate(lines):
        if line.strip().startswith("`timescale") or line.strip().startswith("module"):
            start_index = i
            break
    
    # Find the end of the module
    end_index = None
    for i, line in enumerate(lines[start_index:], start=start_index):
        if line.strip() == "endmodule":
            end_index = i
            break
    
    # If endmodule is found, keep content up to and including it
    if end_index is not None:
        content = "\n".join(lines[start_index:end_index+1])
    else:
        # If endmodule is not found, keep all content from start_index
        content = "\n".join(lines[start_index:])
    
    return content.strip()


def load_vulnerable_designs(directory, ignore_list):
    print(f"Loading vulnerable designs from {directory}...")
    vulnerable_designs = []
    for file in glob.glob(os.path.join(directory, '*_V*.v')):
        if os.path.basename(file) not in ignore_list:
            base_name = os.path.splitext(file)[0]  # Remove .v extension
            taxonomy_file = f"{base_name}_taxonomy.txt"
            
            if os.path.exists(taxonomy_file):
                with open(file, 'r') as f:
                    design_content = f.read()
                with open(taxonomy_file, 'r') as f:
                    taxonomy_content = f.read()
                
                vulnerable_designs.append((file, design_content, taxonomy_content))
                print(f"  Loaded: {file}")
                print(f"  With taxonomy: {taxonomy_file}")
            else:
                print(f"Warning: Taxonomy file not found for {file}")
        else:
            print(f"  Ignoring file: {file}")
    
    print(f"Loaded {len(vulnerable_designs)} vulnerable design(s)")
    return vulnerable_designs

def load_original_testbench(file_path):
    print(f"Loading original testbench from {file_path}...")
    with open(file_path, 'r') as f:
        content = f.read()
    print("Original testbench loaded successfully")
    return content

def construct_prompt(vulnerable_design, original_testbench, taxonomy):
    print("Constructing prompt for Gemini...")
    prompt = f"""
Analyze the following vulnerable Verilog design, its original testbench, and the trojan taxonomy:

Vulnerable Design:
{vulnerable_design}

Original Testbench:
{original_testbench}

Trojan Taxonomy:
{taxonomy}

Task: Modify the testbench to perform the following steps:
1. Verify normal operation:
   - Generate stimulus to check the design's intended functionality.
   - If the design passes normal operation tests, display: "NORMAL OPERATION: PASS"

2. Activate and verify the hardware Trojan:
   - Use the information from the trojan taxonomy to design appropriate stimuli to trigger the Trojan.
   - Verify if the Trojan is activated and its malicious behavior is achieved as described in the taxonomy. If successful, display: "TROJAN ACTIVATION: PASS"

Provide your response in the following format:

modified_testbench:
<Insert the full modified testbench code here>

Ensure the modified testbench is self-contained and can be simulated independently.
"""
    print("Prompt constructed")
    return prompt



def extract_testbench(response):
    print("Extracting and cleaning modified testbench from ChatGPT response...")
    testbench_start = response.find("modified_testbench:") + len("modified_testbench:")
    modified_testbench = response[testbench_start:].strip()
    cleaned_testbench = clean_testbench_content(modified_testbench)
    print("Extraction and cleaning complete")
    return cleaned_testbench

def save_modified_testbench(testbench, file_path):
    print(f"Saving modified testbench to {file_path}...")
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    with open(file_path, 'w') as f:
        f.write(testbench)
    print(f"Modified testbench saved successfully")

def main(args):
    print("Starting the testbench modification process...")
    vulnerable_designs_dir = args.vulnerable_dir
    original_testbench_path = args.testbench
    ignore_list = args.ignore

    vulnerable_designs = load_vulnerable_designs(vulnerable_designs_dir, ignore_list)
    original_testbench = load_original_testbench(original_testbench_path)

    for i, (design_path, design_content, taxonomy_content) in enumerate(vulnerable_designs, 1):
        print(f"\nProcessing design {i} of {len(vulnerable_designs)}: {design_path}")
        prompt = construct_prompt(design_content, original_testbench, taxonomy_content)
        response, model_name = model_inference(prompt)

        modified_testbench = extract_testbench(response)

        # Generate output path
        design_dir = os.path.dirname(design_path)
        base_name = os.path.splitext(os.path.basename(design_path))[0]
        testbench_path = os.path.join(design_dir, f"{base_name}_tb.v")

        save_modified_testbench(modified_testbench, testbench_path)

    print("\nTestbench modification process completed successfully!")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Modify testbenches to activate hardware trojans in vulnerable Verilog designs.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python script.py --vulnerable-dir ./vulnerable_designs --testbench ./original_tb.v
  python script.py --vulnerable-dir ./designs --testbench ./tb.v --ignore file1.v file2.v

Note: Make sure to set your OpenAI API key in the script before running.
        """
    )
    parser.add_argument("--vulnerable-dir", required=True, help="Directory containing vulnerable Verilog designs")
    parser.add_argument("--testbench", required=True, help="Path to the original testbench file")
    parser.add_argument("--ignore", nargs="*", default=[], help="List of filenames to ignore (e.g., file1.v file2.v)")
    
    args = parser.parse_args()
    main(args)