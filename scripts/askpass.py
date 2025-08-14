#!/usr/bin/env python3
import sys, re, getpass

REQUIREMENTS = """
Password Requirements:
- At least 8 characters long
- No spaces
- Must contain at least one uppercase letter
- Must contain at least one lowercase letter
- Must contain at least one digit
"""

def valid(p):
    if len(p) < 8: print("Password must be ≥8 chars.", file=sys.stderr); return False
    if re.search(r"\s", p): print("No spaces allowed.", file=sys.stderr); return False
    if not re.search(r"[A-Z]", p): print("Need an uppercase letter.", file=sys.stderr); return False
    if not re.search(r"[a-z]", p): print("Need a lowercase letter.", file=sys.stderr); return False
    if not re.search(r"\d", p): print("Need a digit.", file=sys.stderr); return False
    return True

for _ in range(3):
    pw = getpass.getpass(f"{REQUIREMENTS}\nEnter password: ")
    if not valid(pw): continue
    if pw != getpass.getpass("Confirm password: "):
        print("Passwords do not match.", file=sys.stderr); continue
    print(pw)   # stdout for caller
    sys.exit(0)

print("Too many attempts.", file=sys.stderr)
sys.exit(1)
