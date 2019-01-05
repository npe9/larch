### Makefile for ~lp/bin


### Commands for making lp (see below for optional parameters)

#	make		same as "make lp"
#	make all	create lp from scratch or after modifying interfaces
#	make lp	      	recreate lp from modified sources
#	make install	install executable for lp in this directory

#	make allplp	create experimental plp from scratch or after
#			modifying module interfaces
#	make plp	recreate plp from modified sources

### Parameters for customizing lp

#	PLATFORM  Machine type
#	REL	  Name of release
#	H	  Maximum heap size  (in megabytes; affects vax, sun3 only)
#	S	  Maximum stack size (in megabytes; affects vax, sun3 only)

PLATFORM	= linux
REL		= lp3.1b
H		= 2
S		= 64

### Known platforms

CLU-PLATFORMS	= vax sun3
PCLU-PLATFORMS	= alpha decmips linux mips solaris sparc
PLATFORMS	= ${CLU-PLATFORMS} ${PCLU-PLATFORMS}


### Commands for modifying and debugging lp

#	make lp.lib	   	create lp.lib from scratch
#	make libpass		recreate lp.lib after minor modifications
#	make makefiles		rebuild makefiles, subdirectories
#	make debug	   	create files for debugger
#	make tidy	   	remove junk
#	make clean	   	remove all object files and executables


### Usage and limitations

#      CLU must be installed properly.  The shell command "printenv" should 
# show that CLUHOME is defined to be the home directory for CLU.

#      To incorporate a change in a source file that does not affect a module
# interface, simply type "make lp" in ~lp/bin.  To create lp from scratch, type
# "make all".

#      When a change affects a module interface, it is also necessary to type
# "make lp.lib".  (There is no way for these Makefiles to tell whether or not a
# change to a source file affects an interface.)  As a shortcut, it sometimes
# suffices to type "make libpass".

#      When a new source (.clu) file is created, or an old one deleted, insert
# its name in, or delete it from, the Makefile in its directory (a subdirectory
# of ~lp/code) and type "make makefiles" in ~lp/bin.

#      When a new equates (.equ) file is created, insert its name in the
# Makefile in its directory.  When an equates (.equ) file is changed, it is
# necessary to explicitly remake all files with sources that depend on the
# equates file.  These Makefiles do not keep track of dependencies on equates
# files.

###############################################################################

# Related directories

CODE	  	= ../code
PLPDIR		= ../plpdir

# Directories for building LP

PRODDIR		= ${PLATFORM}/prod
DEBUGDIR	= ${PLATFORM}/debug


# Shell commands

CP	= /bin/cp
LN	= /bin/ln -s
MV	= /bin/mv
RM	= /bin/rm -f
MKDIR	= /bin/mkdir
STRIP	= strip


# Make commands

.SILENT:

lp: ${PRODDIR}/Makefile ${PRODDIR}/lp.lib fictitious_file
	cd ${PRODDIR}; make H=$H S=$S PLATFORM=${PLATFORM}
all:
	${CP} ${CODE}/main/Makefile.lp ${CODE}/main/Makefile
	date
	make makefiles lp.lib lp install H=$H S=$S PLATFORM=${PLATFORM}
	date

debug: ${DEBUGDIR}/Makefile ${PRODDIR}/lp.lib fictitious_file
	cd ${DEBUGDIR}; make 

install:
	cd ${PRODDIR}; make install H=$H S=$S REL=${REL}

lp.lib: 
	cd ${PRODDIR}; make lp.lib

libpass:
	cd ${PRODDIR}; make libpass

makefiles: fictitious_file
	echo "Creating Makefiles for ${PLATFORM}"
	make directory THEDIR="${PLATFORM}"
	for m in debug prod;						      \
	    do make directory THEDIR="${PLATFORM}/$$m";			      \
	       ${CP} makefiles/${PLATFORM}.$$m ${PLATFORM}/$$m/Makefile;      \
	       (cd ${PLATFORM}/$$m; make Makefile PLATFORM=${PLATFORM});      \
	    done

directory: fictitious_file
	-if test ! -d ${THEDIR}; then mkdir ${THEDIR}; else true; fi

plp: 
	cd ${PLPDIR}; make
	make lp PLATFORM=${PLATFORM}
	${CP} lp lp4plp
	${LN} ${PLPDIR}/plp .

allplp:
	${CP} ${CODE}/main/Makefile.plp ${CODE}/main/Makefile
	make makefiles lp.lib plp PLATFORM=${PLATFORM}
	
${PRODDIR}/lp.lib: ${PRODDIR}/Makefile
	make lp.lib PLATFORM=${PLATFORM}

${PRODDIR}/Makefile: 
	make makefiles PLATFORM=${PLATFORM}

${DEBUGDIR}/Makefile:
	make makefiles PLATFORM=${PLATFORM}

fictitious_file:

tidy: tidy1
	-for i in makefiles ${PLATFORMS};				      \
	     do if test -d $$i; then (cd $$i; make tidy); else true; fi;      \
	     done

tidy1:
	${RM} *.old *.ckp *.bak *~ \#*\# .*.old .*.ckp .*.bak .*~ core

clean: tidy1
	${RM} -r lp* xlp *.lp* ${PLATFORMS}
	cd makefiles; make clean
