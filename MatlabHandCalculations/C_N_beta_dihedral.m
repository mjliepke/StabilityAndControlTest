function C_N_beta_dihedral = C_N_beta_dihedral(C_L, Gamma)
%C_N_BETA_DIHEDRAL provided C_N_beta contribution of the wings via an empirical formula. 
%                  this empirical formula works best for higher aspect ratios
% Built by Matt Liepke for AE 413 Test1
%   C_L     : C_L of the wing
%   Gamma   : wing dihedral in radians
C_N_beta_dihedral =- .075*C_L * Gamma;
end

