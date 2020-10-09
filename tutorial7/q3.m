clear; close all;
%% Given data
u_superficial = 0.29;
t = [9.5,19,21,25.7,34.3,39,42,46.7,51.4,56.2,64.7,68.6,72.4,77.1,84.8,97.1,104.7,108.6];
te = 108.6;
c = [0,0.018,0.037,0.083,0.287,0.435,0.491,0.62,0.713,0.768,0.852,0.935,0.952,0.963,0.97,0.987,0.991,1];
L = 0.2;
ci = 0.11;
%% Part a
t_break = spline(c,t,0.03);
pp = spline(t,c);
n = 40;
time = linspace(9.5,108.6,n*(10));
min = trapz(time,ppval(pp,time));
ts = 230;
ar_diff = zeros(n*10-1,1);
l = length(time);
for i = 2:l-1
    ar_diff(i) = trapz(time(1:l),ppval(pp,time(1:l)))-(108.6-time(i));
    if min > abs(ar_diff(i))
        min = abs(ar_diff(i));
        ts = time(i);
    end
end
us = L/ts*60; %m/h
LUB = L*(1-t_break/ts);
MTZ = (te-t_break)/te*L;%Since curve is NOT symmetric
%% Part b
V = 3000/60/60;%m^3/s
D = sqrt(4*V/(u_superficial*pi));
t_cycle = 8;
bed_density = 700;
L_used = 8*us;
L_scaleup = MTZ + L_used; 
sol_adsorbed = V*ci*t_cycle*3600;
avg_loading = sol_adsorbed/(L_scaleup*bed_density*pi*D^2/4);
max_loading = sol_adsorbed/(L_used*bed_density*pi*D^2/4);