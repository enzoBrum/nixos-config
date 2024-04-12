#! /usr/bin/env nix-shell
#! nix-shell -i python -p python312Packages.tkinter python312Packages.sv-ttk

from tkinter import Tk, ttk

import sv_ttk


def print_and_exit(val: str):
    print(val)
    exit(0)


root = Tk()
root.geometry("350x100")
root.title("New monitor added!")

button = ttk.Button(root, text="Click me!")
button.grid()

ttk.Label(
    root, text="New monitor added! \nChoose its placement relative to the computer"
).grid(row=0, column=0, pady=10, padx=10)
frame = ttk.Frame(root, padding=10)
frame.grid(row=1, column=0)

ttk.Button(frame, text="Left", command=lambda: print_and_exit("Left")).grid(
    row=0, column=0, sticky="W"
)
ttk.Button(frame, text="Right", command=lambda: print_and_exit("Right")).grid(
    row=0, column=1, sticky="W"
)


sv_ttk.set_theme("dark")

root.mainloop()
