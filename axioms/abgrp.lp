% Abelian groups

set name abgroup

declare sort Element
declare variable x: Element
declare operators
  e     :                  -> Element
  __*__ : Element, Element -> Element
  i     : Element          -> Element
  ..


% Ordering hints

register height i > *			% for noeq-dsmpos ordering
register polynomial e   2		% for polynomial ordering
register polynomial *   x + y + 2
register polynomial i   x^2


% Axioms

assert 
  ac *;
  e * x = x;
  i(x) * x = e
  ..
