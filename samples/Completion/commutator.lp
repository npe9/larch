% Proof of commutator theorem for groups: if x*x*x = e, then [[x,y],y] = e

% See Test Problem 2 in Larry Wos, ``Automated Reasoning: 33 Basic Research 
% Problems,'' Prentice-Hall, 1988.

set log commutator

clear
execute group
complete

set name commutator
declare operator [__, __]: G, G -> G
assert [x, y] = i(x)*i(y)*x*y
complete

set name exponent3
assert x*x*x = e

set name theorem
prove [[x, y], y] = e
  set completion-mode big
  complete
  qed

display
statistics
