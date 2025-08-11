import argparse, sys
from pathlib import Path

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--role", choices=["CODER","TESTER"], required=True)
    ap.add_argument("diff", help="unified diff file (patch.diff)")
    args = ap.parse_args()

    allowed = {"CODER": ["src/"], "TESTER": ["tests/", "AGENT.md", "README.md", ".github/", "requirements.txt"]}
    ok_prefixes = allowed[args.role]

    txt = Path(args.diff).read_text(encoding="utf-8", errors="ignore")
    bad = []
    for line in txt.splitlines():
        if line.startswith("+++ b/"):
            path = line[6:].strip()
            if not any(path == p or path.startswith(p) for p in ok_prefixes):
                bad.append(path)

    if bad:
        print("❌ 禁止パスへの変更が含まれます:")
        for p in bad: print(" -", p)
        sys.exit(2)

    print("OK: role policy satisfied")
    sys.exit(0)

if __name__ == "__main__":
    main()
