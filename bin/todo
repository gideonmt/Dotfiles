#!/usr/bin/env python3
import sys
import json
import os
from datetime import datetime

DATA_FILE = os.path.expanduser("~/.todo.json")


class TodoApp:
    def __init__(self, path=DATA_FILE):
        self.path = path
        self.data = self._load()

    def _load(self):
        if not os.path.exists(self.path):
            return {}
        with open(self.path, "r") as f:
            return json.load(f)

    def _save(self):
        with open(self.path, "w") as f:
            json.dump(self.data, f, indent=2)

    def add(self, lst, task, due=None):
        self.data.setdefault(lst, []).append({"t": task, "done": False, "due": due})
        self._save()
        msg = f"+ {lst}: {task}"
        if due:
            msg += f" (due {due})"
        print(msg)

    def show(self, lst=None):
        if not self.data:
            print("No lists yet.")
            return
        if lst:
            self._show_list(lst)
        else:
            for name in self.data:
                self._show_list(name)

    def _show_list(self, lst):
        if lst not in self.data or not self.data[lst]:
            print(f"{lst}: empty")
            return

        # sort: by due date if present, then put undated at end
        def sort_key(item):
            if item["due"]:
                try:
                    return (datetime.strptime(item["due"], "%Y-%m-%d"), 0)
                except ValueError:
                    return (datetime.max, 0)
            return (datetime.max, 1)

        items = sorted(self.data[lst], key=sort_key)

        print(f"[{lst}]")
        for i, item in enumerate(items, 1):
            mark = "✔" if item["done"] else "·"
            due = f" ({item['due']})" if item["due"] else ""
            print(f"{i}. {mark} {item['t']}{due}")

    def done(self, lst, idx):
        if lst not in self.data or not (1 <= idx <= len(self.data[lst])):
            print("Invalid index.")
            return
        self.data[lst][idx - 1]["done"] = True
        self._save()
        print(f"✓ {self.data[lst][idx - 1]['t']}")

    def rm(self, lst, idx=None):
        if lst not in self.data:
            print(f"No list '{lst}'.")
            return
        if idx is None:
            confirm = input(f"Delete entire list '{lst}'? (y/N): ")
            if confirm.lower() == "y":
                del self.data[lst]
                self._save()
                print(f"List '{lst}' deleted.")
            else:
                print("Canceled.")
        else:
            if not (1 <= idx <= len(self.data[lst])):
                print("Invalid index.")
                return
            item = self.data[lst].pop(idx - 1)
            self._save()
            print(f"- {item['t']}")


def main():
    if len(sys.argv) < 2:
        print("Usage: todo [add/list/done/rm] [list] [task/index] [--due YYYY-MM-DD]")
        return

    cmd, *args = sys.argv[1:]
    app = TodoApp()

    if cmd == "add" and len(args) >= 2:
        lst = args[0]
        due = None
        if "--due" in args:
            i = args.index("--due")
            if i + 1 < len(args):
                due = args[i + 1]
                args = args[:i]  # cut out date flag and beyond
        task = " ".join(args[1:])
        app.add(lst, task, due)

    elif cmd == "list":
        app.show(args[0] if args else None)

    elif cmd == "done" and len(args) == 2:
        app.done(args[0], int(args[1]))

    elif cmd == "rm":
        if len(args) == 1:
            app.rm(args[0])
        elif len(args) == 2:
            app.rm(args[0], int(args[1]))
        else:
            print("Usage: todo rm [list] [index]")
    else:
        print("Invalid command.")


if __name__ == "__main__":
    main()
