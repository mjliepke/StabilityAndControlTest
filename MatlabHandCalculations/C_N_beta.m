function [C_N_beta, k_vtail] = C_N_beta(C_L, Gamma, AR, M, sweep_quarter, sweep_quarter_vtail, sweep_half_vtail,x_a_bar, S_fuselage, S,S_v, b, df_max, z_w, l_f,l_v, Re_c, c_bar)
%C_N_BETA Returns total C_N_beta for an aircraft given following parameters:
% Built by Matt Liepke for AE 413 Test1
%   C_L     : C_L of the wing
%   Gamma   : wing dihedral in radians
%   AR      : Aspect ratio of wings
%   sweep_quarter: quarter sweep fo the wings in radians
%   sweep_quarter_vtail: quarter sweep of vertical tail
%   sweep_half_vtail: half sweep of the vertical tail
%   x_a_bar : normalized distance from wing AC to CG (divide by chord)
%   S_fuselage  : projected side area of fuselage
%   S           : area of wing
%   S_v         : area of vert tail
%   b           : span of wing
%   l_f         : length of fuselage
%   z_w         : vert distance from htail to wing
%   df_max      : max fuselage depth (height)
%   Re_c        : Reynolds number based on chord
%   c_bar       : wing average chord

fuselageCont = C_N_beta_fuselage(S, S_fuselage, b, l_f, Re_c, c_bar);
wingDihedralCont =  C_N_beta_dihedral(C_L, Gamma);
wingSweepCont = C_N_beta_sweep(AR, sweep_quarter, x_a_bar);
[tailCont, k_vtail] = C_N_beta_vtail(S_v, S, b, sweep_quarter_vtail, ...
    sweep_half_vtail, z_w, l_v, df_max, AR, M);

fprintf("Contribution to C_N_beta:\n\tFuselage : %.5f\n\tWing Dihedral : %.5f\n\tWing Sweep : %.5f\n\tVertical Tail : %.5f\n",...
    fuselageCont, wingDihedralCont, wingSweepCont, tailCont);

C_N_beta= fuselageCont + wingDihedralCont + wingSweepCont + tailCont;
end

