#!/usr/bin/env python
import os
import random
import socket
import subprocess
import time


def change_wallpaper(base_path: str, used: set):
    wallpapers = set([path for path in os.listdir(base_path) if "blurred" not in path])

    if used == wallpapers:
        used.clear()

    wall = random.choice(list(wallpapers.difference(used)))
    used.add(wall)
    return os.path.join(base_path, wall)


def main():
    base_path = "/home/erb/repos/nixos-config/assets/wallpaper"

    subprocess.run(["swww-daemon"])

    WALLPAPER_DURATION = 300
    used = {"randall-mackey-mural2.jpg"}

    begin = time.time()
    while not os.path.exists("/tmp/color_server.sock") and time.time() - begin < 60:
        time.sleep(0.5)

    if not os.path.exists("/tmp/color_server.sock"):
        subprocess.run("notify-send /tmp/color_server.sock não existe!", shell=True)

    while True:
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
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
            subprocess.run(
                [
                    "ln",
                    "-sf",
                    wallpaper,
                    "/home/erb/.current_image.png",
                ],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
            sock.connect("/tmp/color_server.sock")
            sock.sendall(b"wallpaper changed")
        time.sleep(WALLPAPER_DURATION)


if __name__ == "__main__":
    main()
