% Groups (Taussky axioms)

set name Taussky

declare sort G
declare variables x, y, z: G
declare operators
  e           :      -> G
  i           : G    -> G
  __*__, f, g : G, G -> G
  ..

assert
  x * (y * z) = (x * y) * z;
  e * e = e;
  x * i(x) = e;
  g(x * y, y) = f(x * y, x);
  f(e, x) = x
  ..
