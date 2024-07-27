#!/bin/sh

if systemctl status openvpn-labsec | grep active | cut -d ":" -f 2 | grep -w "active"; then
    systemctl stop openvpn-labsec
    echo -n "vpn-down" | socat - UNIX-CONNECT:/tmp/color_server.sock
else
    systemctl start openvpn-labsec
    echo -n "vpn-up" | socat - UNIX-CONNECT:/tmp/color_server.sock
fi

