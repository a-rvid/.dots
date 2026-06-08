#!/usr/bin/env sh
exec >>/tmp/login.sh.log 2>&1
echo "===== $(date -Iseconds) ====="
set -x
export PATH=/run/current-system/sw/bin:$PATH

ls -la /home/user/ | grep -E ' \.?crypt'
stat /home/user/.crypt 2>&1
readlink /home/user/.crypt 2>&1

for _ in $(seq 1 40); do
  mountpoint -q /home/user/.crypt && break
  sleep 0.25
done

stat /home/user/.crypt 2>&1
cd /home/user/.crypt || exit 0
exec stow --target=/home/user .
