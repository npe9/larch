### Makefile for ~lp/code/unify

#	make tidy	   	remove backup copies of source files
#	make clean	   	remove all object files and executables

###############################################################################

DIR	= unify

EQUATES	= Unify

SOURCES	= ac_unify assign c_unify diophan empt_unify hullot plh_eqn \
          quant_unify solution term_space unify 

# This directory relative to ~lp/bin/*/prod

SDIR	= ../../../code/${DIR}

RM 	= /bin/rm -f
LN	= /bin/ln -s

.SILENT:

all:
	echo "Usage: make tidy"
	echo "       make clean"


# Entries invoked by ~lp/bin/Makefile

link:
	for f in ${EQUATES}; do ${LN} "${SDIR}/$$f.equ" .; done
	for f in ${SOURCES}; do ${LN} "${SDIR}/$$f.clu" .; done

tidy:
	${RM} *.old *.ckp *.bak ,* *~ \#*\# .*.old .*.ckp .*.bak .*~ core

clean: tidy
	${RM} clu.* *.bin *.lib *.lpscr *.lplog *.lpfrz
