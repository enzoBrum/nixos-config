#! /usr/bin/env python

import subprocess
from time import sleep


WARNINGS = (20, 15, 10, 5)

while True:
    sleep(60)
    cmd = subprocess.run(["acpi", "-b"], stdout=subprocess.PIPE)
    output = cmd.stdout.decode().lower()

    if "discharging" in output:
        val = int(output.split()[3][:-2])

        if val in WARNINGS:
            subprocess.run(
                ["notify-send", "--urgency=CRITICAL", "Battery Low", f"Level: {val}"]
            )
