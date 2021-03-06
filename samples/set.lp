% Proofs by induction of some properties of sets

clear
set log set
set script set
set trace 0

set name set

declare sorts Elem, Set
declare variables e, e': Elem, x, y, z: Set
declare operators
  {}:           	   -> Set
  insert:    	 Elem, Set -> Set
  {__}: Elem      	   -> Set
  __\union__:    Set, Set  -> Set
  __\in__:       Elem, Set -> Bool
  __\subseteq__: Set, Set  -> Bool
  ..


% Axioms

assert 
  sort Set generated by {}, insert;
  ac \union;
  {e} = insert(e, {});
  {} \union x = x;
  insert(e, x) \union y = insert(e, x \union y);
  ~(e \in {});
  e \in insert(e', x) <=> e = e' \/ e \in x;
  {} \subseteq x;
  insert(e, x) \subseteq y <=> e \in y /\ x \subseteq y
  ..
set name extensionality
assert \A e (e \in x <=> e \in y) => x = y

% Theorems about union

set name theorem

prove e \in (x \union y) <=> e \in x \/ e \in y by induction on x
  qed

prove x = x \union x
  instantiate y by x \union x in extensionality
  qed

prove x = x \union {}
  instantiate y by x \union {} in extensionality
  qed



% Theorems about insert

prove insert(e, insert(e, x)) = insert(e, x)
  instantiate 
    x  by insert(e, insert(e, x)), 
    y by insert(e, x) 
    in extensionality
    ..
  qed

prove insert(e, x) = x \union {e}
  qed



% Theorems about subset

prove e \in x /\ x \subseteq y => e \in y by induction on x
  resume by =>
    resume by case ec = e1c
    % Fast way to finish proof: instantiate e by ec, y by yc in *InductHyp
    set immunity on
    critical-pairs *InductHyp with *ImpliesHyp
    set immunity off
    make nonimmune theorem
    critical-pairs *ImpliesHyp with theorem
    qed

prove insert(e, x) \subseteq y <=> e \in y /\ x \subseteq y
  qed

prove {e} \subseteq x <=> e \in x
  qed

prove (x \union y) \subseteq z <=> x \subseteq z /\ y \subseteq z 
  resume by induction on x
  qed


% Alternate induction rule

set name inductionRule

prove sort Set generated by {}, {__}, \union
  resume by induction
  set name lemma
  critical-pairs *GenHyp with *GenHyp
  critical-pairs *InductHyp with lemma
  qed

set name theorem

prove x \subseteq (x \union y) by induction on x using inductionRule
  qed

prove x \subseteq x by induction using inductionRule
  qed

prove x \subseteq y /\ y \subseteq z => x \subseteq z
  resume by induction on x using inductionRule
    resume by =>
      critical-pairs *Hyp with *
  qed



display
statistics
