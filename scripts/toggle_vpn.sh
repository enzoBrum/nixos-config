#!/bin/sh

if  nmcli c show --active | grep "labsec">/dev/null;  then
    nmcli c down labsec
else
    nmcli c up labsec
fi

