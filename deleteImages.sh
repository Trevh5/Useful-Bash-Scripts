#!/bin/bash
# Go through all images in a folder and delete the ones that are smaller than certain dimensions H and W

shopt -s nullglob
H=800
W=1400
deleted=0
numFiles=0
for var in *.jpg *.png *.gif
do
	((numFiles++))
	height=$( sips -g pixelHeight $var | awk '/pixelHeight:/{print $2}' )
	width=$( sips -g pixelWidth $var | awk '/pixelWidth:/{print $2}' )

	if [ "$height" -lt "$H" ]
	then
		echo "Height is too small. Deleting file: $var"
		rm $var
		((deleted++))
	elif [ "$width" -lt "$W" ]
	then
		echo "Width is too small. Deleting file: $var"
		rm $var
		((deleted++))
	fi
done
echo "$deleted files of $numFiles removed."
((remaining=numFiles-deleted))
echo "$remaining files remaining."
