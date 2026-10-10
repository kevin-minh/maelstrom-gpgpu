#!/usr/bin/env python3
import os
import re
import sys
import argparse

def extract_description(file_path):
    try:
        with open(file_path, 'r') as f:
            description = re.search(r'.*@desc\s*(.*)', f.read())
            if description == None:
                return ''

            return description.group(1).strip()

    except Exception:
        pass
    return ''

def print_tree(dir_path, comments, prefix=""):
    try:
        entries = os.listdir(dir_path)
    except OSError:
        return

    def sort_key(entry):
        full_path = os.path.join(dir_path, entry)
        is_dir = os.path.isdir(full_path)
        return (1 if is_dir else 0, entry.lower())

    entries.sort(key=sort_key)
    
    for i, entry in enumerate(entries):

        path = os.path.join(dir_path, entry)
        rel_path = os.path.relpath(path, dir_path)
        is_last = (i == len(entries) - 1)
        connector = "└── " if is_last else "├── "
        
        if os.path.isdir(path):
            print(f"{prefix}{connector}\033[1;34m{entry}/\033[0m")
            extension = "    " if is_last else "│   "
            print_tree(path, comments, prefix + extension)
        else:
            desc = comments.get(rel_path, "")
            file_str = f"{prefix}{connector}\033[36m{entry}\033[0m"
            if desc:
                vis_len = len(re.sub(r"\033\[[0-9;]*m", "", file_str))

                padding = max(2, 40 - vis_len)
                print(f"{file_str}{' ' * padding}\033[2m// {desc}\033[0m")
            else:
                print(file_str)

def main():
    parser = argparse.ArgumentParser(description="Display a source code directory tree with module comments.")
    parser.add_argument("dir", nargs="?", help="Directory to scan.")
    args = parser.parse_args()

    if not os.path.exists(args.dir):
        print(f"Error: Directory '{args.dir}' does not exist.", file=sys.stderr)
        sys.exit(1)

    descriptions = {}
    for root, _, files in os.walk(args.dir):
        for file in files:
            path = os.path.join(root, file)
            rel_path = os.path.relpath(path, args.dir)
            descriptions[file] = extract_description(path)

    print('================================================================================')
    print(f'  \033[1m{args.dir.upper()} Directory Overview\033[0m')
    print('================================================================================')

    print_tree(args.dir, descriptions)

if __name__ == "__main__":
    main()
