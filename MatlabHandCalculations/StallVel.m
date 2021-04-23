function StallVel = StallVel(C_L_max, weight, rho_inf, S)
%STALLVEL Stall Speed given C_L_max and flight characteristics
% Built by Matt Liepke for AE 413 Test1
%   C_L_max : max coeff of lift by wing
%   weight  : loaded weight of aircraft
%   rho_inf : density which you want StallVel
%   S       : Surface Area of the wing
StallVel = sqrt(2 * weight / (S * rho_inf * C_L_max));
end

