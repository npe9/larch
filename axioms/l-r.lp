% L-R systems

set name l_r

declare sort E
declare variables x, y, z: E
declare operators
  e     :      -> E
  i     : E    -> E
  __*__ : E, E -> E
  ..

assert
  e * x = x;
  x * i(x) = e;
  x * (y * z) = (x * y) * z
  ..
