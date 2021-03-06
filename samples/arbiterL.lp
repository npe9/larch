% Proof that arbiter tree maintains its invariant (local version)
% See arbiter.doc for background information.

%------------------- LP settings

set log arbiterL
set script arbiterL
clear
set trace 0
set proof-methods =>, normalization

%------------------- Generic output from Synchronized Transitions compiler

set name definitions
declare sorts State, StateVar
declare variables
  sv, sv1  : StateVar
  sv2, sv3 : StateVar
  s, s1	   : State
  ..
declare operators
  pre, post      :					   -> State
  unchanged      : StateVar 			           -> Bool
  unchanged      : StateVar, StateVar		           -> Bool
  unchanged      : StateVar, StateVar, StateVar	           -> Bool
  unchanged      : StateVar, StateVar, StateVar, StateVar  -> Bool
  same	         : StateVar, StateVar, State	           -> Bool
  on, off, __.__ : StateVar, State			   -> Bool
  ..

register height post > pre    % For performance

set immunity on
assert
  unchanged(sv)    <=> sv.post = sv.pre;
  same(sv, sv1, s) <=> sv.s = sv1.s;
  on(sv, s)        =   sv.s;
  off(sv, s)       =   ~sv.s
  ..

assert
  when unchanged(sv, sv1) yield unchanged(sv), unchanged(sv1);
  when unchanged(sv, sv1, sv2) yield unchanged(sv), unchanged(sv1, sv2);
  when unchanged(sv, sv1, sv2, sv3) yield 
       unchanged(sv, sv1), unchanged(sv2, sv3)
  ..

%------------------ Declarations derived from ST program for arbiter

declare sorts ArbiterInstance, VarId
declare variables i, sub, super: ArbiterInstance
declare operators
  __.__		   :  ArbiterInstance, VarId           -> StateVar
  Inv		   :  ArbiterInstance, State 	       -> Bool
  arbiterPart1, 
  arbiterPart2     :  ArbiterInstance                  -> ArbiterInstance
  inArbiterSubcell :  ArbiterInstance, ArbiterInstance -> Bool
  P, PostObl, inArbiterCell, inArbiterParent, inArbiterPart1, inArbiterPart2, 
  actionTaken, done, doneleft, doneright, grantleft, grantright, requestparent,
  parentAssumptions, part1Assumptions, part2Assumptions,
  arbiterLocalsUnchanged, arbiterInternalsUnchanged, arbiterExternalsUnchanged 
		   : ArbiterInstance                   -> Bool
  grp, grl, grr, reqp, reql, reqr : -> VarId
  ..

register height PostObl > P > Inv		% For performance
register top PostObl P Inv			% Generated by ST compiler

register height grp > (reqp, grl, grr)		% For performance
register height reqp > (reql, reqr)		% Entered by user


%------------------ Bindings of actual/formal parameters for instantiations

set name instantiations
assert
  % instantiation of arbiter(grl, reql) within ArbiterInstance i
    arbiterPart1(i).grp  = i.grl;
    arbiterPart1(i).reqp = i.reql;
  % instantiation of arbiter(grr, reqr) within ArbiterInstance i
    arbiterPart2(i).grp  = i.grr;
    arbiterPart2(i).reqp = i.reqr
  ..

%------------------ Consequences of scope rules and restrictions

set name restrictions
assert
  % Derived from restrictions section
    when arbiterLocalsUnchanged(i) yield unchanged(i.reqp, i.grl, i.grr);
    when arbiterInternalsUnchanged(i) yield unchanged(i.reql, i.reqr);
    when arbiterExternalsUnchanged(i) yield unchanged(i.grp);
    when inArbiterCell(i) yield
         arbiterInternalsUnchanged(i), arbiterExternalsUnchanged(i);
    when inArbiterParent(i) yield
         arbiterLocalsUnchanged(i), arbiterInternalsUnchanged(i);
    when inArbiterSubcell(sub, super) yield
         arbiterLocalsUnchanged(super), arbiterExternalsUnchanged(super),
         inArbiterCell(sub);
  % Consequences of scope rules and restrictions
    when inArbiterParent(i) yield
         unchanged(i.grl, i.reql, i.grr, i.reqr);	% From scope rules
    when inArbiterPart1(i) yield
         unchanged(i.grp, i.reqp, i.grr, i.reqr),	% From scope rules
         inArbiterSubcell(arbiterPart1(i), i);		% From restrictions
    when inArbiterPart2(i) yield
         unchanged(i.grp, i.reqp, i.grl, i.reql),	% From scope rules
         inArbiterSubcell(arbiterPart2(i), i)		% From restrictions
  ..

