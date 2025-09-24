#!/usr/bin/env python3
import json
import subprocess, sys
from datetime import datetime, date, timedelta

# categories you care about
CATS = ["code", "school", "browse", "waste"]


def run_cmd(cmd):
    subprocess.run(cmd, check=True)


def run_out(cmd):
    return subprocess.check_output(cmd, text=True).strip()


def log(cat):
    if cat not in CATS:
        print(f"bad category. use: {', '.join(CATS)}")
        return
    run_cmd(["timew", "start", cat])
    print(f"started {cat}")


def report(days=30):
    print(f"report for last {days} days")
    since = (date.today() - timedelta(days=days)).isoformat()
    out = run_out(["timew", "export"])
    data = json.loads(out)

    totals = {c: 0 for c in CATS}
    total = 0

    for entry in data:
        start = datetime.fromisoformat(entry["start"])
        end = (
            datetime.fromisoformat(entry["end"])
            if "end" in entry
            else datetime.now().astimezone(start.tzinfo)
        )
        if start.date() < (date.today() - timedelta(days=days)):
            continue
        for c in CATS:
            if c in entry.get("tags", []):
                secs = (end - start).total_seconds()
                totals[c] += secs
                total += secs

    for c in CATS:
        hrs = totals[c] / 3600
        pct = (totals[c] / total * 100) if total else 0
        print(f"{c:7} {hrs:6.2f}h  {pct:5.1f}%")


def main():
    if len(sys.argv) < 2:
        print("usage: tlog.py [CATEGORY|report N]")
        return
    arg, *rest = sys.argv[1:]
    if arg == "report":
        n = int(rest[0]) if rest else 30
        report(n)
    elif arg == "stop":
        run_cmd(["timew", "stop"])
        print("stopped")
    elif arg in CATS:
        log(arg)
    else:
        print("bad cmd")


if __name__ == "__main__":
    main()
