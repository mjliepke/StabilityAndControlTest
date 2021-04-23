% Matt Liepke Spr 2021, AE 413 Test 1
% This script is a tool to help me iterate through designs for Test 1.
% It references many other functions from files, all of which are required
% to be in the same directory as this script.  These include:
% C_D.m, C_D_alpha.m, C_L.m, C_L_alpha.m, C_L_alphawing.m, C_M_alpha.m,
% C_M_alpha_fuselage_shivers.m, C_N_beta.m, C_N_beta_dihedral.m, C_N_beta_fuselage.m,
% C_N_beta_sweep.m, C_N_beta_vtail.m, Downwash.m, FindRootChord.m, FindSweep.m,
% FindSweepVtail.m, FindTipChord.m, ForceFromCoeff.m, StallVel.m

%LATEST INPUT REFERENCES - this is what you input, in order
%
%K_RI = 2.3
%K_N = .0012
%k = .78
%Av_eff = 3.2

clc;clear;close all;
showFigs = false;

%% Aircraft Parameters To Modify
M = .525;
mass = 5000; %lb;
weight = mass * 32.17; %lbf
T_max = 15000 / 4.45 ; %lbf

% Wing
S = 130; %ft^2
b = 30; %ft
lambda = 1;
sweep_LE = 15*pi/180; %rad
dihedral = -2*pi/180; %rad

