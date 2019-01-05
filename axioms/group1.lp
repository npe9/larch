% Groups (axiomatized by a single axiom)

set name group

declare sort G
declare variables x, y, z: G
declare operator __/__:  G, G -> G


% Ordering hint

register status right-to-left /


% Axiom

assert x / ((((x / x) / y) / z) / (((x / x) / x) / z)) = y


% Complete manually with 
%      set automatic-registry off
%      set completion-mode expert
%      set ordering dsmpos
% Divide appropriate equations to introduce e, i.

