# Makefile for ~lp/html/commands

DIR = commands

.SUFFIXES: .html .tex

.tex.html: 
	sed -f ../tex2html $*.tex | sed -f ../tex2html > $*.html

all: files

again:
	make clean Makefile 
	make all

Makefile::
	/bin/rm -f Index.html *.tex Makefile.new
	ln -s ../../help/${DIR}/*.tex .
	grep -v '^files:' Makefile > Makefile.new
	echo '<pre>' > Index.html
	for i in `ls *.tex | sed "s/.tex/.html/"`;		\
	    do echo files: $$i >> Makefile.new;			\
	       echo "<a href=\"$$i\">$$i</a>" >> Index.html;	\
	    done
	echo '</pre>' >> Index.html
	mv Makefile.new Makefile

xref:
	cat *.html						\
	  | tr '>' '\012' 					\
          | sed -n '/.*<a href="\([^"]*\)"/s//\1/p' 		\
          | sort -u						\
	  > tmp
	for j in `grep -v \# tmp`;				\
	    do if test -s $$j;					\
	       then true;					\
	       else echo $$j; 					\
	       fi;						\
	    done
	sed -n '/\(.*\)\#\(.*\)/s//if ( ! { grep -s name=\\"\2\\" \1 } ) echo \1	\2/p' tmp > tmp1
	csh -f tmp1

tidy:
	/bin/rm -f *~ *.bak *.tex tmp tmp1

clean: tidy
	/bin/rm -f *.html *.tex

files: apply.html
files: assert.html
files: box.html
files: cancel.html
files: clear.html
files: commands.html
files: comment.html
files: complete.html
files: critical-pairs.html
files: declare.html
files: define-class.html
files: delete.html
files: display.html
files: execute.html
files: fix.html
files: forget.html
files: freeze_thaw.html
files: help.html
files: history.html
files: instantiate.html
files: make.html
files: normalize.html
files: order.html
files: prove.html
files: push_pop.html
files: qed.html
files: quit.html
files: register.html
files: resume.html
files: rewrite.html
files: set.html
files: show.html
files: statistics.html
files: stop.html
files: unorder.html
files: unregister.html
files: unset.html
files: version.html
files: write.html
