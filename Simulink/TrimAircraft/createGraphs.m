% Matt Liepke, create the graphs for AE 413 HW5
close all;
files = dir('*.mat');

%% Problem 1 plots
PlotFlightLog('flightLog.mat',true);

%% Problem 2 plots
for i = 1:length(files)
   PlotFlightLog(files(i).name,false); 
end