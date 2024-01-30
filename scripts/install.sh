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

mkdir -p /mnt/etc/nixos

nix-shell -p sbctl --run 'sbctl create-keys'
nix-shell -p sbctl --run 'sbctl enroll-keys --microsoft'
cp -r /etc/secureboot /mnt/etc

mkdir -p /mnt/home/erb/repos
cd /mnt/home/erb/repos
git clone https://github.com/enzoBrum/nixos-config.git

read -sp "Age private key: " key
echo $key > /mnt/etc/keys.txt
mkdir -p /mnt/home/erb/.config/sops/age
cp /mnt/etc/age-keys.txt /mnt/home/erb/.config/sops/age/

nixos-install --root /mnt --flake "github:enzoBrum/nixos-config"#enzoPC
nixos-enter --root /mnt && chown erb -R /home/erb/
