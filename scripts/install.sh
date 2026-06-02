#!/usr/bin/env bash
# Installs this NixOS flake onto a target disk using disko.
# Usage: ./install.sh <disk> [flake-module]
#   e.g. ./install.sh sda legolas   or   ./install.sh nvme0n1
#
# WARNING: this WIPES the target disk. Run from the NixOS installer ISO.

set -euo pipefail

if [ $# -lt 2 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "Usage: $0 <disk> [flake-modue]"
  echo
  echo "Available block devices:"
  lsblk -dno NAME,SIZE,MODEL,TYPE | awk '$NF == "disk" { $NF=""; print "  " $0 }'
  exit 1
fi

DISK="/dev/$1"

FLAKE_MODULE=$2

if [ ! -b "$DISK" ]; then
  echo "Error: $DISK is not a block device." >&2
  exit 1
fi

cd "$(dirname "$0")"

echo "About to partition and install NixOS onto:"
lsblk "$DISK"
echo
echo "Flake module: .#${FLAKE_MODULE}"
echo "ALL DATA ON $DISK WILL BE DESTROYED."
read -rp "Type the disk name again to confirm ($1): " confirm
if [ "$confirm" != "$1" ]; then
  echo "Aborted."
  exit 1
fi

sudo nix --extra-experimental-features "nix-command flakes" \
  run 'github:nix-community/disko/latest#disko-install' -- \
  --flake ".#${FLAKE_MODULE}" \
  --disk main "$DISK"

echo
echo "Install finished. You can reboot now."
