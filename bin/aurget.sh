#!/bin/bash

curl -L https://gist.github.com/Ravagraid/3750abf888db7e764ae172d6d4c13a58/raw/ -o aur-list.pkg
exec 9<aur-list.pkg
while read -u9 pkg; do paru -S --noconfirm --needed $pkg; done
