function c_r = FindRootChord(gamma, S, b)
%FINDTIPCHORD Gives the root chord to satisfy a given Surface area, taper and span
%               this works for horz tail and the wing.  Used so that solution
%               is not over-constrained
% Built by Matt Liepke for AE 413 Test1
%   gamma :  taper ratio
%   S     :  Surface Area
%   b     : span of wing

c_r = 2*S/ (b*(1+gamma));
end