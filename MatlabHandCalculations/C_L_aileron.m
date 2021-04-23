function C_L_aileron = C_L_aileron(C_L_alpha_wing, S, b, c_r, lambda, aileron_start, aileron_end, aileron_start_chord, aileron_end_chord)
%C_L_AILERON Determines the rolling moment derivitave based on aileron
%geometry of the aileron
% C_L_alpha_wing    :   Wing C_L_alpha w/o any aileron deflection
% S                 :   Wing Area
% b                 :   Wing Span
% aileron_start     :   dist from cg -> start of aileron
% aileron_end       :   dist from cg -> end of aileron
% aileron_start_chord : root chord of aileron
% aileron_end_chord :   tip chord of aileron
res = 10; % for numerical integration, does not need to be high due to linear nature of chord

S_aileron = (aileron_end - aileron_start)*mean([aileron_start_chord,aileron_end_chord]);
Tau = ControlSurfaceEffectivenessTau(S, S_aileron);

res = 10; % number of chord sections per half-wing.  Since this is linear it doesn't need to be high

c_fun = c_r*(1+(lambda-1)*linspace(0,1,res)); % chord sections
y_aileron_fun = linspace(aileron_start, aileron_end, res);

int_term = trapz(y_aileron_fun, c_fun.*y_aileron_fun);

C_L_aileron = 2*C_L_alpha_wing*Tau*int_term/(S*b);

end

