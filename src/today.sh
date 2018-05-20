#!/bin/bash

year=`date +%G`
month=`date +%m`
day=`date +%d`

echo "Today is $year/$month/$day"
filename=$year-$month-$day.tex

if [ -e $year"/"$filename ]
# if there is already a file for today
then
	if [ "$1" == 'compile' ]
	then
		cd $year
		../src/compile_today.sh
		cd ..
		evince $year/$filename 
	elif [ "$1" == '-p' ]
	# if we would only like to add a project name	
	then
		echo -e $year"/"$filename","$2 >> src/projects
		echo "Added project "$2"."
	else
		nohup kile $year"/"$filename > /dev/null 2>&1 & 
	fi
else
	for var in "$@"
	do
		echo "Added project "$var"."		
		echo $year"/"$filename","$var >> src/projects
	done
	"./"add_entry
	nohup kile $year"/"$filename > /dev/null 2>&1 &
fi
