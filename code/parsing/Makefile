### Makefile for ~lp/code/parsing

#	make tidy	   	remove backup copies of source files
#	make clean	   	remove all object files and executables

###############################################################################

DIR	= parsing

EQUATES	= Parsing

SOURCES	= generic identifier id_table keyword_table pdeduction_rule pfact     \
	  pformula pinduction_rule poperator pop_theory psignature psort      \
	  psubstitution pterm pvariable scanner symtab token unpterm

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
