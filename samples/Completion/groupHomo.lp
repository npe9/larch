% Sample theorems about homomorphic images of groups

set log groupHomo

clear
execute group
complete

% Let h: G -> G be a homomorphism with respect to *.

set name homomorphism
declare operator h: G -> G
register height h > (i, *, e)
assert h(x*y) = h(x)*h(y)
complete


% Then h is a homomorphism with respect to e and i.

prove h(e) = e
  qed
prove h(i(x)) = i(h(x))
  qed


% The kernel of h is a normal subgroup of G.

set name kernel
declare operator kernel: G -> Bool
assert kernel(x) <=> h(x) = e

set proof-methods =>, normalization
prove kernel(e)
  qed
prove kernel(x) => kernel(i(x))
  qed
prove kernel(x) /\ kernel(y) => kernel(x*y)
  qed
prove kernel(x) => kernel(i(y)*x*y)
  qed


% The composition of two homomorphisms is a homomorphism.

set name composition
declare operator g: G -> G
assert g(x*y) = g(x)*g(y)
prove g(h(x*y)) = g(h(x))*g(h(y))
  qed

display
statistics
