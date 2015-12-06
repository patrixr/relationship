#!/bin/bash

function fetchConfig {
    config=$(grep -o "$1\s*=\s*.*" Config.lua | cut -d "\"" -f 2 | cut -d "'" -f 2)
    if [  -z "$config" -a "$config" != "" ]; then
	config="unknown"
    fi
    echo "$config" | sed -e 's/ /_/g'
}

#
# Fetch title
#
buildFolder="build"
title=$(fetchConfig title)
version=$(fetchConfig version)

echo "-- Building $title"
echo "-- Version $version"

if [ ! -d "$buildFolder" ]; then
    mkdir "$buildFolder"
fi

filename="$buildFolder/$title-$version.love"

#
# List files require for build
#
ls \
    | grep -v "/\..*" \
    | grep -v "^.*\.zip$" \
    | grep -v "^.*\.sh$" \
    | grep -v "^.*\.love$" \
    | grep -v "^build.sh$" \
    | grep -v "^build$" \
    | xargs -I {} zip -R "$filename" {}


echo "-- Packaged app : $filename"
