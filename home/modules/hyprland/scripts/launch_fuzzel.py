#! /usr/bin/env python

import json
import subprocess
from sys import argv


def rgb_hex_to_rgba_hex(color: str, alpha: float) -> str:
    """
    ex: #ffffff, 1 -> ffffffff
    """
    color_hex = color[1:]

    alpha_hex = hex(round(alpha * 255))[2:]

    return color_hex + alpha_hex


col_path = "/home/erb/.cache/wal/colors.json"
colors = json.load(open(col_path, "r"))

bg = colors["special"]["background"]
fg = colors["special"]["foreground"]


if argv[1] == "app":
    subprocess.run(
        [
            "fuzzel",
            f"--background-color={rgb_hex_to_rgba_hex(bg, 0.8)}",
            "--text-color=ddddddff",
            f"--selection-color={rgb_hex_to_rgba_hex(fg, 1)}",
        ]
    )
else:
    subprocess.run(f"cliphist list | fuzzel --dmenu --width 100 --text-color=ddddddff --selection-color={rgb_hex_to_rgba_hex(fg, 1)} --background-color={rgb_hex_to_rgba_hex(bg, 0.8)} | cliphist decode | wl-copy", shell=True)
