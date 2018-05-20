#!/bin/sh

year=`date +%G`
month=`date +%m`
day=`date +%d`

FILE=$year-$month-$day

echo "Compiling $TEXFILE."

#latex -interaction=batchmode -halt-on-error $TEXFILE 
#dvips -q -o "$PSFILE" "$DVIFILE" -R0
#ps2pdf "$PSFILE" "$PDFFILE"

pdflatex $FILE
bibtex --include-directory="../biblio" $FILE
pdflatex $FILE 

rm -f *.out *.dvi *.ps *.tex.backup *~ *.aux *.log
