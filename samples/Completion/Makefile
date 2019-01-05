### Makefile for LP/samples/Completion

#TEST 	= /usr/local/lp
#TEST	= ../../bin/lp  -d ../..
TEST	= ../../bin/lp -d ../..

MV	= /bin/mv
RM	= /bin/rm -f

DRIVERS	= _abgrp.lp _b-ring.lp _c-ring-u.lp _c-ring.lp _group.lp _group1.lp   \
	  _group2.lp _group2a.lp _grt.lp _l-r.lp _lattice.lp _ring-u.lp       \
	  _ring.lp _taussky.lp 

SOURCES = commutator.lp fibGroup5.lp groupHomo.lp

FILES	= Makefile README

.SILENT:

examples:
	echo "Completing axioms for algebras"
	for n in ${DRIVERS} ${SOURCES};  			  	      \
          do ${TEST} $$n < /dev/null > /dev/null;   		              \
          done
	make Statistics

Statistics: *.lplog
	sed -n -e "/Larch Pro/s/ logging.*/)/p" -e "/Larch Pro/q" *.lplog     \
	     > Statistics
	awk 'BEGIN { format = "%-12s%8s%7s%7s%9s%9s%9s%9s%9s\n"; 	     \
	      print "";						    	     \
              printf format, ".lp",       "critical", "orient", "deduce",    \
                             "unify", "rewrite", "order", "deduce", "total"; \
	      printf format, "",          "pairs",    "eqs",    "eqs",       \
                             "time",  "time",    "time",  "time",  "time";   \
	      printf format, "----------", "-----",    "---",    "------",   \
                             "-----", "------",  "-----", "------", "-----"; \
	      print "" }' /dev/null >> Statistics
	for n in `ls *.lplog`; 						     \
	     do	awk 'BEGIN { format = "%-12s%8s%7s%7s%9s%9s%9s%9s%9s\n" }    \
	      	     $$1 == "Ordering"	  { eqs = $$2; order = $$6 }         \
	             $$1 == "Rewriting"   { rrs = $$2; rr = $$6 }            \
	             $$1 == "Deductions"  { drs = $$2; dr = $$6 }            \
	             $$1 == "Unification" { cp = $$2; unify = $$6 }          \
		     $$1 == "Total"	  { total = $$3}	             \
	             END { for (i=1; substr(FILENAME,i,1) != "."; i++);      \
			   printf format, substr(FILENAME,1,i-1), cp, eqs,   \
			          drs, unify, rr, order, dr, total }' 	     \
	         $$n >> Statistics;					     \
	      done

backup:
	for n in `ls *.lplog`; do ${MV} $$n $$n~; done

tidy:
	${RM} *.old *.ckp *.bak ,* *~ \#*\# .*.old .*.ckp .*.bak .*~ core

clean: tidy
	${RM} *.lpfrz *.lplog *.lpscr Statistics

