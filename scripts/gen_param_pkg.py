#!/usr/bin/env python3
import yaml
import sys
import datetime
from pathlib import Path

def generate_header_and_footer(params_text):
    return ""

def extract_leaf_pairs(d, prefix=""):
    pairs = []
    for key, value in d.items():
        new_prefix = f"{prefix}_{key}" if prefix else str(key)
        if isinstance(value, dict) and value:
            pairs.extend(extract_leaf_pairs(value, new_prefix))
        else:
            pairs.append((new_prefix, value))
    return pairs

def generate_sv_package(yaml_path, output_sv_path):
    with open(yaml_path, 'r') as f:
        params = yaml.safe_load(f)
    
    param_names = extract_leaf_pairs(params['msv'])

    pkg_contents = f"""// ============================================================================
// msg_params_pkg.sv
//
// @desc Global Design Parameter Definitions from 'inputs/msg_params.yaml'
// See scripts/gen_param_pkg.py and make %.params
//
// Generated {datetime.datetime.now().strftime('%Y-%m-%d %H:%M')}
// ============================================================================
        
`ifndef PARAMS_PKG
`define PARAMS_PKG

package msg_params_pkg;

"""
    for (param_name, param_value) in param_names:
        pkg_contents += f"  `define {param_name.upper()} {param_value}\n"
    
    pkg_contents += "\nendpackage;\n\n`endif\n"

    with open(output_sv_path, 'w') as f:
        f.write(pkg_contents)

if __name__ == '__main__':
    generate_sv_package('inputs/msg_params.yaml', 'rtl/msg_params_pkg.sv')

