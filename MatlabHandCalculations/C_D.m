function C_D = C_D(AR, e, C_L, C_D0)
%COEFFDRAG Gives C_d for a given aircraft give
% Built by Matt Liepke for AE 413 Test1
%   AR  : aspect ratio
%   e   : oswald effeciency factor
%   C_L : Lift coeff
%   C_D0: Drag @ C_L = 0

C_D = C_D0 + C_L^2 /(pi*e*AR);
end

