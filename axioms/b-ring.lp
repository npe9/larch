% Boolean rings


set name b_ring

declare sort R
declare variables x, y, z : R
declare operators
  0, 1         :       -> R
  __+__, __*__ :  R, R -> R
  ..


% Ordering hints

register height * > +			% for noeq-dsmpos ordering
register polynomial 0     2		% for polynomial ordering
register polynomial 1     2
register polynomial +     x + y + 2
register polynomial *     2 * x * y


% Axioms

assert 
  ac *;
  ac +;
  0 + x = x;
  0 * x = 0;
  1 * x = x;
  x * x = x;
  (x + y) * z = (x * z) + (y * z);
  x + x = 0
  ..


% Definition of logical operators in a boolean ring

set name logic

declare	operators				% Avoid hardwired operators
  T, F         :       -> R			% true, false
  n            :  R    -> R			% not
  __&__, __|__ :  R, R -> R			% /\, \/
  ..

% Further ordering hints

register height n > +			% for noeq-dsmpos ordering
register height (&, |) > *
register polynomial T  	  3		% for polynomial ordering
register polynomial F     3
register polynomial n     3*(x^2)
register polynomial &     3*x*y
register polynomial |     6*x*y


% Further axioms

% assert ac & 			% These assertions slow down completion
% assert ac |			% They follow from definitions below

assert
  T = 1;
  F = 0;
  n(x) = 1 + x;
  x & y = x * y;
  x | y = (x * y) + (x + y)
  ..
