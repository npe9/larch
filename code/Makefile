### Makefile for ~lp/code

#	make tidy	   	remove backup copies of source files
#	make clean	   	remove all object files and executables


###############################################################################

SUBDIRS	= genlib parsing terms names unify logic ordering satisfier main

CP	= /bin/cp
MV	= /bin/mv
RM	= /bin/rm -f

.SILENT:

all:
	echo "Usage: make tidy"
	echo "       make clean"

tidy: tidy1
	for i in ${SUBDIRS}; do (cd $$i; make tidy); done

tidy1:
	${RM} *.old *.ckp *.bak ,* *~ \#*\# .*.old .*.ckp .*.bak .*~ core

clean: tidy1
	${RM} *.lpfrz *.lpscr *.lplog
	for i in ${SUBDIRS}; do (cd $$i; make clean); done
