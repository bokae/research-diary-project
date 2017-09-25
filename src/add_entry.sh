#!/bin/sh

year=`date +%G`
month=`date +%m`
day=`date +%d`

echo "Today is $year/$month/$day"

if [ ! -d "$year" ]; then
    mkdir $year
    mkdir $year/images
    cd $year
    ln -s ../images/university_logo.jpg .
    ln -s ../src/research_diary.sty .
    ln -s ../src/clean.sh clean
    ln -s ../src/compile_today.sh compile_today
    cd ..
fi

if [ -d "$year" ]; then
    echo "Adding new entry to directory $year."
fi

cd $year
filename=$year-$month-$day.tex

if [ -f "$filename" ]; then
    echo "A file called '$filename' already exists in diretory $year. Aborting addition of new entry."
    exit
fi

cp ../src/entry.tex $filename
echo "Finished adding $filename to $year."
