close all; clear;
%% Equilibrium Data
r_tce = [0.1,0.07,0.03,0.02,0.01,0.005];
r_a = [0.55,0.5,0.4,0.3,0.2,0.1];
r_p = spline(r_a,r_tce);
e_a = [0.6,0.5,0.4,0.3,0.2,0.1];
e_tce = [0.27,0.46,0.57,0.68,0.785,0.89];
e_p = spline(e_a,e_tce);
%% Given Feed Data
yF =0.35;
yRN = 0.1;
F = 1300;
%% Tie Line data
ac_raff = [0.44,0.29,0.12];
ac_ext = [0.56,0.4,0.18];
tce_r = ppval(r_p,ac_raff);
tce_e = ppval(e_p,ac_ext);
xRN = ppval(r_p,yRN);
%-- Plot the axis system
[h,hg,htick]=terplot;
%-- Plot the data ...
hter=ternaryc(1-r_tce-r_a,r_tce,r_a);
hold on;
%-- ... and modify the symbol:
set(hter,'marker','o','markerfacecolor','none','markersize',4)
hlabels=terlabel('C','S','A');
grid on;
grid minor;