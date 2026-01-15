#!/bin/sh

if  systemctl status openvpn-labsec.service | grep running;  then
    systemctl stop openvpn-labsec.service 
    echo -n "vpn-down" | socat - UNIX-CONNECT:/tmp/color_server.sock
else
    systemctl start openvpn-labsec.service 
    echo -n "vpn-up" | socat - UNIX-CONNECT:/tmp/color_server.sock
fi

