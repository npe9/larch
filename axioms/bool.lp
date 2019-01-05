% Additonal, but incomplete, axioms for booleans

set name bool

declare variables p, q, r: Bool

assert
  p => r 		<=> ~p \/ r;
  (p /\ r) \/ r 	<=> r;
  (p /\ r) \/ ~r 	<=> p \/ ~r;
  (p /\ r) \/ (p /\ r) 	<=> p /\ (r \/ r);
  ~(p \/ r) \/ ~p 	<=> ~p;
  (~r /\ p) \/ (p /\ r) <=> p;
  (~p /\ r) \/ p 	<=> p \/ r;
  ~p /\ ~r 		<=> ~(p \/ r);
  ~(p /\ r) 		<=> ~p \/ ~r;
  ((~r \/ p) /\ r) \/ p <=> p
  ..
