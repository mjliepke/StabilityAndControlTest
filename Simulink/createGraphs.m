% Matt Liepke, create the graphs for AE 413 HW5
close all;
files = dir('*.mat');

%% Problem 1 plots
PlotFlightLog('flightLog.mat',true);

fprintf("Done plotting Flight Log");