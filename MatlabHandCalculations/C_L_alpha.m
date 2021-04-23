function C_L_alpha = C_L_alpha(C_l_alpha_wing, AR, e)
%LIFTCOEFF_ALPHA returns derivative of CL w/r to angle of attack in 1/rad
% Built by Matt Liepke for AE 413 Test1
%   C_l_alpha   : sectional (airfoil) C_l_alpha in 1/deg
%   AR  : Aspect Ratio
%   e   : Oswald's efficiency factor
C_L_alpha = C_l_alpha_wing / (1 + (57.3*C_l_alpha_wing)/(pi*e*AR));
end

