% Integers

set name int

declare sort Int
declare variables x, y, z: Int
declare operators
  0, 1         :          -> Int
  s, p, -__    : Int      -> Int
  __+__, __*__ : Int, Int -> Int
  ..


% Ordering hints

register height * > - > + > p > s > 0		% for noeq-dsmpos ordering
register polynomial 0    2           2		% for polynomial 2 ordering
register polynomial 1    5           5
register polynomial s    x + 2       x + 2
register polynomial p    x + 3       x + 3
register polynomial +    x + y + 1   x*y
register polynomial *    x*y         x*y
register polynomial -    2*x         x + 1


% Axioms

assert 
  ac +;
  ac *;
  x + 0 = x;
  x + s(y) = s(x+y);
  x + p(y) = p(x+y);

  x * 0 = 0;
  x * s(y) = (x*y) + x;
  x * p(y) = (x*y) + (-x);

  (y + z) * x = (x * y) + (x * z);

  -0 = 0;
  -s(x) = p(-x);
  -p(x) = s(-x);
  (-x) + x = 0;
  -(-x) = x;
  -(x + y) = (-x) + (-y);
  (-y) * x = -(x * y);

  s(p(x)) = x;
  p(s(x)) = x;
  1 = s(0);
  ..
