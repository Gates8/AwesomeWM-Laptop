#!/bin/sh

pacmd list-sink-inputs | grep -e 'state:' -e 'application.name' | grep -B 1 Spotify | grep -P -o '(?<=: )[A-Za-z]*'

