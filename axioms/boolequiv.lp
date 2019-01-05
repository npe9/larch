% Complete axiomatization of booleans using boolean rings

set name bool
declare variables p, q, r: Bool

% Ordering hints

register height => > /\ > \/ > <=>	% for noeq-dsmps ordering
register height ~ > <=>
register polynomial false 2		% for polynomial ordering
register polynomial true  2
register polynomial <=>   x + y + 2
register polynomial \/    2 * x * y
register polynomial ~     3 * x^2
register polynomial /\    6 * x * y
register polynomial =>    8 * x^2 * y

% Axioms for boolean rings

assert 
  ac <=>;				% hardwired into LP, as is ac /\
  (p <=> true) <=> p;			% hardwired into LP
  p <=> p;				% hardwired into LP
  p \/ true;				% hardwired into LP
  (p \/ false) <=> p;			% hardwired into LP
  (p \/ p) <=> p;			% hardwired into LP
  ((p <=> q) \/ r) <=> ((p \/ r) <=> (q \/ r))
  ..


% Axioms for other logical operators

assert
  ~p <=> (p <=> false);			% hardwired into LP
  (p /\ q) <=> ((p \/ q) <=> (p <=> q));
  (p => q) <=> (~p \/ q)
  ..


% This system is complete, but completion is intractably slow because /\ is
% hardwired as ac.