% Fuselage
x_a = .5; %ft
l_f = 35; %ft, fuselage length
S_fuselage = 120; % ft^2, projected area
lf_up = 13;%ft, length of fuselage in upwash (dist from nose -> wing
bf = [ 5.8 6.7 4.1 2 1.6 ]; % [ft]
df_max = 6; %max depth

% Horz Tail
S_htail = 8; %ft^2
b_htail = 5; %ft,
lambda_htail = .7;
sweep_LE_htail = 14*pi/180;
h_h = 3;   %ft, vert dist from horz tail to wing
l_h = 18;  %ft, long dist from horz tail AC -> wing AC
nabla_htail = 1; %ratio of dynamic pressure of horz tail to wing

% Vert Tail
S_vtail = 20; %ft^2
b_v = 7; %ft, fuselage centerline -> tip of vert tail;
lambda_vtail = .6;
sweep_LE_vtail = 5*pi/180;
l_v = 18; %ft, should be about the same at l_h
z_w = 1; % horz distance from wing -> vtail
z_v = 3.1; % horz distance from centerline -> vtail AC
nabla_vtail = 1;
 
%% Aircraft Control Parameters to modify
aileron_start = 10; % dist from cg -> start / end of aileron
aileron_end = 15;
aileron_start_chord = 1.5;
aileron_end_chord = 1.5;

S_rudder = 4;
S_elevator = 1.5;

%% Aircraft parameters Derived
AR = b^2/S;
c_r = FindRootChord(lambda, S, b);
c_t = FindTipChord(lambda, c_r);
c_bar = (2/3) * c_r * (1 + lambda + lambda^2)/(1 + lambda);
x_a_bar = x_a / c_bar;
sweep_quarter = FindSweep(lambda, AR, .25, sweep_LE);
sweep_half = FindSweep(lambda, AR, .5, sweep_LE);

V_h = S_htail*l_h / (S*c_bar);
AR_htail = b_htail^2/S_htail;
c_r_htail = FindRootChord(lambda_htail, S_htail, b_htail);
c_t_htail = FindTipChord(lambda_htail, c_r_htail);
sweep_half_htail = FindSweep(lambda_htail, AR_htail, .5, sweep_LE_htail);

AR_vtail = b_v^2/S_vtail;
c_r_vtail = FindRootChord(lambda_vtail, S_vtail, b_v);
c_t_vtail = FindTipChord(lambda_vtail, c_r_htail);
sweep_quarter_vtail = FindSweepVtail(c_r_vtail, c_t_vtail, b_v,sweep_LE_vtail, .25);
sweep_half_vtail = FindSweepVtail(c_r_vtail, c_t_vtail, b_v,sweep_LE_vtail, .5);

%% Airfoil Parameters (pick & document a airfoil section)
% the NACA 1408 airfoil was chosen see airfoiltools.com for ref values (used Re = 1mil since closest)
C_l0 = .1147;
C_d0 = 0.00395;
C_l_max = 1.3005;
C_l_alpha =.1182; %1/deg
e = .97; % GUESS

%% Flight Parameters in English Units
a_sl = 1116; %ft/s
a_cruise = 1090;
rho_sl = 1.225 * 0.062428;
rho_cruise = 0.0629; % interpolated from ISA (engineeringtoolbox.com) @ 5,000 ->10,000 ft
dyn_visc_cruise = 3.6 *10^-7;% also from ISA
q_cruise = .5*rho_cruise*(M * a_cruise)^2; % psf

Re_c = (M*a_cruise)*c_bar*rho_cruise/dyn_visc_cruise;

%% Lift & Drag Coeff Calculations
C_L_cruise = C_L(weight, q_cruise, S);
C_D_cruise = C_D(AR, e, C_L_cruise, C_d0);
C_L_alpha_cruise = C_L_alpha(C_l_alpha, AR, e);
C_D_alpha_cruise = C_D_alpha(C_L_cruise, C_L_alpha_cruise, e, AR);

C_L_alpha_vtail = C_L_alpha(C_l_alpha,AR_vtail,e);
C_L_alpha_htail = C_L_alpha(C_l_alpha,AR_htail,e);

%% Stall & Lift/Drag Forces
v_min_sl = StallVel(C_l_max, weight, rho_sl, S);
Lift = ForceFromCoeff(C_L_cruise, q_cruise, S);
Drag = ForceFromCoeff(C_D_cruise, q_cruise, S);

%% Cruise estimated AOA required & estimated Throttle trim
throttle_trim_perc = 100*(Drag/32.17) / T_max;
aoa_trim = (C_L_cruise - C_l0)/C_L_alpha_cruise;

%% Downwash Model
de_da = Downwash(AR, lambda, h_h, l_h, b, sweep_quarter);

%% Pitching Moment Derivatives
C_M_alpha_cruise = C_M_alpha(AR, AR_htail, M, sweep_quarter, sweep_half, ...
    sweep_half_htail, nabla_htail, V_h, x_a_bar, l_f, lf_up, l_h, h_h, c_r, c_t, bf, b,1);

%% Neutral Point Calculation - where C_M_alpha becomes 0 (unstable)
res = 1000;
x_a_bar_test = linspace(-1,1,res); %assume Neutral point is in this range
c_m_alpha_test = zeros(1,res);

for i = 1:1000
    c_m_alpha_test(i) =  C_M_alpha(AR, AR_htail, M, sweep_quarter, sweep_half,...
        sweep_half_htail, nabla_htail, V_h, x_a_bar_test(i), l_f, lf_up, l_h, h_h, c_r, c_t, bf, b,0);
end
[x_a_bar_crit index] = min(abs(c_m_alpha_test));
if(showFigs)
figure('Name','Neutral Point Determination');
hold on
plot(x_a_bar_test, c_m_alpha_test);
plot(x_a_bar_test(index), c_m_alpha_test(index), 'r*');
ylabel('C M alpha');
xlabel('x a bar');
title('C M alpha vs x a bar for Neutral Point Determination');
end

%% Yawing Moment Derivatives
[C_N_beta_total, k_vtail] = C_N_beta(C_L_cruise, lambda, AR,M,  sweep_quarter, sweep_quarter_vtail, ...
    sweep_half_vtail,x_a_bar, S_fuselage, S,S_vtail, b, df_max, z_w, l_f, l_v, Re_c, c_bar);

%% Rolling Moment Derivatives
aoa_vtail = 0; 
C_L_beta_total = C_L_beta(c_r, lambda, b, S, AR, C_L_alpha_cruise, dihedral, sweep_LE, aoa_trim,...
    df_max, S_vtail,C_L_alpha_vtail, aoa_vtail, sweep_quarter_vtail, nabla_vtail, l_v, z_v, k_vtail);

%% Control Derivatives
C_L_aileron_cruise = C_L_aileron(C_L_alpha_cruise, S, b, c_r, lambda, aileron_start, aileron_end, aileron_start_chord, aileron_end_chord);
C_N_rudder_cruise = C_N_rudder(k_vtail, nabla_vtail, S_rudder, S_vtail, C_L_alpha_vtail);
C_M_elevator_cruise = C_M_elevator(nabla_htail, S_elevator, S_htail, C_L_alpha_cruise, l_h, c_bar ); % using same airfoil as wing, so same C_L_alpha

%% Print Lateral Stability Derivative Results:
fprintf("\n************LATERAL STABILITY DERIVATIVE RESULTS**********\n");
fprintf("Airfoil Cl_0:\t%f\tRequired Cruise Cl:\t%f\n\n",C_l0,C_L_cruise);
fprintf("C_D @ cruise:\t%f\n\n", C_D_cruise);
fprintf("C_L_alpha:\t%f [1/rad]\n", rad2deg(C_L_alpha_cruise));
fprintf("\tRequired: 4 - 6 [1/rad]\n\n");
fprintf("C_D_alpha:\t%f [1/rad]\n\n", rad2deg(C_D_alpha_cruise));
fprintf("C_M_alpha, total:\t%.4f [1/rad]\n\tRequired -.35 to -0.15 \n\n",C_M_alpha_cruise);

%% Print Cruise Characteristics (forces, trim, ect)
fprintf("\n************CRUISE CHARACTERISTICS RESULTS**********\n");
fprintf("L/D @ cruise:\t%f\n\n", C_L_cruise/C_D_cruise);
fprintf("Lift @ cruise:\t%.0f [lbf]\n\n",Lift/32.17);
fprintf("\tFor reference, weight is:\t%.0f [lbf]\n\n",weight/32.17);
fprintf("Drag @ cruise:\t%.0f [lbf]\n\n",Drag/32.17);
fprintf("\tFor reference, max thrust is:\t%.0f [lbf]\n\n",T_max);
fprintf("To Cruise, throttle trim is about:\t%.3f %%\n",throttle_trim_perc);
fprintf("To Cruise, wing pitch must be about:\t%.3f [deg]\n\n",rad2deg(aoa_trim));

%% Print Directional Stability Results
fprintf("\n************DIRECTIONAL STABILITY DERIVATIVE RESULTS**********\n");
fprintf("C_N_beta, total:\t%.4f [1/rad]\n\tRequired .02 to .3 \n\n",C_N_beta_total);
fprintf("C_L_beta, total:\t\t%.4f [1/rad]\n", C_L_beta_total);

%% Print Control Derivative Results
fprintf("\n************CONTROL DERIVATIVE RESULTS**********\n");
fprintf("C_L_dAileron :\t\t%.5f [1/rad]\n", C_L_aileron_cruise);
fprintf("C_N_dRudder :\t\t%.5f [1/rad]\n", C_N_rudder_cruise);
fprintf("C_M_dElevator :\t\t%.5f [1/rad]\n", C_M_elevator_cruise);
fprintf("\n************CONTROL DERIVATIVE RESULTS - DEG**********\n");
fprintf("C_L_dAileron :\t\t%.5f [1/ded]\n", rad2deg(C_L_aileron_cruise));
fprintf("C_N_dRudder :\t\t%.5f [1/deg]\n", rad2deg(C_N_rudder_cruise));
fprintf("C_M_dElevator :\t\t%.5f [1/deg]\n", rad2deg(C_M_elevator_cruise));

%% Misc Other Prints
fprintf("\n************RANDOM OTHER THINGS**********\n");
fprintf("Stall @ sea level:\t%.1f [ft/s]\n\n",v_min_sl);
fprintf("\tFor reference, cruise is M = %.2f or v = %.1f [ft/s]\n\n",M, M * a_cruise);
fprintf('The Neutral Point is %.4f [ft] behind the AC\n\n',x_a_bar_crit * c_bar);
fprintf("Empirical Downwash is:\t%.3f \n\n",de_da);
fprintf("c_bar for the wings:\t%.1f [ft]\n\t\tRequired 4 to 6 [ft]\n\n",c_bar);


