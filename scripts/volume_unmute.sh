#!/bin/bash

# takes a volume level from 0 to 100, inclusive, as command line argument
# every second, this program unmutes various channels and sets the Master volume to that volume, ensuring that the user hasn't turned the sound off or down

while true; do
  amixer set Master "$*%" unmute > /dev/null # $* gets volume from command line arg
  amixer set Headphone unmute > /dev/null
  amixer set Speaker unmute > /dev/null
  amixer set PCM 100% unmute > /dev/null
  break
done

