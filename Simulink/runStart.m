clear all
clc
close all;
%% Read This
% DO NOT RUN THIS FILE... THIS IS REFERENCED BY SIMULINK, AND SHOULD NOT BE
% CALLED BY ITSELF.  



% For Liepke Plane, built by Matthew Liepke for AE 413 Final Project
fprintf("running RunStart.m.....");

%% LookupTable Matrices Import
dataLocation = "data\";
dataFiles = dir(fullfile(dataLocation, '*.mat'));
for i=1:length(dataFiles)
    load(append(dataLocation,dataFiles(i).name));
end

%% Trim Variables 
trimAngle = -8.927272e-02;
trimThrotte = 3.827652e-01;


%% Cm_derivatives
Cm_0=-0.08;
Cm_alpha=-0.3109;
Cm_q= -17.7;
Cm_de=-0.88;
Cm_ih=0;
Cm_body = [Cm_0   Cm_alpha   Cm_q   Cm_de   Cm_ih];
%Cm_body =[-0.08  -0.24   -17.7    -0.88    0];

%% Cn derivatives
Cn_0=0;
Cn_beta=0.1297;
Cn_p=- 0.09;
Cn_r=-0.26;
Cn_da=0.003 ;
Cn_dr=-0.18436;
Cn_body = [Cn_0   Cn_beta   Cn_p   Cn_r   Cn_da   Cn_dr];
%Cn_body = [0    0.17   0.09    -0.26     0.003   -0.120];
 
%% CD derivatives
CD_0=0.0205;
CD_alpha= 0.058388;
CD_q=0;
CD_de=0;
CD_ih=0;
CD_wind = [CD_0   CD_alpha   CD_q   CD_de   CD_ih];
%CD_wind = [0.0205  0.12   0  0  0];

%% CL derivatives
CL_0=0.149;
CL_alpha=5.1265;
CL_q= 10.0;
CL_de=0.38;
CL_ih=0;
CL_wind = [CL_0   CL_alpha   CL_q   CL_de   CL_ih];
%CL_wind = [0.149    5.50    10.0   0.38   0];

%% CY derivatives
CY_0=0;
CY_beta=-.0301;
CY_p=-0.140;
CY_r=0.61 ;
CY_da=0;
CY_dr=0.0280;
CY_body = [CY_0   CY_beta   CY_p   CY_r   CY_da   CY_dr];
%CY_body = [0   -1.00   -0.140   0.61     0   0.0280];

%% Cl derivatives
Cl_0=0;
Cl_beta=-0.0301;
Cl_p=-0.5;
Cl_r=0.28;
Cl_da=-0.1;
Cl_dr=0.05;
Cl_body = [Cl_0   Cl_beta   Cl_p   Cl_r   Cl_da   Cl_dr];
%Cl_body = [0    -0.11    -0.39   0.28    -0.1    0.05];

%% Geometry
cbar =   4.3;
b    =    8.0162;
S    =   12.6348;
Ix   =    1084.7;
Iy   =   6507.9;
Iz   =   7050.3;
Jxy  =   0;
Jxz  =   271.16;
Jyz  =   0;
m    =   2267.9;
T    =   0.05; % time between solves
GM1 = [cbar   b   S   Ix  Iy  Iz   Jxy Jxz  Jyz   m  T];
%GM1 = [1.6459   8.0162   12.6348   1084.7   6507.9   7050.3   0   271.16  0   1814.4];

%% Initial Conditions
v      =   180;  %v_inf, m/s
alphai =   trimAngle ; %aoa trim (rad)
beta   =   0; %side slip
p      =   0; %roll, pitch, yaw rates
q      =   0;
r      =   0;
psi    =   0;
theta  =   trimAngle ; %initial pitch (same as aoa means path angle is 0)
phi    =   0; %roll
xe     =   0; %reference frame start location
ye     =   0;
H      =   1981.2; % meters elevation (6500 ft)
x0     =   [v alphai beta p q r psi theta phi xe ye H];
%x0 = [100  0.0215504 0   0 0 0   0 0.0215504 0   0 0 60];

fprintf("\nrunStart Complete\n");