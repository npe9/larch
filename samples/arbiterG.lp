% Proof that the arbiter tree maintains its invariant (global version)
% See arbiter.doc for background information.

clear
set log arbiterG
set script arbiterG
set trace 0

declare sorts Node, State
declare variables x, y: Node, s: State
declare operators
  pre, post                                      :             -> State
  L, R                                           : Node        -> Node
  gr, req, Inv, childMutex, childHas, parentAuth : Node, State -> Bool
  action, done, doneleft, doneright, 
  grantleft, grantright, requestparent           : Node        -> Bool
  ..

set name tree
assert
  x ~= L(x);
  x ~= R(x);
  L(x) ~= R(y);
  L(x) = L(y) <=> x = y;
  R(x) = R(y) <=> x = y
  ..


make immune *
set immunity on

set name actions
assert

  when action(x) yield
    done(x) \/ doneleft(x) \/ doneright(x) \/ grantleft(x) \/ 
    grantright(x) \/ requestparent(x);

  when done(x) yield
    gr(x, pre),				    	% precondition
    ~gr(L(x), pre),
    ~gr(R(x), pre),
    ~req(x, post),	                   	% action
    gr(y, post) = gr(y, pre),               	% unchanged
    x = y \/ req(y, post) = req(y, pre);

  when doneleft(x) yield
    ~req(L(x), pre),				% precondition
    ~gr(L(x), post),				% action
    req(y, post) = req(y, pre),			% unchanged
    L(x) = y \/ gr(y, post) = gr(y, pre);

  when doneright(x) yield
    ~req(R(x), pre),				% precondition
    ~gr(R(x), post),				% action
    req(y, post) = req(y, pre),			% unchanged
    R(x) = y \/ gr(y, post) = gr(y, pre);

  when grantleft(x) yield
    gr(x, pre),					% precondition
    req(x, pre),
    req(L(x), pre),
    ~gr(R(x), pre),
    gr(L(x), post),				% action
    req(y, post) = req(y, pre),			% unchanged
    L(x) = y \/ gr(y, post) = gr(y, pre);
    
  when grantright(x) yield
    gr(x, pre),					% precondition
    req(x, pre),
    req(R(x), pre),
    ~gr(L(x), pre),
    ~req(L(x), pre),
    gr(R(x), post),				% action
    req(y, post) = req(y, pre),			% unchanged
    R(x) = y \/ gr(y, post) = gr(y, pre);
    
  when requestparent(x) yield
    ~gr(x, pre),                          	% precondition
    req(L(x), pre) \/ req(R(x), pre),
    req(x, post),                             	% action
    gr(y, post) = gr(y, pre),                 	% unchanged
    x = y \/ req(y, post) = req(y, pre)
..

set name invariant
assert
   Inv(x, s) <=> childMutex(x, s) /\ (childHas(x, s) => parentAuth(x, s));
   childMutex(x, s) <=> ~(gr(L(x), s) /\ gr(R(x), s));
   childHas(x, s)   <=> gr(L(x), s) \/ gr(R(x), s);
   parentAuth(x, s) <=> gr(x, s) /\ req(x, s)
..


set immunity off
set name theorem
set proof-method =>, normalization
prove when \A x Inv(x, pre), action(y) yield Inv(x, post) 
  resume by cases
    done(yc), doneleft(yc), doneright(yc), grantleft(yc), 
    grantright(yc), requestparent(yc)
    ..

    % for case done(yc)
    resume by case xc = yc			
      critical-pairs *Hyp with *Hyp		% for subcase ~(xc = yc)

    % for case doneleft(yc)
    critical-pairs *CaseHyp with tree
    resume by cases x = yc, x = L(yc), ~(x = yc \/ x = L(yc))
      resume by case gr(L(yc), pre)		% for subcase x = yc
        crit *Hyp with *Hyp
        crit *Hyp with *Hyp
      resume by case gr(L(L(yc)), pre)		% for subcase x = L(yc)
        crit *Hyp with *Hyp
        crit *Hyp with *Hyp
      crit *Hyp with *				% for last subcase

    % for case doneright(yc)
    critical-pairs *CaseHyp with tree
    resume by cases x = yc, x = R(yc), ~(x = yc \/ x = R(yc))
      resume by case gr(R(yc), pre)		% for subcase x = yc
        crit *Hyp with *Hyp
        crit *Hyp with *Hyp
      resume by case gr(R(R(yc)), pre)		% for subcase x = L(yc)
        crit *Hyp with *Hyp
        crit *Hyp with *Hyp
      crit *Hyp with *				% for last subcase

    % for case grantleft(yc)
    critical-pairs *CaseHyp with tree
    resume by cases x = yc, x = L(yc), ~(x = yc \/ x = L(yc))
      crit *Hyp with *				% for last subcase

    % for case grantright(yc)
    critical-pairs *CaseHyp with tree
    resume by cases x = yc, x = R(yc), ~(x = yc \/ x = R(yc))
      crit *Hyp with *				% for last subcase

    % for case requestparent(yc)
    resume by case xc = yc
      critical-pairs *Hyp with *Hyp		% for subcase xc = yc
      critical-pairs *Hyp with *Hyp		% for subcase ~(xc = yc)
qed
statistics
