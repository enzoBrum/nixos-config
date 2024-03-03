#!/usr/bin/env python

import os
import json
import socket
import subprocess


def col_shaded(color, shade_multiplier=0.5):
    fg = int(color[1:], 16)
    shade_multiplier = shade_multiplier

    r = int(((fg >> 16) & 0xFF) * shade_multiplier)
    g = int(((fg >> 8) & 0xFF) * shade_multiplier)
    b = int(((fg) & 0xFF) * shade_multiplier)

    col_hex = hex((r << 16) + (g << 8) + b)[2:]
    return "#" + col_hex


def change_color(bg=None, fg=None):
    colors_path = "/home/erb/.cache/wal/colors.json"
    data = json.load(open(colors_path, "r"))

    bg = data["special"]["background"] if bg is None else bg
    fg = data["colors"]["color5"] if fg is None else fg
    subprocess.run(
        f'hyprctl --batch "keyword general:col.active_border rgba({fg[1:]+"ff"}); keyword general:col.inactive_border rgba({col_shaded(fg)[1:]+"ff"});"',
        shell=True,
        check=True,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


using_vpn = False
sock_path = "/tmp/color_server.sock"

if os.path.exists(sock_path):
    os.remove(sock_path)

with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
    sock.bind(sock_path)
    sock.listen()

    while True:
        conn, _ = sock.accept()
        with conn:
            data = conn.recv(1024).decode().strip()
            print(data)

            if data == "wallpaper changed" and not using_vpn:
                change_color()
            elif data == "vpn-up":
                using_vpn = True
                change_color(fg="#349629")
            elif data == "vpn-down":
                using_vpn = False
                change_color()
