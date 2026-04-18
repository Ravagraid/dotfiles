#!/bin/bash

curl -L https://gist.github.com/Ravagraid/5b0dd82fb0a07da7b72d135cc867bc72/raw/ -o pacman-list.pkg
pacman -S - < pacman-list.pkg
rm pacman-list.pkg
