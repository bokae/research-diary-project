# Custom Makefile for Compiling Research Diaries
# ----------------------------------------------
#
#  Author:   Mikhail Klassen, Eszter Bokányi
#  Email:    klassm@mcmaster.ca
#  Created:  21 November 2011
#  Modified: 3 January 2012

# Set the diary year you wish to compile and user info
YEAR := 2017
AUTHOR := Ferenc Bencs
INSTITUTION := Central European University
SHORT_INSTITUTION := CEU

# Do not edit past this line
RM := rm -rf
SHELL := /bin/bash

BASENAME = $(YEAR)-Research-Diary

TEXFILE := $(BASENAME).tex
LOGFILE := $(BASENAME).log
PDFFILE := $(BASENAME).pdf
AUXFILE := $(BASENAME).aux
OUTFILE := $(BASENAME).out
IDXFILE := $(BASENAME).idx
BIBFILE := bibliography.bib 
INDFILE := $(BASENAME).ind


.PHONY : clean

anthology:
	-@echo 'Creating anthology for research diary entries from the year $(YEAR)'
	-@$(SHELL) src/create_anthology.sh "$(YEAR)" "$(AUTHOR)" "$(INSTITUTION)" "$(SHORT_INSTITUTION)"
	-pdflatex $(TEXFILE)
	-makeindex $(IDXFILE)
	-pdflatex $(TEXFILE)
#	-latex -interaction=batchmode -halt-on-error $(TEXFILE) 
#	-dvips -q -o "$(PSFILE)" "$(DVIFILE)" -R0
#	-ps2pdf "$(PSFILE)" "$(PDFFILE)"
	-evince $(PDFFILE)


clean:
	-$(RM) $(TEXFILE)
	-$(RM) $(LOGFILE) $(DVIFILE) $(PSFILE) $(AUXFILE) $(OUTFILE) $(IDXFILE) $(INDFILE) $(BASENAME).ilg
	-$(RM) *.tmp
	-@echo 'Done cleaning'
