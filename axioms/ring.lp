% Rings

set name ring

declare sort R
declare variables x, y, z: R
declare operators
  0            :      -> R
  -__          : R    -> R
  __+__, __*__ : R, R -> R
  ..


% Ordering hints

register height * > - > + > 0		% for noeq-dsmpos ordering
register status left-to-right *
register polynomial 0   2		% for polynomial ordering
register polynomial +   x + y + 5
register polynomial -   (2*x) + 4
register polynomial *   (x^2)*y


% Axioms

assert 
  ac +;
  0 + x = x;
  (-x) + x = 0;
  (x + y) * z = (x * z) + (y * z);
  (x * y) * z = x * (y * z);
  x * (y + z) = (x * y) + (x * z)
  ..