%------------------ Definitions of invariant, protocol

set name invariant
assert
  Inv(i, s)  <=> (off(i.grl, s) \/ off(i.grr, s)) /\
                 ((on(i.grl, s) \/ on(i.grr, s)) 
		    => (on(i.grp, s) /\ on(i.reqp, s)));
  P(i)       <=> (if same(i.reqp, i.grp, post) then unchanged(i.reqp) 
                                               else unchanged(i.grp));
  PostObl(i) <=> (Inv(i, post) 		/\     % Invariant
	          P(i) 			/\     % Protocol for cell
       	          P(arbiterPart1(i)) 	/\     % Protocol for part 1
       	          P(arbiterPart2(i)))	      % Protocol for part 2
  ..

%------------------ Definitions of transitions

set name transitions
assert
  when actionTaken(i) yield
       inArbiterCell(i),
       Inv(i, pre),
       done(i) \/ doneleft(i) \/ doneright(i) \/ grantleft(i) \/ 
                  grantright(i) \/ requestparent(i);
  when done(i) yield
       on(i.grp, pre), off(i.grl, pre), off(i.grr, pre),	% Precondition
       off(i.reqp, post),    	  				% Action
       unchanged(i.grl, i.grr);	  				% Unchanged
  when doneleft(i) yield
       off(i.reql, pre),            				% Precondition
       off(i.grl, post),		  			% Action
       unchanged(i.reqp, i.grr);	  			% Unchanged
  when doneright(i) yield
       off(i.reqr, pre),					% Precondition
       off(i.grr, post),					% Action
       unchanged(i.reqp, i.grl);			  	% Unchanged
  when grantleft(i) yield
       on(i.grp, pre), on(i.reqp, pre),				% Precondition
       on(i.reql, pre), off(i.grr, pre),
       on(i.grl, post),						% Action
       unchanged(i.reqp, i.grr);				% Unchanged
  when grantright(i) yield
       on(i.grp, pre), on(i.reqp, pre), on(i.reqr, pre),	% Precondition
       off(i.grl, pre), off(i.reql, pre),
       on(i.grr, post),						% Action
       unchanged(i.reqp, i.grl);				% Unchanged
  when requestparent(i) yield
       off(i.grp, pre), 					% Precondition
       on(i.reql, pre) \/ on(i.reqr, pre),
       on(i.reqp, post),					% Action
       unchanged(i.grl, i.grr)					% Unchanged
  ..

%------------------ Proof obligations for local invariance

set name invariance
set immunity off
prove actionTaken(i) => PostObl(i)
  resume by cases   				% Generated by compiler
    done(ic), doneleft(ic), doneright(ic),
    grantleft(ic), grantright(ic), requestparent(ic)
    ..
qed

%------------------ Proof obligations for noninterference

set name noninterference
set immunity on
assert
  when part1Assumptions(i) yield
       Inv(i, pre),
       P(arbiterPart1(i)),	
       inArbiterPart1(i);
  when part2Assumptions(i) yield
       Inv(i, pre),
       P(arbiterPart2(i)),
       inArbiterPart2(i);
  when parentAssumptions(i) yield
       Inv(i, pre),
       P(i),
       inArbiterParent(i)
  ..

set immunity off
prove part1Assumptions(i) => PostObl(i)
qed
prove part2Assumptions(i) => PostObl(i)
qed
prove parentAssumptions(i) => PostObl(i)
qed

statistics
