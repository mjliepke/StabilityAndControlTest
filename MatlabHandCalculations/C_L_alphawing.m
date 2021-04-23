function C_L_alphawing = C_L_alphawing(AR, M, K, sweep_half)
%C_L_ALPHAWING gives C_L_alpha of the wing for calculation in total C_M_alpha.  
%               can be used for tail calculation if proper A, sweep_half given
% Built by Matt Liepke for AE 413 Test1
%   AR  : aspect ratio of wing
%   M   : Mach at flight
%   K   : empirical value.  can be assumed 1 unless accuracy is paramount
%   sweep_half: sweep at half the chord of the wing in radians
beta = sqrt(1-M^2);
C_L_alphawing = 2*pi*AR / (2 + sqrt((AR*beta/K)^2*(1+tan(sweep_half)^2/ (beta^2)) + 4));
end

