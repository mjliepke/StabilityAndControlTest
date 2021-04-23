function C_N_beta_fuselage = C_N_beta_fuselage(S, S_fuselage, b, l_f, Re_c, c_bar)
%C_N_BETA_FUSELAGE gives C_N_beta of the fuselage in 1/rad
%                   Requires user input for K_b and K_RI from charts
% Built by Matt Liepke for AE 413 Test1
%   S_fuselage  : projected side area of fuselage
%   S           : area of wing
%   b           : span of wing
%   l_f         : length of fuselage
%   Re_c          : Reynolds number based on chord
%   c_bar       : wing average chord

Re_f = Re_c * l_f / c_bar; %for reference
K_RI = str2num(input('K_RI via Fig 3.74?','s'));
K_N = str2num(input('K_N via Fig 3.74?','s'));

C_N_beta_deg = -K_N*K_RI*S_fuselage*l_f / (S*b);
C_N_beta_fuselage = rad2deg(C_N_beta_deg);
end

