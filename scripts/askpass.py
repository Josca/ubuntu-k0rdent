#!/usr/bin/env python3
import sys
import re
import getpass
import argparse

def build_requirements(name, minlen, no_space, req_upper, req_lower, req_digit):
    lines = [f"Requirements for {name}:"]
    if minlen > 0:
        lines.append(f"- At least {minlen} characters long")
    if no_space:
        lines.append("- No spaces")
    if req_upper:
        lines.append("- Must contain at least one uppercase letter")
    if req_lower:
        lines.append("- Must contain at least one lowercase letter")
    if req_digit:
        lines.append("- Must contain at least one digit")
    return "\n".join(lines)

def valid(p, minlen, no_space, req_upper, req_lower, req_digit):
    if len(p) < minlen:
        print(f"Secret must be ≥{minlen} chars.", file=sys.stderr)
        return False
    if no_space and re.search(r"\s", p):
        print("No spaces allowed.", file=sys.stderr)
        return False
    if req_upper and not re.search(r"[A-Z]", p):
        print("Need an uppercase letter.", file=sys.stderr)
        return False
    if req_lower and not re.search(r"[a-z]", p):
        print("Need a lowercase letter.", file=sys.stderr)
        return False
    if req_digit and not re.search(r"\d", p):
        print("Need a digit.", file=sys.stderr)
        return False
    return True

def main():
    parser = argparse.ArgumentParser(description="Secret Validator")
    parser.add_argument("NAME", help="Name of the value being entered")
    parser.add_argument("--len", type=int, default=8, help="Minimum secret length (default 8)")
    parser.add_argument("-s", action="store_true", help="Disallow spaces in secret")
    parser.add_argument("-u", action="store_true", help="Require at least one uppercase letter")
    parser.add_argument("-l", action="store_true", help="Require at least one lowercase letter")
    parser.add_argument("-d", action="store_true", help="Require at least one digit")

    args = parser.parse_args()

    REQUIREMENTS = build_requirements(args.NAME, args.len, args.s, args.u, args.l, args.d)

    for _ in range(3):
        pw = getpass.getpass(f"{REQUIREMENTS}\nEnter {args.NAME}: ")
        if not valid(pw, args.len, args.s, args.u, args.l, args.d):
            continue
        if pw != getpass.getpass(f"Confirm {args.NAME}: "):
            print(f"{args.NAME} do not match.", file=sys.stderr)
            continue
        print(pw)  # stdout for caller
        sys.exit(0)

    print("Too many attempts.", file=sys.stderr)
    sys.exit(1)

if __name__ == "__main__":
    main()
