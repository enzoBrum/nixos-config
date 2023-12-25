#! /usr/bin/env python

import sys
import socket

server_path = "/tmp/color_server.sock"

if len(sys.argv) < 3:
    exit(0)

_, interface, event = sys.argv

if event not in ["vpn-up", "vpn-down"]:
    exit(0)

sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
sock.connect(server_path)
sock.send(event.encode("utf-8"))
sock.close()
