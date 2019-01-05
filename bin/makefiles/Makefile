### Makefile for ~lp/bin/makefiles

#	make tidy	   	remove backup copies of source files
#	make clean	   	remove all object files and executables

###############################################################################

RM 	= /bin/rm -f

.SILENT:

all:
	echo "Usage: make tidy"
	echo "       make clean"

tidy:
	${RM} *.old *.ckp *.bak ,* *~ \#*\# .*.old .*.ckp .*.bak .*~ core

clean: tidy
	${RM} clu.* *.bin *.lib *.lpscr *.lplog *.lpfrz
