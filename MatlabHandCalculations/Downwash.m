function downwash = Downwash(AR_tail, lambda, h_H, l_H, b, sweep_quarter)
%TAILDOWNWASH Returns Empirical Downwash (dE / dalpha) for tail given aircraft characteritics
% Built by Matt Liepke for AE 413 Test1
%   AR_tail : tail aspect ratio
%   lambda : tail taper ratio
%   h_H    : height of horz tail MAC to wing root chord
%   l_H    : dist from quarter chord of wing -> quarter chord of horz tail // to root chord
%   b      : span of horz. tail
%   sqeep_quarter : quarter sweep of the horizantal tail in radians

K_A = (1/AR_tail) - 1/(1+AR_tail^1.7);
K_lambda = (10-(3*lambda))/7;
K_H = (1-h_H/b) / (2*l_H/b)^(1/3);

downwash = 4.44 * (K_A * K_lambda * K_H * cos(sweep_quarter)^(.5))^1.19;
end

