#!/bin/sh

if  nmcli c show --active | grep "labsec">/dev/null;  then
    echo -n "vpn-down" | socat - UNIX-CONNECT:/tmp/color_server.sock
    nmcli c down labsec
else
    nmcli c up labsec
    echo -n "vpn-up" | socat - UNIX-CONNECT:/tmp/color_server.sock
fi

