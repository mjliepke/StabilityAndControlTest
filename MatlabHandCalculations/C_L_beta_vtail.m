function C_L_beta_vtail = C_L_beta_vtail(b, AR, S, df_max, S_vtail, C_L_alpha_vtail, alpha, sweep_quarter_vtail, nabla_v, l_v, z_v, k_vtail)
%C_L_B_DIHEDRAL Returns horz tail's contribution to lateral stability via 
% Built by Matt Liepke for AE 413 HW6

%   b           : span
%   AR          : Aspect ratio of wing
%   S           : wing area
%   df_max: max fuselage depth (height)
%   S_vtail     : wing area of vert tail
%   C_L_alpha_vtail: d(C_L)/d(alpha) for the vert tail
%   alpha       : angle of attack , in radians
%   sweep_quarter_vtail: quarter sweep of the vert tail
%   nabla_v     : ratio of dynamic pressure of vtail / wing
%   l_v         : long distance from AC of wing to vert tail
%   z_v         : vert (height) distance from AC of wing to vert tail

sidewash = Sidewash(S_vtail, S, sweep_quarter_vtail, z_v, df_max, AR);

C_L_beta_vtail = -k_vtail * C_L_alpha_vtail * sidewash*nabla_v* (S_vtail/S) * (z_v*cos(alpha) - l_v*sin(alpha))/b;
end

