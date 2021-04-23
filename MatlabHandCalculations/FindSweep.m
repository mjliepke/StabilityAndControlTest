function sweep = FindSweep(gamma, AR, loc, sweep_LE)
%FINDSWEEP returns sweep at dist from the chord
% Built by Matt Liepke for AE 413 Test1s
%   gamma   : taper ratio
%   AR      : Aspect ratio
%   loc     : % of chord where you want the sweep
%   sweep_LE: sweep at the leading edge in radians
sweep = atan(tan(sweep_LE) - 4*loc*(1-gamma)/(AR*(1+gamma)));
end

