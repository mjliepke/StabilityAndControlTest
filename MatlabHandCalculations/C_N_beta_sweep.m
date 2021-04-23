function C_N_beta_sweep = C_N_beta_sweep(AR, sweep_quarter, x_a_bar)
%C_N_BETA_SWEEP Returns the C_N_beta from sweep via an empirical equation
% Built by Matt Liepke for AE 413 Test1
%   AR      : Aspect ratio of wings
%   sweep_quarter: quarter sweep fo the wings in radians
%   x_a_bar : normalized distance from wing AC to CG (divide by chord)

C_N_beta_sweep = 1/(4*pi*AR) - tan(sweep_quarter)/(pi*AR*(AR + 4*cos(sweep_quarter)))*...
    (cos(sweep_quarter) - AR/2 - AR^2/(8*cos(sweep_quarter)) - 6*x_a_bar*sin(sweep_quarter)/AR);
end

