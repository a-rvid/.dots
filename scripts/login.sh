#!/usr/bin/env sh
export PATH=/run/current-system/sw/bin:$PATH

for _ in $(seq 1 40); do
  mountpoint -q /home/user/.crypt && break
  sleep 0.25
done

cd /home/user/.crypt || exit 0
exec stow --target=/home/user .
