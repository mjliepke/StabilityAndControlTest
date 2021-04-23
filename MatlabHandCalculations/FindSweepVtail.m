function sweep= FindSweepVtail(c_r, c_t, b, sweep_LE, loc)
%FINDSWEEPVTAIL Returns the sweep @ a given position for a half wing like a vert tail
% Built by Matt Liepke for AE 413 Test1
%   c_r     ; root chord
%   c_t     : tip chord
%   b       : semi-span
%   sweep_LE: leading edge sweep, radians
%   loc     : location (.5 for half sweep, ect)

sweep = atan(tan(sweep_LE) - 2*loc*(c_r-c_t)/b);
end

