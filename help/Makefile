# Makefile for ~lp/help

# The help files in this directory (and its subdirectories) have names ending
# in .tex.  They are meant to be used by LP's "help" command, which recognizes
# the specialized TeX commands (such as \dlink) they contain and which relies
# on the existence of the file "~lp/help/Topics".  This Makefile consructs
# this file, which contains a sequence of lines like
#    Foverview.tex
#    Toverview
#    Tlp
#    Fcommands/commands.tex
#    Tcommands
#    ...
# giving the names of the help files together with the topics they explain.
# No topic should be explained in more than one help file.  The first topic
# listed for each help file will be the one LP displays in the list of all
# topics produced in response to the command "help ?".

DIRS = commands glossary logic misc operation ordering proof releases \
       settings symbols

Topics:
	for i in `ls *.tex */*.tex`;				\
	    do echo F$$i >> Topics;				\
	       sed -n '/\\ref{\(.*\)}/s//T\1/p' $$i >> Topics;	\
	    done

lp.doc: lp.l
	nroff -man lp.l > lp.doc

tidy:	tidy1
	for i in ${DIRS}; do (cd $$i; make tidy); done

tidy1:
	/bin/rm -f *~ *.bak

clean: tidy1
	/bin/rm -f Topics
	for i in ${DIRS}; do (cd $$i; make clean); done
