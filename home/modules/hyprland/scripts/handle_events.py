import json
import os
import socket
import subprocess
from pathlib import Path
from time import sleep
from uuid import uuid4

dir = Path("/tmp/waybar-configs")
dir.mkdir(exist_ok=True)


def handle_monitor_added(name: str):
    proc = subprocess.run(
        [
            "python",
            "/home/erb/repos/nixos-config/home/modules/hyprland/scripts/ask_monitor_position.py",
        ],
        stdout=subprocess.PIPE,
    )

    sleep(0.3)
    direction = proc.stdout.strip().decode()
    commands = []
    if direction == "Left":
        commands.append(f"keyword monitor {name},1920x1080@60,0x0,1")
        commands.append("keyword monitor eDP-1,1920x1080@60,1920x0,1")
    else:
        commands.append("keyword monitor eDP-1,1920x1080@60,0x0,1")
        commands.append(f"keyword monitor {name},1920x1080@60,1920x0,1")

    for i in range(10):
        commands.append(f"keyword workspace {i+1},monitor:{name}")

    subprocess.run(["hyprctl", "--batch", ";".join(commands)])
    subprocess.run(["pkill", "waybar"])

    config = (
        Path("/home/erb/.config/waybar/config").read_text().replace("HDMI-A-1", name)
    )
    new_config = dir / uuid4().hex
    new_config.write_text(config)

    subprocess.Popen(
        ["waybar", "-c", str(new_config)],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


proc = subprocess.run(["hyprctl", "monitors", "-j"], stdout=subprocess.PIPE)
monitors = json.loads(proc.stdout.decode().strip())

for monitor in monitors:
    if monitor["name"] not in ("HDMI-A-1", "eDP-1"):
        handle_monitor_added(monitor["name"])
        break

with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
    sock.connect(
        f"/{os.getenv('XDG_RUNTIME_DIR')}/hypr/{os.getenv("HYPRLAND_INSTANCE_SIGNATURE")}/.socket2.sock"
    )

    file = sock.makefile()
    while True:
        event, data = file.readline().strip().split(">>")

        match event:
            case "monitoradded":
                handle_monitor_added(data)

            case "monitorremoved":
                subprocess.run(["pkill", "waybar"])
                subprocess.Popen(
                    [
                        "waybar",
                        "-c",
                        "/home/erb/repos/nixos-config/home/modules/hyprland/waybar_one_monitor.json",
                    ],
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL,
                )

                commands = []
                commands.append("keyword monitor eDP-1,1920x1080@60,0x0,1")
                for i in range(10):
                    commands.append(f"keyword workspace {i+1},monitor:eDP-1")
                subprocess.run(["hyprctl", "--batch", ";".join(commands)])
            case _:
                continue
