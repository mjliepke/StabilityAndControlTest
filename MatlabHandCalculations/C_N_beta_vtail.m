function [C_N_beta_vtail, k_vtail] = C_N_beta_vtail(S_v, S, b, sweep_quarter_vtail, sweep_half_vtail, z_w, l_v, df_max, AR, M)
%C_N_BETA_VTAIL Summary of this function goes here
% Built by Matt Liepke for AE 413 Test1
%   S_v : vertical tail surface area
%   S   : surface of the wing
%   b   : span of the wing
%   sweep_quarter_vtail: quarter sweep of vertical tail
%   sweep_half_vtail: half sweep of the vertical tail
%   z_w : vert distance from htail to wing
%   l_v : dist from CG to AC of the horz tail
%   df_max: max fuselage depth (height)
%   AR  : Aspect ratio of wing
%   M   : mach number

V_v = S_v*l_v/(S*b);
sidewash_term = .724 + (3.06*S_v/S)/(1 + cos(sweep_quarter_vtail)) + .4*z_w/df_max + .009*AR;

%ask for AR_vtail_eff and K
k_vtail = str2num(input('k from Fig 3.75 for vtail? should be around 1: ','s'));
AR_vtail_eff = str2num(input('AR_effective of the tail from 3.77, 7.78, and 3.79? should be around AR_vtail: ','s'));
C_L_alpha_vtail =C_L_alphawing(AR_vtail_eff, M, 1, sweep_half_vtail);
C_N_beta_vtail = k_vtail*C_L_alpha_vtail*sidewash_term * V_v;

end

