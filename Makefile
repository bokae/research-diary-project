# Custom Makefile for Compiling Research Diaries
# ----------------------------------------------
#
#  Author:   Mikhail Klassen, Eszter Bokányi
#  Email:    klassm@mcmaster.ca, e.bokanyi@gmail.com
#  Created:  21 November 2011
#  Modified: 31 January 2018

# Set the diary year you wish to compile and user info
YEAR := 2018
AUTHOR := Ferenc Bencs
INSTITUTION := Central European University
SHORT_INSTITUTION := CEU

# Do not edit past this line
RM := rm -rf
SHELL := /bin/bash

.PHONY : clean

anthology:  BASENAME=$(YEAR)-Research-Diary
project: BASENAME=$(name)-Research-Diary

anthology:
	BASENAME=$(YEAR)-Research-Diary
	-@echo 'Creating anthology for research diary entries from the year $(YEAR)'
	-@$(SHELL) src/create_anthology.sh "$(YEAR)" "$(AUTHOR)" "$(INSTITUTION)" "$(SHORT_INSTITUTION)"
	-pdflatex $(BASENAME).tex
	-makeindex $(BASENAME).idx
	-pdflatex $(BASENAME).tex
	-bibtex $(BASENAME).aux
	-pdflatex $(BASENAME).tex
	-$(RM) *.ind *.texr *.tex *.tmp *.log *.out *.tmp *.ilg *.idx *.blg *.bbl *.aux *.swp	
	-evince $(BASENAME).pdf

project:
	-@echo 'Creating anthology for research diary entries for the project "$(name)"'
	-@$(SHELL) src/create_project_diary.sh "$(name)" "$(YEAR)" "$(AUTHOR)" "$(INSTITUTION)" "$(SHORT_INSTITUTION)"
	-pdflatex $(BASENAME).tex
	-makeindex $(BASENAME).idx
	-pdflatex $(BASENAME).tex
	-bibtex $(BASENAME).aux
	-pdflatex $(BASENAME).tex
	-$(RM) *.ind *.texr *.tex *.tmp *.log *.out *.tmp *.ilg *.idx *.blg *.bbl *.aux *.swp	
	-evince $(BASENAME).pdf

