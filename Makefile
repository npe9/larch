### Makefile for ~lp

PLATFORM = linux
REL      = lp3_1c
SUBDIRS  = axioms bin code help html samples

# Shell commands

COMPRESS = gzip
CP	 = /bin/cp -f
LN	 = /bin/ln -f -s
MV	 = /bin/mv
RM	 = /bin/rm -f


# Make commands

all: fictitious_file
	cd bin; make lp PLATFORM=${PLATFORM} REL=${REL}
	${LN} bin/${PLATFORM}/prod/lp .
	cd help; make
	cd html; make again; make tidy

dist: dist_lib dist_exe

dist_lib:
	cd axioms; make clean
	cd help; make tidy
	cd html; make tidy
	cd ..; tar cf ${REL}/dist/${REL}-lib.tar			\
	    ${REL}/axioms 						\
	    ${REL}/help 						\
	    ${REL}/html 						\
	    ${REL}/samples/README 					\
	    ${REL}/samples/Makefile					\
	    `ls ${REL}/samples/*.lp ${REL}/samples/*.doc`		\
	    ${REL}/samples/Completion/README 				\
	    ${REL}/samples/Completion/Makefile				\
	    `ls ${REL}/samples/Completion/*.lp`
	${COMPRESS} dist/${REL}-lib.tar

dist_exe:
	${CP} bin/${PLATFORM}/prod/lp dist/${REL}-${PLATFORM}
	${COMPRESS} dist/${REL}-${PLATFORM}

fictitious_file:

tidy: tidy1
	for i in ${SUBDIRS}; do (cd $$i; make tidy); done

tidy1:
	${RM} *.old *.ckp *.bak *~ \#*\# .*.old .*.ckp .*.bak .*~ core

clean: tidy1
	for i in ${SUBDIRS}; do (cd $$i; make clean); done
