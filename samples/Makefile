### Makefile for LP/samples

TEST	= ../bin/lp -d ..
TEST1	= ../../bin/lp -d ../..

CP	= /bin/cp
MV	= /bin/mv
RM	= /bin/rm -f
MKDIR	= /bin/mkdir

SOURCES	= arbiterG.lp arbiterL.lp cpu.lp fib.lp list1.lp list2.lp mutex.lp \
          ring1.lp ring2.lp set.lp sorting.lp sum.lp

SUBDIRS = Completion

FILES	= Makefile README arbiter.doc

.SILENT:

samples:
	echo "Performing sample proofs"
	for n in ${SOURCES};           					      \
            do ${TEST} $$n < /dev/null > /dev/null;  			      \
            done
	make Statistics
	for d in ${SUBDIRS};						      \
	    do (cd $$d; make TEST="${TEST1}");				      \
	    done

Statistics: *.lplog
	sed -n -e "/Larch Pro/s/ logging.*//p" -e "/Larch Pro/q" *.lplog     \
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
	for d in ${SUBDIRS}; do (cd $$d; make tidy); done

clean: tidy
	${RM} *.lpfrz *.lpscr *.lplog Statistics
	for d in ${SUBDIRS}; do (cd $$d; make clean); done
