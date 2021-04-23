function Sidewash = Sidewash(S_v, S, sweep_quarter_vtail, z_z, df_max, AR)
%SIDEWASH returns (1 + d(sigma)/d(beta) via empirical formula
% Built by Matt Liepke for AE 413 HW6, taken from work on Test1
%   S_v : vertical tail surface area
%   S   : surface of the wing
%   sweep_quarter_vtail: quarter sweep of vertical tail
%   z_z : vert distance from htail to wing
%   df_max: max fuselage depth (height)
%   AR  : Aspect ratio of wing

Sidewash = .724 + (3.06*S_v/S)/(1 + cos(sweep_quarter_vtail)) + .4*z_z/df_max + .009*AR;
end

