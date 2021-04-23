function F = ForceFromCoeff(C_F, q_inf, S)
%D Gives  force given Coeficcient (C_L, C_D, C_Y) and aero properties
% Built by Matt Liepke for AE 413 Test1
%   C_F : Unitless Coeficcient of ____ <drag, lift, side force, ect>
%   q_inf : dynamic pressure
%   S : corresponding surface (wing for C_L, C_D)
F = C_F * q_inf * S;
end

