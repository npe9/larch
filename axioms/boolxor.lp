% Complete axiomatization of booleans via exclusive-or normal form


set name bool
declare variables p, q, r: Bool
declare operator __#__: Bool, Bool -> Bool


% Ordering hints

register height <=> > => > \/ > /\ > #	% for noeq-dsmps ordering
register height ~ > #
register polynomial true  2		% for polynomial ordering
register polynomial false 2
register polynomial #     x + y + 2
register polynomial /\    2 * x * y
register polynomial ~     3 * x^2
register polynomial \/    6 * x * y
register polynomial =>    9 * x * y
register polynomial <=>  12 * x * y

% Axioms for boolean rings

assert 
  ac #;					% /\ is hardwired into LP as ac
  p # false = p;
  p # p = false;
  (p /\ false) = false;			% hardwired into LP
  (p /\ true) = p;			% hardwired into LP
  (p /\ p) = p;				% hardwired into LP
  ((p # q) /\ r) = ((p /\ r) # (q /\ r))
  ..


% Axioms for other logical operators

assert
  ~p = p # true;
  (p \/ q) = ((p /\ q) # p # q)
  (p => q) = (~p \/ q)
  (p <=> q) = ~(p # q)
  ..


% This system is complete, but completion is intractably slow because \/ and
% <=> are hardwired as ac.
