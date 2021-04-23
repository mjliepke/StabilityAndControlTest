function na = PlotFlightLog(file, p1)
%PLOTFLIGHTLOG Plots values of a flightLog as created by TrimLearjetModel
%   file - string with .mat file
%   Matt Liepke, Spr 2021
data = load(file);
time = data.data.Time(:);
vel = data.data.Data(:,1); %cause matlab is stupid
aoa = data.data.Data(:,2);
pitchrate = data.data.Data(:,3);
pitch = data.data.Data(:,4);
alt = data.data.Data(:,5);

figure('Name', file);
hold on;
if(p1)
   tiledlayout(2,2)
   nexttile
   
    plot(time, aoa);
    title('AOA vs time')
    ylabel('AOA [rad]');
    xlabel('time [sec]');
    
    nexttile
    plot(time, alt);
    title('Altitude vs time');
    ylim([0 max(alt)*2])
    ylabel('Alt [ft]');
    xlabel('time [sec]');
    
    nexttile
    plot(time, vel);
    title('Velocity vs time');
    ylabel('Velocity [ft/s]');
    xlabel('time [sec]');
    
    nexttile
    yyaxis right;
    plot(time, pitch)
    ylabel('pitch angle [rad]');
    yyaxis left;
    plot(time, pitchrate);
    ylabel('pitch rate [rad/sec]');
    xlabel('time [sec]');
    title('Pitch characteristics vs time');
    
else
    title(file);
    yyaxis left;
    plot(time, aoa);
    plot(time,pitch);
    ylabel('rad or rad/sec');
    
    yyaxis right;
    plot(time,alt);
    ylabel('altitude [ft]');
    ylim([0 max(alt)*2])
    
    xlabel('time');
    legend('aoa','pitch','altitude');
end
end

