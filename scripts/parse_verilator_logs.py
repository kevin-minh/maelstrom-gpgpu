#
# parse_verilator_logs.py
#
# Author: Kevin Nguyen
#

import argparse
import re
import sys
from pathlib import Path
from collections import defaultdict
from colorama import init, Fore, Back, Style
init(autoreset=True) # Automatically resets color after each print

# =============================================================================
# Setup CLI Inputs
# =============================================================================

parser = argparse.ArgumentParser(description='Verilator Warnings/Error Log Parser. Used primarily for testbench results.')
parser.add_argument('testbench', help='Testbench name.')

args = parser.parse_args()

# =============================================================================
# Message Regexes
# =============================================================================

PATTERNS = {
    'error': re.compile(r'^(?:%Error|ERROR)[:\s]*(.*)', re.IGNORECASE),
    'warning': re.compile(r'^(?:%Warning|WARNING)-([A-Z_]+)[:\s]*(.+?):(.+?):(.+?):(.*)', re.IGNORECASE),
    'assertion': re.compile(r'.*(assertion failed|failed assertion|AFT_FAIL).*', re.IGNORECASE),
    'custom_info': re.compile(r'^[INFO]\s*(.*)', re.IGNORECASE)
}

def parse_log(file_path):
    report_data = {
        'errors': [],
        'error_cnt': 0,
        'warnings': [],
        'warning_cnts' : defaultdict(int),
        'custom_infos': [],
        'total_lines': 0
    }

    try:
        with open(file_path, 'r') as f:
            for line in f:
                report_data['total_lines'] += 1
                stripped = line.strip()
                
                if PATTERNS['error'].search(stripped):
                    match = PATTERNS['error'].search(stripped)
                    report_data['errors'].append(stripped)

                elif PATTERNS['warning'].search(stripped):
                    match = PATTERNS['warning'].search(stripped)

                    warning_type = match.group(1) if match.group(1) else 'GENERAL'
                    warning_file = Path(match.group(2)).name
                    warning_line = match.group(3)
                    warning_msg = match.group(5).strip()

                    report_data['warning_cnts']['total'] += 1
                    report_data['warning_cnts'][warning_type] += 1
                    report_data['warnings'].append((warning_type, warning_file, warning_line, warning_msg))

                elif PATTERNS['custom_info'].search(stripped):
                    report_data['custom_infos'].append(stripped)
                    
    except FileNotFoundError:
        print(f"Error: Log file '{file_path}' not found.")
        sys.exit(1)

    print_report(report_data)

# =============================================================================
# Print Custom Report
# =============================================================================

def print_report(report_data):
    if report_data['error_cnt'] > 0:
        pass
    else:
        print(Fore.YELLOW + f'[INFO] Compilation of "{args.testbench}" finished with {report_data["warning_cnts"]["total"]} warnings.')

if __name__ == "__main__":
    log_file = f'sim/{args.testbench}/err.log'
    parse_log(log_file)

