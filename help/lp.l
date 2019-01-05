.\" The following string defs should be changed to reflect the manner in which
.\" LP is installed:
.\" .ds LD /usr/local/lib/LP  directory with runtime support for LP
.\" .ds LE /usr/local/bin/lp  location of executable version of LP 
.ds LD /usr/local/lib/LP
.ds LE /usr/local/bin/lp
.
.TH LP l "December 1, 2016"
.UC 4
.SH NAME
lp \- The Larch Prover (Release 3.1c)
.SH SYNOPSIS
.B lp
[
.I options
] [
.IR file .\|.\|.
]

.SH DESCRIPTION 
.PP
The Larch Prover (lp) is an interactive proof assistant for multisorted 
first-order logic.  It can be used to axiomatize theories and to provide 
assistance in proving theorems. 
.SH OPTIONS
.TP
.BI \-d " directory-name"
Specifies a location other than 
.I \*(LD
for LP's help files and library of axiomatizations.
.TP
.B \-t
Sets testing mode, in which errors do not terminate execution of command files.
.SH USAGE
.PP
LP is a command-driven system that either prompts its user for input or
executes commands from files.  By convention, the names of command
files end with the suffix
.IR .lp .
The shell command
.RS
.BI lp " file1 .\|.\|. fileN"
.RE
causes LP to execute the commands in the files
.IR file1.lp ,
...
.IR fileN.lp ,
and then to prompt the user for input when those file are exhausted.
.PP
Information about how to use LP can be obtained by typing the LP command
.RB   `` help 
.IR   topic ''.
Type
.RB   `` help 
.BR   LP ''
for a general introduction to LP, or
.RB   `` help 
.BR   ? ''
for a list of all 
.I topics
on which help is available.  The same information is also available in
hypertext format, with
.I \*(LD/html/introduction.html
as the home page.
.PP
In most cases when LP expects input, you can type a question mark (?)
to obtain a summary of the legal responses.

.SH FILES
.ta \w'\*(LE/algebra   'u
\*(LE	LP executable
.br
\*(LD	LP's library area
.br
\*(LD/html	Directory of documentation for LP
.br
\*(LD/axioms	Directory of axioms

.SH "AUTHORS"
LP was developed by Stephen J. Garland and John V. Guttag
at the MIT Laboratory for Computer Science.
