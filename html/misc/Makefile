# Makefile for ~lp/html/misc

DIR = misc

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

files: abbreviation.html
files: class.html
files: command-arguments.html
files: command-line.html
files: conjecture.html
files: hints_formalizing.html
files: hints_io.html
files: hints_ordering.html
files: hints_proofs.html
files: hints_speed.html
files: hints.html
files: names.html
files: name.html
files: naming.html
files: philosophy.html
files: sample_assert.html
files: sample_axioms1.html
files: sample_axioms.html
files: sample_conjectures.html
files: sample_declare.html
files: sample_guidance.html
files: sample_proof1.html
files: sample_proof2.html
files: sample_proof3.html
files: sample_proof4.html
files: sample_proof5.html
files: sample_proof6.html
files: sample_start.html
files: sample.html
files: subgoal.html
