function C_L_beta_dihedral = C_L_beta_dihedral(chord_fun, b, S, C_L_alpha, dihedral)
%C_L_B_DIHEDRAL Returns the dihedral's contribution to lateral stability
%via strip theory
% Built by Matt Liepke for AE 413 HW6
%   chord_fun   : 1-D array of lengths representing chord progression from
%                   root-> tip
%   b           : span
%   S           : wing area
%   C_L_alpha   : d(C_L)/d(alpha) for the wing
%   dihedral    : dihedral, in radians

y = linspace(0,b/2, length(chord_fun));
C_L_beta_dihedral = -2*dihedral/(S*b) * trapz(y,C_L_alpha*y.*chord_fun);
end

