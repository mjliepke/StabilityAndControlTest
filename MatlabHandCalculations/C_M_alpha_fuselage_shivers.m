function C_M_alpha_fuselage_shivers = C_M_alpha_fuselage_shivers(lf, lf_up, l_h, h_h, c_r, c_t, bf, b, sweep_quarter)
%This script was created by Meagan Shivers
%Made for AE 413
%This script contains the code for finding the coefficient of pitching 
%moment of the fuselage of the Sig Rascal 72 using Multhopp's Theory
%The fuselage was split into 100 sections of upwash then 100 sections of
%downwash.
%
%MODIFIED FOR TEST 1 by Matthew Liepke to be callable function.  To retain the 
% originality of the code many things were commented out, let them remain as such
% when running this as a function


%   lf      : length of fuselage in ft
%   lf_up   : length of fuselage in upwash in ft
%   l_h     : length from wing AC to tail AC 
%   h_h     : vert height of horz tail from wing 
%   c_r     : root chord of wing
%   c_t     : tip chord of wing
%   bf      : fuselage width in inches(array of 5 sections: [ a b c d e])
%   b       : span of wing
%   sweep_quarter: sweep at the quarter chord in rad

%Geometry of aircraft
%Fuselage length
%lf = (46/12) - (12.5/12); %[ft]
%lf_up = 10/12; %[ft]
lf_down = lf - lf_up; %[ft]
%Fuselage width
%bf = [1.2 1.92 1.34 0.8 0.4]; %[in]
%Fuselage width squared
bf_ftsq = (bf./12).^2; %[ft]
%Root and tip chord of wing
% c_r = 12.5/12; %[ft]
% c_t = 5/12; %[ft]
%Wing span
%b = 55.47; %[ft]
%Height of tail from wing
% h_h = 0;
%AC wing to AC tail
%l_h = 23/12; %[ft]
%Sweep at leading edge
%sweep_quarter = 0;



%Finding the downwash model
%Finding taper ratio
lambda = c_t/c_r;
%Estimating wing surface area
s = (b/2)*c_r*(1+lambda); %[ft^2]
%Find MAC
c = (2/3)*c_r*((1+lambda+lambda^2)/(1+lambda)); %[ft]
%Find aspect ration
A = b^2/s;
%Find KA
K_A = (1/A) - (1/(1+A^1.7));
%Find K lambda
K_l = (10-3*lambda)/7;
%Find KH
K_H = (1-(h_h/b))/((2*(l_h/b))^(1/3));
%Find downwash model
dE_da = 4.44*(K_A*K_l*K_H*(cos(sweep_quarter))^(1/2))^1.19;

%For downwash section (after wing)
cm_a_down = 0;
%Split the fuselage behind the wing into sections of equal length
dx_down = lf_down/100;
%Create xl for each of the 100 sections
xl_down = [];
for i = 1:100
    if i == 1
       xl_down(i) = 0.5*dx_down;
    else
       xl_down(i) = i*dx_down + 0.5*dx_down;
    end
end
dE_da_down = [];
%Create downwash model approximation
for k = 1:length(xl_down)
    dE_da_down(k) = (xl_down(k)/l_h)*(1-dE_da);
end
%Find down
for j = 1:length(xl_down)
%25 sections for bf(2)
    if j > 1 && j <= 25
    cm_a_down = bf_ftsq(2)*dE_da_down(j)*dx_down;
    end
%25 sections for bf(3)
    if j > 25 && j <= 50
        cm_a_down = bf_ftsq(3)*dE_da_down(j)*dx_down;
    end
%25 sections for bf(4)
    if j > 50 && j <= 75
        cm_a_down = bf_ftsq(4)*dE_da_down(j)*dx_down;
    end
%25 sections for bf(5)
    if j > 75 && j <= 100
        cm_a_down = bf_ftsq(5)*dE_da_down(j)*dx_down;
    end
end

%For the upwash section (before wing)
cm_a_up = 0;
%Split the fuselage in front of the wing into sections of equal length
dx_up = lf_up/100;
%Create xl for each of the 100 sections
xl_up = [];
for l = 1:100
    if l == 1
       xl_up(l) = 0.5*dx_up;
    else
       xl_up(l) = l*dx_up + 0.5*dx_up;
    end
end
%Create and populate matrix holding the xl/cr for upwash
xl_cr = [];
for m = 1:length(xl_up)
    xl_cr(m) = xl_up(m)/c_r;
end
%100 sections for upwash
dE_da_up = [];
for n = 1:length(xl_cr)
    if n == length(xl_up)
    dE_da_up(n) = 0.7756*(xl_cr(n)^-0.679);
    end
    dE_da_up(n) = (-0.179*log(xl_cr(n)))+0.2462;
end
%Find upwash contribution
for o = 1:length(dE_da_up)
    cm_a_up = bf_ftsq(1)*(1+dE_da_up(o))*dx_up;
end

%Sum upwash and downwash to find total pitching moment of fuselage
C_M_alpha_fuselage_shivers = cm_a_up + cm_a_down;
end