function C_M_elevator = C_M_elevator(nabla_htail, S_elevator, S_htail, C_L_alpha_htail, l_h, c_bar)
%C_M_ELEVATOR returns the control derivative of C_M with elevator
%deflection
%   nabla_vtail : dynamic pressure ratio of v_tail to wing
%   S_htail     : Area of the horz tail
%   S           : Area of wing
% C_L_alpha_htail: d(C_L) / d(alpha) for horz tail
% l_h           : length from wing AC -> horz. tail AC
% c_bar         : avg. chord of wing
Tau = ControlSurfaceEffectivenessTau(S_htail, S_elevator);

C_M_elevator = -(l_h*S_elevator) / (c_bar * S_htail) * nabla_htail * C_L_alpha_htail * Tau;
end

