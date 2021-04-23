% Modified by Matt Liepke for AE 413 HW7, Embry-Riddle.  This modified file
% will plot the aircraft that I designed in Test 2 and prepare datcom
% inputs for HW7.
%*************************************************************************
% The source code contained herein was developed for Embry-Riddle 
% Aeronautical University by Glenn P. Greiner, Professor and Jafar 
% Mohammed, Student Assistant of the Aerospace Engineering Department, 
% Daytona Beach Campus. Copyright 2008. All rights reserved.

% Although due care has been taken to present accurate programs this 
% software is provided "as is" WITHOUT WARRANTY OF ANY KIND, EITHER 
% EXPRESSED OR IMPLIED, AND EXPLICITLY EXCLUDING ANY IMPLIED WARRANTIES 
% OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE. The entire risk as 
% to the quality and performance of the software is with the user. The 
% program is made available only for education and personal research. It 
% may not be sold to other parties. If you copy some or all of the 
% software you are requested to return a copy of any source additions that
% you believe make a significant improvement in its range of application.
%*************************************************************************

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% datcom3d NAVION Input File                                           %
% March 24, 2008                                                       %
% Works with Version datcom3d v1.2                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc
clf


%%% VISUALIZATION and RESOLUTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wframe = 1;       %0 = Shaded model
                  %1 = Wireframe model
                
fusres = 20;      %Fuselage resolution
wgres  = 20;      %Wing,HT,VT resolution

%%% (DO NOT CHANGE VALUES IN THIS BOX) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
XW=0;ZW=0;ALIW=0;XH=0;ZH=0;ALIH=0;XV=0;YV=0;numVT=1;VERTUP=1;         %%
NX=0;X=zeros(20);S=zeros(20);R=zeros(20);ZU=zeros(20);ZL=zeros(20);   %%
CHRDR_WG=0;CHRDBP_WG=0;CHRDTP_WG=0;SSPN_WG=0;SSPNOP_WG=0;SAVSI_WG=0;  %%
SAVSO_WG=0;CHSTAT_WG=0;DHDADI_WG=0;DHDADO_WG=0;TC_WG=.12;             %%
CHRDR_HT=0;CHRDBP_HT=0;CHRDTP_HT=0;SSPN_HT=0;SSPNOP_HT=0;SAVSI_HT=0;  %%
SAVSO_HT=0;CHSTAT_HT=0;DHDADI_HT=0;DHDADO_HT=0;TC_HT=.12;             %%
CHRDR_VT=0;CHRDBP_VT=0;CHRDTP_VT=0;SSPN_VT=0;SSPNOP_VT=0;SAVSI_VT=0;  %%
SAVSO_VT=0;CHSTAT_VT=0;TC_VT=.12;                                     %%
SPANFI_F=0;SPANFO_F=0;CHRDFI_F=0;CHRDFO_F=0;DELTA_F=0;                %%
SPANFI_A=0;SPANFO_A=0;CHRDFI_A=0;CHRDFO_A=0;DELTAL_A=0;DELTAR_A=0;    %%
SPANFI_E=0;SPANFO_E=0;CHRDFI_E=0;CHRDFO_E=0;DELTA_E=0;                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% INPUT PARAMETERS BELOW %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SYNTHS parameters
XW =    13;
ZW =    0;
ALIW =  0.0;
XH =    32.85;
ZH =    3;
ALIH =  0.0;
XV =    32;
ZV =    0.0;

% BODY parameters
NX = 20;
X = [.05,.25,.5,1.5,2.5,3.5,6,10,11,11.5,13.7,14.8,16,18,20,22,25,27,33,35];
ZU =[.2,.5,.7,.8,.83,.9,1.05,1.4,2.1,2.5,2.9,3.1,3.2,2.9,2,1.3,.95,.8,.7,.74];
ZL = -[0,.2,.5,.7,1.2,1.5,1.6,1.7,1.9,2.05,2.3,2.15,2.1,2,1.6,1.3,1.15,1,.4,.1];
R = [.1,.4,.6,.8,1.3,1.6,1.9,2,2.2,2.5,2.9,2.8,2.6,2.2,1.6,1.4,1,.7,.6,.3];
S = pi*(ZU-ZL)/2.* R;
P = 2*pi*sqrt(.5*(ZU-ZL).^2 +R.^2);
%S =[0.0314,0.439,1.130,1.884,4.145,6.031,7.908,9.738,13.823,17.671,23.277,23.310,22.176,17.624,10.053,6.597,3.377,1.979,1.319,0.973]

% WING parameters
CHRDTP_WG = 4.33;
SSPNE_WG = 15-3;
SSPN_WG = 15;
CHRDR_WG = 4.33;
SAVSI_WG = 15;
CHSTAT_WG = .25;
TWISTA_WG = 3.5;
DHDADI_WG = -2;
DHDADO_WG = -2;
TC_WG = .18;

