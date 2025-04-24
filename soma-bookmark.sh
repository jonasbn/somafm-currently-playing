#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <station>"

    NOWPLAYING=$(nowplaying-cli get artist)
    echo "Now Playing: $NOWPLAYING"

    exit 1
fi

carton exec -- ./somafm-currently-playing.pl "$1" | tee -a ~/Dropbox/Documents/music.txt

exit $!
