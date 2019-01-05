### Makefile for ~lp/code/genlib

#	make tidy	   	remove backup copies of source files
#	make clean	   	remove all object files and executables

###############################################################################

DIR	= genlib

EQUATES	= Genlib

SOURCES	= array_seq collection combinator comparison comtable failure file    \
	  hash_table home_directory integer int_map iodev keyed_mapping       \
          linked list mapping matrix maybe_obj multiset permute printer	      \
	  queue set signals stack string_int subseq_gen

OTHERS	= gcd_tab-sun3 gcd_tab-vax graph interrupt no_interrupt

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
