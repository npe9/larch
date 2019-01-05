% Groups (axiomatized by two axioms)

set name group

declare sort G
declare variables x, y, z: G
declare operator __/__: G, G -> G


% Ordering hint

register status right-to-left /


% Axioms

assert
  (x / x) / ((y / y) / y) = y;
  (x / z) / (y / z) = x / y
  ..

% Complete manually with
%      set automatic-ordering off
%      set completion-mode big
%      set ordering dsmpos
% Alternatively, complete manually with
%      set automatic-ordering off
%      set completion-mode expert
%      set ordering dsmpos
%      set reduction-strategy outside-in
% to discover * (with perseverence) in addition to e, i
