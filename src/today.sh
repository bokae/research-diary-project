#!/bin/bash

year=`date +%G`
month=`date +%m`
day=`date +%d`

echo "Today is $year/$month/$day"
filename=$year-$month-$day.tex

if [ -e $year"/"$filename ]
then
	kile $year"/"$filename&
else
	"./"add_entry
fi
