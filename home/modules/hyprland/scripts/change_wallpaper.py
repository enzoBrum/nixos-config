#!/usr/bin/env python
import time
import subprocess
import os
import random
import socket


def change_wallpaper(base_path, last_wallpaper):
    wall = last_wallpaper
    while wall == last_wallpaper:
        wall = random.choice(os.listdir(base_path))

    return os.path.join(base_path, wall)


def main():
    base_path = os.path.join("/", "home", "erb", "wallpaper")
    wallpaper = "/home/erb/wallpaper/randall-mackey-mural2.jpg"
    last_wallpaper = wallpaper

    subprocess.run(["swww", "init"])

    WALLPAPER_DURATION = 300
    first = True
    while True:
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
            if first:
                first = False
            else:
                wallpaper = change_wallpaper(base_path, last_wallpaper)
                last_wallpaper = wallpaper

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
