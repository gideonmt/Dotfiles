#!/usr/bin/env python3
import os, sys, json, calendar
from datetime import date

FILE = os.path.expanduser("~/.goals.json")
GOALS = ["learn something new", "code 30 min"]


class G:
    def __init__(self, f=FILE):
        self.f = f
        self.d = self._load()

    def _load(self):
        return json.load(open(self.f)) if os.path.exists(self.f) else {}

    def _save(self):
        json.dump(self.d, open(self.f, "w"), indent=2)

    def _today(self):
        return date.today().isoformat()

    def chk(self, i):
        t = self._today()
        self.d.setdefault(t, [False] * len(GOALS))
        if 1 <= i <= len(GOALS):
            self.d[t][i - 1] = True
            self._save()
            print(f"✓ {GOALS[i-1]} ({t})")
        else:
            print("bad idx")

    def stat(self, day=None):
        day = day or self._today()
        if day not in self.d:
            print(f"{day}: none")
            return
        for i, g in enumerate(GOALS, 1):
            m = "✔" if self.d[day][i - 1] else "·"
            print(f"{i}. {m} {g}")

    def cal(self, y=None, m=None):
        t = date.today()
        y, m = y or t.year, m or t.month
        cal = calendar.Calendar(6)
        print(f"{calendar.month_name[m]} {y}".center(20))
        print("Su Mo Tu We Th Fr Sa")
        wk = []
        for d in cal.itermonthdates(y, m):
            if d.month != m:
                wk.append("  ")
            else:
                mark = "·"
                if d.isoformat() in self.d:
                    mark = "✔" if all(self.d[d.isoformat()]) else "x"
                wk.append(mark)
            if len(wk) == 7:
                print(" ".join(x.rjust(2) for x in wk))
                wk = []
        if wk:
            print(" ".join(x.rjust(2) for x in wk))


def main():
    if len(sys.argv) < 2:
        print("usage: goals [chk/stat/cal] [args]")
        return
    g = G()
    c, *a = sys.argv[1:]
    if c == "chk":
        g.chk(int(a[0])) if a else print("need idx")
    elif c == "stat":
        g.stat(a[0] if a else None)
    elif c == "cal":
        g.cal(*(map(int, a))) if len(a) == 2 else g.cal()
    else:
        print("bad cmd")


if __name__ == "__main__":
    main()
