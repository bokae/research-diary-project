#!/bin/bash

year=`date +%G`
month=`date +%m`
day=`date +%d`

echo "Today is $year/$month/$day"
filename=$year-$month-$day.tex

if [ -e $year"/"$filename ]
then
	nohup kile $year"/"$filename > /dev/null 2>&1 & 
else
	"./"add_entry
	nohup kile $year"/"$filename > /dev/null 2>&1 &
fi

