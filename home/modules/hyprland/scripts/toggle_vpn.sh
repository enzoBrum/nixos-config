#!/bin/sh

if  nmcli c show --active | grep "labsec">/dev/null;  then
    nmcli c down labsec
    echo -n "vpn-down" | socat - UNIX-CONNECT:/tmp/color_server.sock
else
    nmcli c up labsec
    echo -n "vpn-up" | socat - UNIX-CONNECT:/tmp/color_server.sock
fi

