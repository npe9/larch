% Ring oscillator (proof by contradiction)

set log ring2
set script ring2
clear
set trace 0


% Axioms for a ring of size n, where n > 2

set name ring
declare sort Element
declare variables x, y, z: Element
declare operators
  0, n   :         -> Element
  s      : Element -> Element
  ..
assert
  s(x) = 0 <=> x = n;
  s(x) = s(y) <=> x = y;
  x ~= s(x);
  x ~= s(s(x))
  ..

critical-pairs ring with ring		% n ~= 0 /\ n ~= s(0)


% Definition of oscillator actions

declare sort State
declare variable s: State
declare operators
  pre, post :                -> State
  st        : Element, State -> Bool
  init      :                -> Bool
  c         : Element        -> Bool
  ..

set name actions
assert
  when init yield st(x, post) <=> x = 0;
  when c(x) yield
    st(x, pre) = ~st(s(s(x)), pre),		% precondition
    st(s(x), post) = st(x, pre),		% action
    y = s(x) \/ st(y, post) = st(y, pre)	% unchanged
  ..
make immune actions


% Definition of oscillator invariant

set name invariant
declare operator I: Element, Element, Element, State -> Bool
declare variables xi, xj: Element

% Invariant is Inv(s) = (exists xi)(exists xj)(all x)I(xi, xj, x, s)

assert
  I(xi, xj, x, s) <=>
    st(xi, s) /\ ~st(s(xi), s) /\ ~st(xj, s) /\ st(s(xj), s)
      /\ ( x = xi \/ x = xj \/ st(x, s) = st(s(x), s) )
  ..
make immune invariant


% Prove that initial transition establishes the invariant

set name contra
declare operator anything: -> Bool
prove anything by contradiction

set name transition
assert init
set name contra
declare operator f: Element, Element -> Element	   % Skolem function
assert ~I(xi, xj, f(xi, xj), post)

instantiate xi by 0, xj by n in contra
qed
delete contra


% Prove that the c-transition preserves the invariant

set name transition
declare operator a: -> Element
assert c(a)
set name invariant
declare operators i1, j1: -> Element	% Skolem constants
assert I(i1, j1, x, pre)

% First derive some lemmas

set name lemmas
crit ring with transition	% a = y \/ st(s(y), post) = st(s(y), pre)

prove i1 ~= j1 by contradiction
qed

set proof-method normalization
prove 
  if st(a, pre) = st(s(a), pre)
     then st(x, post) = st(x, pre)
     else i1 ~= s(a) /\ j1 ~= s(a)
  by case st(a, pre) = st(s(a), pre)
  ..
  resume by case x = s(a)  			% handle first case
    crit *caseHyp with transition, invariant
  resume by cases				% handle second case
    i1 = s(a),
    j1 = s(a),
    ~( i1 = s(a) \/ j1 = s(a) )
    ..
  qed

% Now prove the theorem

set name contra
declare operator f: Element, Element -> Element	   % Skolem function
assert ~I(xi, xj, f(xi, xj), post)

prove anything by contradiction

resume by case st(a, pre) = st(s(a), pre)

  % Start Case 1.1: st(a, pre) = st(s(a), pre)
  instantiate xi by i1, xj by j1 in contra

  % Start Case 1.2: not(st(a, pre) = st(s(a), pre)

  crit *CaseHyp with invariant		% a = i1 \/ a = j1

  resume by cases  a = i1,  a = j1

    % Start Case 2.1: a = i1
    crit lemmas with transition, invariant	  % st(s(j1)),  ~st(j1)
    instantiate xi by s(i1), xj by j1 in contra
    crit contra with invariant, transition
    resume by case a = f(s(i1), j1)
      crit *CaseHyp with lemmas

    % Cases 2.2: a = j1
    crit lemmas with transition, invariant     	% st(s(i1)), ~st(i1)
    instantiate xi by i1, xj by s(j1) in contra
    crit contra with invariant, transition
    resume by case a = f(i1, s(j1))
      crit *CaseHyp with lemmas

qed
statistics


