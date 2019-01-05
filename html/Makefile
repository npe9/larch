# Makefile for ~lp/html

DIRS = commands glossary logic misc operation ordering proof releases \
       settings symbols

.SUFFIXES: .html .tex

.tex.html: 
	echo 'sed -f tex2html $*.tex | sed -f tex2html > $*.html'
	sed -f tex2html $*.tex | sed -f tex2html > $*.html

all: local
	for i in ${DIRS}; do (cd $$i; make all); done
	#make hardcopy

local: files

again:
	make clean Makefile 
	for i in ${DIRS}; do (cd $$i; make clean Makefile); done	
	make all

hardcopy:
	# This needs to be fixed to generate proper links in all.html
	# (and to include the introduction just once).
	sed -e '/: Introduction/s//, the Larch Prover/' -e '/ \&mdash; Introduction/s///' \
            introduction.html > all.html
	echo "<p>&nbsp;<p>" >> all.html
	echo contents.html > fileList
	sed -n -e 1d -e '/.*"\(.*\)".*/s//\1/p' contents.html >> fileList
	for i in `cat fileList`; \
	    do  sed -e '1,/<body>/d' \
                    -e '/<h1>LP, the Larch Prover \&mdash; /s//<hr><h1>/' $$i >> all.html; \
	       echo "<p>&nbsp;<p>" >> all.html;        		           \
	    done

Makefile::
	/bin/rm -f Index.html *.tex Makefile.new
	ln -s ../help/*.tex .
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

tidy:   tidy1
	for i in ${DIRS}; do (cd $$i; make tidy); done

tidy1:
	/bin/rm -f *~ *.bak *.tex tmp tmp1 fileList

clean: tidy1
	/bin/rm -f *.html *.tex
	for i in ${DIRS}; do (cd $$i; make clean); done

files: contents.html
files: introduction.html
