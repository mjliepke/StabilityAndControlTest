function ControlSurfaceEffectivenessTau = ControlSurfaceEffectivenessTau(S_lifting, S_control)
%CONTROLSURFACEEFFECTIVENESSTAU Gives the Tau parameter from 2.21 via an
%approximate function.  
% Created by Matthew Liepke for AE 413 Final project
%   S_lifting   :   Surface of lifting planform (wing, for example)
%   S_control   :   Surface of the control surface planform (aileron, for
%   example)
ratio = S_control/S_lifting;
ControlSurfaceEffectivenessTau = ratio^(.6);
end

