% Free distributive lattices

set name lattice

declare sort L
declare variables x, y, z: L
declare operators __+__, __*__:  L, L -> L


% Ordering hints

register height * > +			% for noeq-dsmpos ordering
register polynomial *  2*x*y		% for polynomial ordering
register polynomial +  x + y + 1


% Axioms

assert 
  ac +;
  ac *;
  (y + z) * x = (x * y) + (x * z);
  (x * y) + x = x;
  (x + y) * x = x
  ..
