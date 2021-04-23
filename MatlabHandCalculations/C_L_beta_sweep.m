function C_L_beta_sweep = C_L_beta_sweep(chord_fun, b, S, C_L_alpha, sweep, alpha)
%C_L_B_DIHEDRAL Returns the sweep's contribution to lateral stability
%via strip theory
% Built by Matt Liepke for AE 413 HW6
%   chord_fun   : 1-D array of lengths representing chord progression from
%                   root-> tip
%   b           : span
%   S           : wing area
%   C_L_alpha   : d(C_L)/d(alpha) for the wing
%   sweep       : sweep, in radians
%   alpha       : angle of attack , in radians

term1 = -2*alpha*cos(sweep)*sin(sweep)/(S*b);

y_h = sec(sweep) * linspace(0,b/2, length(chord_fun));

term2 = trapz(y_h,C_L_alpha*chord_fun.*y_h);

C_L_beta_sweep = term1*term2;
end

