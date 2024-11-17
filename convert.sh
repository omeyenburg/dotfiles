#!/bin/sh

images=./wallpapers/*

for image in $images;
do
    path=$(dirname $image)
    old_name=$(basename $image)
    name=$(echo $old_name | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/;s/[ _]/-/g')

    if [ "$old_name" != "$name" ]; then
        mv $path/$old_name $path/$name
        echo "Renamed $path/$old_name to $path/$name."
    fi

    if [[ $name == *.gif ]]; then
        echo "GIF format is unsupported! $name" 
	continue
    fi

    if [[ $name != *.jpg ]]; then
        new_name="$(echo $name | sed 's/\(.*\)\..*/\1/').jpg"
        magick $path/$name $path/$new_name
	rm $path/$name
        echo "Converted $path/$name to $path/$new_name."
    fi
done
