### Makefile for ~lp/code/logic

#	make tidy	   	remove backup copies of source files
#	make clean	   	remove all object files and executables

###############################################################################

DIR	= logic

EQUATES	= Logic

SOURCES	= axiom_system critical deduction_rule deduction_system 	      \
	  elimination embed equation_system fact flatten formula 	      \
	  hardwired_drs hardwired_ots hardwired_rrs induction_rule 	      \
	  induction_system match op_system op_theory overlaps proposition     \
	  rewriting_system rrp_table tracer 

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
