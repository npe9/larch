% Groups

set name group

declare sort G
declare variables x, y, z: G
declare operators
  e     :       -> G
  i     :  G    -> G
  __*__ :  G, G -> G
  ..

assert
  e * x = x;
  i(x) * x = e;
  (x * y) * z = x * (y * z)
  ..
