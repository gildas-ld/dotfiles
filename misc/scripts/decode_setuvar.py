#!/usr/bin/env python3

import sys
import re
import os


def decode_setuvar_line(line):
    line = line.strip()
    if not line.startswith("SETUVAR "):
        return None

    key, value = line[8:].split(":", 1)

    def hex_to_char(match):
        return bytes.fromhex(match.group(1)).decode("utf-8")

    decoded = re.sub(r"\\x([0-9a-fA-F]{2})", hex_to_char, value)
    items = decoded.split("\x1e")
    return key, items


def main():
    if len(sys.argv) != 2:
        print("Usage: decode_setuvar.py <input_file>")
        sys.exit(1)

    input_file = sys.argv[1]

    if not os.path.isfile(input_file):
        print(f"File not found: {input_file}")
        sys.exit(1)

    with open(input_file, "r", encoding="utf-8") as f:
        for line in f:
            result = decode_setuvar_line(line)
            if result:
                key, items = result
                print(f"\nVariable: {key}")
                for item in items:
                    print(f"  - {item}")
            else:
                print(f"Ignored line: {line.strip()}")


if __name__ == "__main__":
    main()
