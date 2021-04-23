function C_L_beta = C_L_beta(c_r, taper, b, S, AR, C_L_alpha, dihedral, sweep_LE, aoa, df_max, S_vtail, C_L_alpha_vtail, aoa_vtail, sweep_quarter_vtail, nabla_v, l_v, z_v, k_vtail)
%C_L_BETA Returns the C_L_beta of all contributions given aircraft
%parameters.  
% Built by Matthew Liepke for AE 413 Final Project to work with prior code
% from HW7 (all the functions) and the main code from Test 1 (what calls
% this function)
%   b           : span
%   S           : wing area
%   C_L_alpha   : d(C_L)/d(alpha) for the wing
%   dihedral    : dihedral, in radians
%   sweep       : sweep, in radians
%   AR          : Aspect ratio of wing
%   df_max: max fuselage depth (height)
%   S_vtail     : wing area of vert tail
%   C_L_alpha_vtail: d(C_L)/d(alpha) for the vert tail
%   alpha       : angle of attack , in radians
%   sweep_quarter_vtail: quarter sweep of the vert tail
%   nabla_v     : ratio of dynamic pressure of vtail / wing
%   l_v         : long distance from AC of wing to vert tail
%   v_v         : vert (height) distance from AC of wing to vert tail

res = 10; % number of chord sections per half-wing.  Since this is linear it doesn't need to be high

c_fun = c_r*(1+(taper-1)*linspace(0,1,res)); % chord sections
%y_fun = linspace(0,b/2,res); %linear y-dir corresponding to chord sections

C_L_B_dihedralCont = C_L_beta_dihedral(c_fun, b, S, C_L_alpha, dihedral);

C_L_B_sweepCont = C_L_beta_sweep(c_fun, b, S,C_L_alpha, sweep_LE, aoa);

C_L_B_vtail = C_L_beta_vtail(b, AR, S, df_max, S_vtail, C_L_alpha_vtail,...
    aoa, sweep_quarter_vtail, nabla_v, l_v, z_v, k_vtail);

fprintf("C_L_B Contributions: \n\tDihedral: \t%.4f\n\tSweep: \t%.4f\n\tTail:\t%.4f\n",...
    C_L_B_dihedralCont,C_L_B_sweepCont, C_L_B_vtail);

C_L_beta = C_L_B_dihedralCont + C_L_B_sweepCont + C_L_B_vtail;

end

