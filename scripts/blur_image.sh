#!/usr/bin/env bash
nix-shell -p imagemagick --run "convert $1 -blur 0x5 blurred"
