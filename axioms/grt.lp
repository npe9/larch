% Groups (axiomatized by surjectivity of left and right translations)

set name group

declare sort G
declare variables x, y, z: G
declare operators __ * __, __ / __, __ \ __ :  G, G -> G

assert
  (x * y) * z = x * (y * z);
  x * (x \ y) = y;
  (y / x) * x = y
  ..

% Complete manually with
%     set automatic-registry off
%     set completion-mode expert
%     set ordering dsmpos
 %Look for opportunities to confirm the following:
%     register status L *, \
%     register status R /
%     register height \ >= / > i > * > e
% Completion goes faster by choosing \ and * to have equal heights, but 
% this prevents "i" from being discovered.
