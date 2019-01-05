% Definition of the Ackermann function

set name ackermann

declare sort Nat
declare variables i, j: Nat
declare operators
  0 :          -> Nat
  s : Nat      -> Nat
  a : Nat, Nat -> Nat
  ..

assert
  a(0, i) = s(i);
  a(s(i), 0) = a(i, s(0));
  a(s(i), s(j)) = a(i, a(s(i), j))
  ..
