set log fibGroup5

% The Fibonacci group F(n) with n generators {a1, ..., an} is defined by the 
% equations a1*a2 = a3, a2*a2 = a4, ..., an*a1 = a2. 

% We show that F(5) is a cyclic group of order 11.

clear
set trace 0
execute group
complete

set name fib
declare operators a1, a2, a3, a4, a5: -> G
register bottom a1
assert
  a1*a2 = a3;
  a2*a3 = a4;
  a3*a4 = a5;
  a4*a5 = a1;
  a5*a1 = a2
  ..
complete

prove a1*a1*a1*a1*a1*a1*a1*a1*a1*a1*a1 = e
  qed
prove a2 = a1*a1*a1*a1
  qed
prove a3 = a1*a1*a1*a1*a1
  qed
prove a4 = a1*a1*a1*a1*a1*a1*a1*a1*a1
  qed
prove a5 = a1*a1*a1
  qed

display
statistics
