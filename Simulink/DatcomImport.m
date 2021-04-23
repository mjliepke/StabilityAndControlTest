%% This code was provided by Hever Moncayo for AE 413 and was modified by Matthew Liepke
% Matthew Liepke edited to provide automatic saving of all derivatives for
% the final project to be used as lookup tables in his simulink model
%
% This program automaticially runs datcom.exe and you must input the file
% name you wish to run it on.  Then it auto-imports the matricies into
% data/____ for use in simulink
clear;
close all;
clc;

runDatcom = true;
showGraphs = false;

%% Import Data from Datcom file ('datcom.out') after running datcom (if user wants)
if(runDatcom)
    fprintf("INPUT THE NAME OF THE FILE YOU WANT DATCOM TO RUN:")
    system('datcom.exe')
end

if(count(fileread('datcom.out'),"ERROR") > 4)
    fprintf("ERROR, your DATCOM output file is bad. Check for input errors\n");
    fprintf("** CLOSING PROGRAM DUE TO BAD 'datcom.out' FILE **\n");
    return;
end
fprintf("Starting the import process, this could take a while\n");
alldata = datcomimport('datcom.out', false, 2);
data = alldata{1};



%% Create valuable data to be used for simulink
fprintf("Starting to save variables\n");
cmq_matrix = data.cmq;
cma_matrix = data.cma;
clb_matrix = data.clb;
cnb_matrix = data.cnb;
cla_matrix = data.cla;
cnp_matrix = data.cnp;
cnr_matrix = data.cnr;
clr_matrix = data.clr;
cyp_matrix = data.cyp;
cyb_matrix = data.cyb;
xcp_matrix = data.xcp;
qqinf_matrix = data.qqinf;
eps_matrix = data.eps;
depsdalp_matrix = data.depsdalp;
clq_matrix = data.clq;
clad_matrix = data.clad;
cmad_matrix = data.cmad;
clp_matrix = data.clp;



mach_matrix = data.mach;
alt_matrix = data.alt;
alpha_matrix = data.alpha;

%% Get rid of 9999 values that datcomimport decides to spit out - copy first layer of matrix to rest of 9999 values

if(max(max(max(cyb_matrix)))>1000) % safe bet that no derivatives are this order of magnidute
    for i=2:size(cyb_matrix,1)
        cyb_matrix(i,:,:) = cyb_matrix(1,:,:);
    end
end

if(max(max(max(cnb_matrix)))>1000) % safe bet that no derivatives are this order of magnidute
    for i=2:size(cnb_matrix,1)
        cnb_matrix(i,:,:) = cnb_matrix(1,:,:);
    end
end

if(max(max(max(clq_matrix)))>1000) % safe bet that no derivatives are this order of magnidute
    for i=2:size(clq_matrix,1)
        clq_matrix(i,:,:) = clq_matrix(1,:,:);
    end
end

if(max(max(max(cmq_matrix)))>1000) % safe bet that no derivatives are this order of magnidute
    for i=2:size(cmq_matrix,1)
        cmq_matrix(i,:,:) = cmq_matrix(1,:,:);
    end
end

%% Save the Files
mkdir('data');

save('data/cmq_matrix.mat','cmq_matrix')
save('data/cma_matrix.mat','cma_matrix')
save('data/clb_matrix.mat','clb_matrix')
save('data/cnb_matrix.mat','cnb_matrix')
save('data/cla_matrix.mat','cla_matrix')
save('data/cnp_matrix.mat','cnp_matrix')
save('data/cnr_matrix.mat','cnr_matrix')
save('data/clr_matrix.mat','clr_matrix')
save('data/cyp_matrix.mat','cyp_matrix')
save('data/cyb_matrix.mat','cyb_matrix')
save('data/xcp_matrix.mat','xcp_matrix')
save('data/qqinf_matrix','qqinf_matrix')
save('data/eps_matrix','eps_matrix')
save('data/depsdalp_matrix','depsdalp_matrix')
save('data/clq_matrix','clq_matrix')
save('data/clad_matrix','clad_matrix')
save('data/clq_matrix','clq_matrix')
save('data/clad_matrix','clad_matrix');
save('data/cmad_matrix','cmad_matrix');
save('data/clp_matrix','clp_matrix');


save('data/mach_matrix.mat','mach_matrix');
save('data/alt_matrix.mat','alt_matrix');
save('data/alpha_matrix.mat','alpha_matrix');

%% Plot some Stuff if you want
if(showGraphs)
    % The missing data points will be filled with the values for the first alpha, since these data points are meant to be used for all alpha values.
    
    aerotab = {'cyb' 'cnb' 'clq' 'cmq'};
    
    for k = 1:length(aerotab)
        for m = 1:data.nmach
            for h = 1:data.nalt
                data.(aerotab{k})(:,m,h) = data.(aerotab{k})(1,m,h);
            end
        end
    end
    
    
    % Aerodynamic Coefficients
    % You can now plot the aerodynamic coefficients:
    %
    % Plotting Lift Curve Moments
    validMachCount = length(data.mach(:));%10; % Some may give NAN or errors
    h1 = figure;
    hold on;
    for k=1:validMachCount
        plot(data.alpha,permute(data.cl(:,k,:),[1 3 2]))
        grid
    end
    title('Lift Curve');
    legend(strcat('Mach ', num2str(rot90(data.mach(1:validMachCount)))));
    ylabel('Lift Coefficient');
    xlabel('Angle of Attack (deg)')
    
    % Plotting Drag Polar Moments
    h2 = figure;
    hold on;
    for k=1:validMachCount
        plot(permute(data.cd(:,k,:),[1 3 2]),permute(data.cl(:,k,:),[1 3 2]))
        grid
    end
    legend(strcat('Mach ', num2str(rot90(data.mach(1:validMachCount)))),'Location','southeast');
    title('Drag Polar');
    ylabel('Lift Coefficient');
    xlabel('Drag Coefficient');
    
    % Plotting Pitching Moments (Cm vs AOA)
    h3 = figure;
    hold on;
    for k=1:validMachCount
        plot(data.alpha,permute(data.cm(:,k,:),[1 3 2]))
        grid
    end
    
    legend(strcat('Mach ', num2str(rot90(data.mach(1:validMachCount)))));
    ylabel('Pitching Moment Coefficient')
    title('Pitching Moment vs AOA')
    xlabel('AOA [deg]')
end

%% Clean up Datcom For loop files and the output
if isfile('for014.dat')
    delete 'for014.dat'
end
if isfile('for013.dat')
    delete 'for013.dat'
end
if isfile('datcom.out')
    delete 'datcom.out'
end

fprintf("Done Cleaning up Datcom files, all data has been imported\n");
fprintf("If you now want to run the model open 'LiepkePlane.slx' and hit 'Run'\n");