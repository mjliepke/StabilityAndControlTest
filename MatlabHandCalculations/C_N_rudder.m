function C_N_rudder = C_N_rudder(k_vtail, nabla_vtail, S_rudder, S_vtail, C_L_alpha_vtail)
%C_N_RUDDER Uses the theoretical formula to find the rudder's contribution
%to C_N.
%   k_vtail     : from chart in 4.1
%   nabla_vtail : dynamic pressure ratio of v_tail to wing
%   S_vtail     : Area of the vertical tail
%   S           : Area of wing
% C_L_alpha_vtail: d(C_L) / d(alpha) for vertical tail

Tau = ControlSurfaceEffectivenessTau(S_vtail, S_rudder);

C_N_rudder = -k_vtail * nabla_vtail * (S_rudder/S_vtail) * C_L_alpha_vtail * Tau;
end

