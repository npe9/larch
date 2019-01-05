# Makefile for ~lp/html/logic

DIR = logic

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

files: bracket.html
files: conditional.html
files: connective.html
files: constant.html
files: deduction-rule.html
files: equality.html
files: equation.html
files: formula.html
files: function.html
files: inconsistency.html
files: induction-rule.html
files: infix.html
files: logic.html
files: operator.html
files: operator-theory.html
files: overload.html
files: partitioned-by.html
files: precedence.html
files: quantifier.html
files: rewrite-rule.html
files: signature.html
files: sort.html
files: system.html
files: term.html
files: variable.html