% HORIZONTAL TAIL parameters
CHRDTP_HT = 1.32;
SSPNE_HT = 3;
SSPN_HT = 3;
CHRDR_HT = 1.88;
SAVSI_HT = 14;
CHSTAT_HT = 0.25;
TWISTA_HT = 0.0;
DHDADI_HT = 0.0;
DHDADO_HT = 0.0;

% VERTICAL TAIL parameters
CHRDTP_VT = 1.317;
SSPNE_VT = 7;
SSPN_VT = 7;
CHRDR_VT = 3.5;
SAVSI_VT = 6;
CHSTAT_VT = .25;

% % WING FLAP
% % $SYMFLP FTYPE=1.0,NDELTA=4.0,
% %  DELTA(1)=0.,-10.,-15.,-20.,
% %  SPANFI=2.2,SPANFO=11.0,CHRDFI=1.5,CHRDFO=1.0,NTYPE=1.0, 
% %  CB=.357,TC=.220,PHETE=.003,PHETEP=.002$
% SPANFI_F=2.2;
% SPANFO_F=11;
% CHRDFI_F=1.5;
% CHRDFO_F=1;
% DELTA_F=30;
% 
% WING AILERON
% $ASYFLP STYPE=4.0,NDELTA=9.0,
%  DELTAL(1)=20.,15.,10.,5.,0.,-5.,-10.,-15.,-20., 
%  DELTAR(1)=-20.,-15.,-10.,-5.,0.,5.,10.,15.,20.,
%  SPANFI=11.0,SPANFO=16.7,CHRDFI=1.0,CHRDFO=.6$
SPANFI_A=10;
SPANFO_A=15;
CHRDFI_A=1.2;
CHRDFO_A=1.2;
%DELTAL_A=-20;
%DELTAR_A=20;

% % ELEVATOR
% % $SYMFLP FTYPE=1.0,NDELTA=9.0,DELTA(1)=-40.,-30.,-20.,-10.,0.,10.,20.,30., 
% %  40.,SPANFI=.700,SPANFO=6.586,CHRDFI=1.882,CHRDFO=.706,NTYPE=1.0, 
% %  CB=.357,TC=.220,PHETE=.003,PHETEP=.002$
% SPANFI_E=.7;
% SPANFO_E=6.586;
% CHRDFI_E=1.882;
% CHRDFO_E=.706;
% DELTA_E=10;
%%% PLOTTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warning off MATLAB:divideByZero
hold on

plotFuselage(NX,X,S,R,ZU,ZL,fusres)
plotWing(XW,ZW,ALIW,CHRDR_WG,CHRDBP_WG,CHRDTP_WG,SSPN_WG,SSPNOP_WG,SAVSI_WG,SAVSO_WG,CHSTAT_WG,DHDADI_WG,DHDADO_WG,...
         SPANFI_F,SPANFO_F,CHRDFI_F,CHRDFO_F,DELTA_F,SPANFI_A,SPANFO_A,CHRDFI_A,CHRDFO_A,DELTAL_A,DELTAR_A,TC_WG,wgres)
plotHT(XH,ZH,ALIH,CHRDR_HT,CHRDBP_HT,CHRDTP_HT,SSPN_HT,SSPNOP_HT,SAVSI_HT,SAVSO_HT,CHSTAT_HT,DHDADI_HT,DHDADO_HT,...
       SPANFI_E,SPANFO_E,CHRDFI_E,CHRDFO_E,DELTA_E,TC_HT,wgres)
plotVT(XV,YV,ZV,CHRDR_VT,CHRDBP_VT,CHRDTP_VT,SSPN_VT,SSPNOP_VT,SAVSI_VT,SAVSO_VT,CHSTAT_VT,VERTUP,TC_VT,wgres)

%%% VIEWPORT/FIGURE PROPERTIES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if wframe == 0
    %colormap([1 .7 .1])      %Set a/c to gold
    colormap([0 0 1])         %Set a/c to blue
    shading interp            %Interpolated shading
    lighting gouraud          %Smooth airplane mesh
    camlight right           %Apply a light source  
    
    %Custom Lighting Options, Note:[X Y Z]
    light('Position',[1 -2 1],'Style','infinite');
    light('Position',[1 2 1],'Style','infinite');
    light('Position',[0 0 -6],'Style','infinite');
else
    colormap([1 1 1])         %Set a/c to white
end    

axis off                      %Turn off axis
axis equal                    %Correct aspect ratio
camva(4.5)                   %Zoom in a/c to fit figure
view(3)                       %Apply initial viewport rotation
%camproj('perspective')       %Perspective viewing (not R2006a compatible)
rotate3d  on                  %Rotate icon enabled at start up

%showplottool('plotbrowser')
set(gcf,'NumberTitle','off','Name','Aircraft Plot','Color',[1 1 1]);