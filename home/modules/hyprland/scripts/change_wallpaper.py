#!/usr/bin/env python
import time
import subprocess
import os
import random
import socket


def change_wallpaper(base_path: str, used: set):
    wallpapers = set(os.listdir(base_path))

    if used == wallpapers:
        used.clear()
    
    wall = random.choice( list(wallpapers.difference(used)) )
    used.add(wall)
    return os.path.join(base_path, wall)


def main():
    base_path = "/home/erb/repos/nixos-config/assets/wallpaper"
    wallpaper = "/home/erb/repos/nixos-config/assets/wallpaper/randall-mackey-mural2.jpg"

    subprocess.run(["swww", "init"])

    WALLPAPER_DURATION = 300
    first = True
    used = {"randall-mackey-mural2.jpg"}
    while True:
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
            if first:
                first = False
            else:
                wallpaper = change_wallpaper(base_path, used)

            subprocess.run(
                ["swww", "img", wallpaper],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
            subprocess.run(
                ["wal", "-s", "-n", "-i", wallpaper],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
            sock.connect("/tmp/color_server.sock")
            sock.sendall(b"wallpaper changed")
            time.sleep(WALLPAPER_DURATION)


if __name__ == "__main__":
    main()
