% Ring oscillator

set log ring1
set script ring1
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

% Invariant is Inv(s) <=> (exists xi)(exists xj)(all x)I(xi, xj, x, s)

assert
  I(xi, xj, x, s) <=>
    st(xi, s) /\ ~st(s(xi), s) /\ ~st(xj, s) /\ st(s(xj), s) 
      /\ ( x = xi \/  x = xj \/ st(x, s) = st(s(x), s) )
  ..
make immune invariant

statistics


% Prove that the initial transition establishes the invariant

set name theorem
set proof-method =>, normalization
declare operators i, j: -> Element	% Skolem constants for conclusion

prove when init yield I(i, j, x, post)
  make immune theorem
  make inactive theorem
  assert i = 0; j = n			% Instantiate Skolem constants
  resume by cases x = 0
  qed


% Prove that the c-transition preserves the invariant

declare operators i1, j1: -> Element	% Skolem constants for hypothesis
declare variable a: Element

prove when \A x I(i1, j1, x, pre), c(a) yield I(i, j, x, post)
  make immune theorem
  make inactive theorem

  set name lemmas
  crit ring with *Hyp		% ac = y \/ st(s(y), post) = st(s(y), pre)

  prove i1 ~= j1 by contradiction
  prove 
    if st(ac, pre) = st(s(ac), pre) 
       then st(x, post) = st(x, pre) 
       else i1 ~= s(ac) /\ j1 ~= s(ac)
    by case st(ac, pre) = st(s(ac), pre)
    ..
    resume by case x = s(ac)  		% handle first case
      crit *Hyp with *Hyp
    resume by cases			% handle second case
      i1 = s(ac),
      j1 = s(ac),
      ~( i1 = s(ac) \/ j1 = s(ac) )
      ..


  % Now prove the theorem

  resume by case st(ac, pre) = st(s(ac), pre)

    % Start Case 1.1: st(ac, pre) = st(s(ac), pre)

    assert  i = i1;  j = j1		% Instantiate Skolem constants

    % Start Case 1.2: st(ac, pre) ~= st(s(ac), pre)

    crit *caseHyp with *Hyp		% ac = i1 \/ ac = j1

    resume by cases  ac = i1,  ac = j1

      % Start Case 2.1: ac = i1

      assert  i = s(i1);  j = j1	% Instantiate Skolem constants

      crit lemmas with *Hyp	  	% st(s(j1), post),  ~st(j1, post)
      resume by cases  
        x = j1,
        x = s(ac),  
        ~( x = j1 \/ x = s(ac) )
        ..

        % Cases 3.1-2: x = j1, x = s(ac) established without help
        % Start Case 3.3: ~( x=j1 \/ x = s(ac) )

        crit *caseHyp with *Hyp
        resume by case ac = xc
        crit *caseHyp with lemmas

      % Cases 2.2: ac = j1

      assert  i = i1;  j = s(j1)	% Instantiate Skolem constants

      crit lemmas with *Hyp     	% st(s(i1), post), ~st(i1, post)
      resume by cases  
        x = i1 , 
        x = s(ac),  
        ~( x = i1 \/ x = s(ac) )
        ..

        % Cases 4.1-2: x = i1, x = s(ac) established without help
        % Start Case 4.3: ~( x = i1 \/ x = s(ac) )

        crit *caseHyp with *Hyp
        resume by case ac = xc
        crit *caseHyp with lemmas

  qed

statistics
