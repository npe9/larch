% Commutative rings


set name c_ring

declare sort R
declare variables x, y, z: R
declare operators
  0            :       -> R
  -__          :  R    -> R
  __+__, __*__ :  R, R -> R
  ..


% Ordering hints

register height * > - > + > 0		% for noeq-dsmpos ordering
register polynomial 0   2		% for polynomial ordering
register polynomial +   x + y + 5
register polynomial -   (2*x) + 2
register polynomial *   x*y


% Axioms

assert 
  ac +;
  ac *;
  0 + x = x;
  (-x) + x = 0;
  (x + y) * z = (x * z) + (y * z)
  ..
