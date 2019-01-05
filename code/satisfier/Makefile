### Makefile for ~lp/code/satisfy

#	make tidy	   	remove backup copies of source files
#	make clean	   	remove all object files and executables

###############################################################################

DIR	= satisfier

EQUATES	= Satisfier

SOURCES	= TheoryB TheoryE TheoryR clause clause_list cnf egraph		     \
	  equiv_relation expression extend ground_system literal	     \
	  literal_table model numeric_matrix numeric_ops numeric_theory rat  \
	  rat_terms simplex subterm_graph tableau theory_system undoable_set \
	  unknown unknowns 

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
