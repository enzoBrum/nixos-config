#!/usr/bin/env bash
mkfs.fat -F 32 -n BOOT /dev/sda1 

cryptsetup luksFormat /dev/sda2

cryptsetup open /dev/sda2 root -

mkfs.btrfs -L NIX /dev/mapper/root

mount /dev/mapper/root /mnt
btrfs subv create /mnt/@
btrfs subv create /mnt/@home
btrfs subv create /mnt/@swap
btrfs subv create /mnt/@nix

umount /mnt

mount -o subvol=@ /dev/mapper/root /mnt
mount --mkdir -o subvol=@home /dev/mapper/root /mnt/home
mount --mkdir -o subvol=@nix /dev/mapper/root /mnt/nix
mount --mkdir -o subvol=@swap /dev/mapper/root /mnt/swap
mount --mkdir /dev/sda1 /mnt/efi

btrfs filesystem mkswapfile -s 10G /mnt/swap/swapfile

nixos-generate-config --root /mnt
rm hardware-configuration.nix
cp * /mnt/etc/nixos

nix-shell -p sbctl --run 'sbctl create-keys'
nix-shell -p sbctl --run 'sbctl enroll-keys --microsoft'
cp -r /etc/secureboot /mnt/etc

nixos-install --flake /mnt/etc/nixos/flake.nix#enzoPC --root /mnt
