#!/bin/bash

Project="$1"
Year="$2"
Author="$3"
Institution="$4"
ShortInstitution="$5"
Name="$Project-Research-Diary"
FileName=$Name".tex"
tmpName=$Name".tmp"

if [ -z "$Year" ]; then echo "ERROR: Year not specified."; exit; fi
if [ -z "$Author" ]; then echo "ERROR: Author not specified."; exit; fi
if [ -z "$Institution" ]; then echo "ERROR: Institution not specified."; exit; fi

echo "Research Diary"
echo "User: $Author ($Institution)"
echo "Year: $Year"
echo "Project: $Project"

path=`pwd`
if [ "`basename $path`" == 'src' ]; then
    cd ..
fi

touch $FileName
echo "%" > $FileName
echo "% Research Diary for $Author ($Institution), $Year, $Project" >> $FileName
echo "%" >> $FileName
echo "\documentclass[letterpaper,11pt]{article}" >> $FileName
echo "\newcommand{\userName}{$Author}" >> $FileName
echo "\newcommand{\institution}{$Institution}" >> $FileName
echo "\newcommand{\shortinstitution}{$ShortInstitution}" >> $FileName
echo "\usepackage{research_diary}" >> $FileName
echo " " >> $FileName
echo "\title{$Project - $Year}" >> $FileName
echo "\author{$Author}" >> $FileName
echo " " >> $FileName

echo "\chead{\textsc{$Project}}" >> $FileName
echo "\lhead{\textsc{\userName}}" >> $FileName
echo "\rfoot{\textsc{\thepage}}" >> $FileName
echo "\cfoot{\textit{Last modified: \today}}" >> $FileName
echo "\lfoot{\textsc{\shortinstitution}}" >> $FileName
echo "\graphicspath{{$Year/}{~/research/diary/$Year/}{~/research/diary/$Year/images/}}" >> $FileName
echo "\makeindex" >> $FileName

inp=$(cat src/include | grep -v "#" | sed -r 'N;s/\n/\#/g' | sed -r 's/([^\#]*)/\\\\input{\1}/g')
sed -ir "s/@inputs/$inp/g" $FileName
sed -ir "s/\#/\n/g" $FileName 

echo " " >> $FileName
echo " " >> $FileName
echo "\begin{document}" >> $FileName
echo "\begin{center} \begin{LARGE}" >> $FileName
echo "\textbf{$Project} \\\\[3mm]" >> $FileName
echo "\textbf{$Year} \\\\[2cm]" >> $FileName
echo "\end{LARGE} \begin{large}" >> $FileName
echo "$Author \end{large} \\\\" >> $FileName
echo "$Institution \\\\[7in]" >> $FileName
echo "\textsc{Compiled \today}" >> $FileName
echo "\end{center}" >> $FileName
echo "\thispagestyle{empty}" >> $FileName
echo "\newpage" >> $FileName

cat src/projects | grep -v "#" | sort > tempproj

echo "%" > $tmpName
while read line 
do
    t=`echo -n "$line" | cut -f1 -d","`
    p=`echo -n "$line" | cut -f2 -d","`
    echo "$line"
    echo "$p"   
    echo "$Project"
    
    if [ "$p" == "$Project" ]
    then
        echo "I\'m in!"
        echo -e "\n%%% --- $t --- %%%\n" >> $tmpName
        echo "\rhead{`grep workingDate $t | cut -d { -f 4 | cut -d } -f 1`}" >> $tmpName
        sed -n '/\\begin{document}/,/\\end{document}/p' $t >> $tmpName
        echo -e "\n" >> $tmpName
        echo "\newpage" >> $tmpName
    fi
done < tempproj
rm tempproj


sed -i 's/\\begin{document}//g' $tmpName
sed -i 's/\\end{document}//g' $tmpName
sed -i 's/\\includegraphics\(.*\){\([A-Za-z0-9]*\)\/\([A-Za-z0-9_-]*\)/\\includegraphics\1{\3/g' $tmpName
sed -i 's/\\newcommand/\\renewcommand/g' $tmpName

cat $tmpName >> $FileName

echo "\newpage" >> $FileName
echo "\printindex" >> $FileName
echo "\end{document}" >> $FileName

if [ "`basename $path`" == 'src' ]; then
    cd src
fi

rm $tmpName
