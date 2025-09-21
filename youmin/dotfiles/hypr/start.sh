#!/usr/bin/env bash

# initialize wallpaper daemon
swww-daemon &
swww img ~/.cache/wallpapers/Anime-Girl1.png &

# Notification daemon
dunst &

# Input method
fcitx5 &
