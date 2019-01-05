### Makefile for ~lp/code/main

#	make tidy	   	remove backup copies of source files
#	make clean	   	remove all object files and executables

###############################################################################

DIR	= main

EQUATES	= Debugging Query ZMain

# NOTE: The name of ZMain.equ must collate after the names of other .equ files

SOURCES	= abort c_apply c_assert c_box c_cancel c_class c_clear c_complete    \
	  c_critical c_declare c_delete c_diamond c_display c_execute         \
	  c_find_instantiations c_fix c_forget c_freeze c_help c_history      \
	  c_instantiate c_make c_normalize c_order c_pop c_prove c_push c_qed \
	  c_quit c_register c_resume c_rewrite c_set c_show c_statistics      \
	  c_stop c_thaw c_unorder c_unregister c_unset c_version c_write      \
	  c_zap check_end commands front_end interactive prover               \
	  query settings start_up statistics system

OTHERS = version

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
