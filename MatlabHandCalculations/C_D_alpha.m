function C_D_alpha = C_D_alpha(C_L, C_L_alpha, e, AR)
%C_D_ALPHA returns C_D_alpha given aircraft flight parameters. is the
%                     derivative of C_D w/r to alpha
% Built by Matt Liepke for AE 413 Test1
%   C_L : Lift coeff
%   e   : Oswald's efficiency factor
%   AR  : Aspect Ratio
%   C_L_alpha  : C_L_alpha for the wing (not section)

C_D_alpha = 2 * C_L * C_L_alpha / (pi*e*AR);
end

