function c_t = FindTipChord(gamma, c_r)
%FINDTIPCHORD Gives the tip chord to satisfy a taper ratio and root chord
%               this works for horz tail and the wing.  Used so that solution
%               is not over-constrained
% Built by Matt Liepke for AE 413 Test1
%   gamma :  taper ratio
%   c_r   : root chord of the wing

c_t =  gamma * c_r;
end

