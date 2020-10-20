clear; close all;
%% Equilibrium Data
a_e = [0,11.05,18.95,24.1,28.6,31.55,35.05,40.6,49]*0.01;
c_e = 0.01*[0.05 0.67 1.15 1.62 2.25 2.87 3.95 6.4 13.2];
s_e = 0.01*[99.95 88.28 79.9 74.28 69.15 65.58 61 53 37.8];
a_r = 0.01*[0 5.02 11.05 18.9 25.5 36.1 44.95 53.2 49];
s_r = 0.01*[0.08 0.16 0.24 0.38 0.58 1.85 4.18 8.9 37.8];
c_r = 0.01*[99.92 94.82 88.71 80.72 73.92 62.05 50.87 37.9 13.2];
plot(s_e,a_e,'red',s_r,a_r,'blue',s_e,a_e,'rx',s_r,a_r,'bo');
hold on;
plot([0,1],[0,0],'green',[0,0],[0,1],'green',[1,0],[0,1],'green');
% %Plotting the tie lines
% for i = 1:9
%     plot([s_r(i),s_e(i)],[a_r(i),a_e(i)],'m');
% end
grid on;grid minor;
rx = spline(a_r(1:8),s_r(1:8));
ey = spline(s_e(1:8),a_e(1:8));
%% conjugate curve
cc_y = spline(s_e,a_r);
plot(s_e,a_r);
cc_x = spline(a_r(1:8),s_e(1:8));
%% Feed data
mF1 = 2000;
yF1 = 0.5;
yS = 0;
S1 = mF1;
%% Mixing point 1
yM = yF1/2;
xM = 0.5;%Always
plot(xM,yM,'+');
sol = fsolve(@(x) cctie(x,xM,yM,rx,ey,cc_y),0.6);
[xR1,yR1,xE1,yE1] = endpts(sol,rx,ey,cc_y);
plot([xR1,xE1],[yR1,yE1],'m',0,yF1,'x');
%% Stage 2
yM2  = yR1/2;
plot(xM,yM2,'r+');
sol2 = fsolve(@(x) cctie(x,xM,yM2,rx,ey,cc_y),0.7);
[xR2,yR2,xE2,yE2] = endpts(sol2,rx,ey,cc_y);
plot([xR2,xE2],[yR2,yE2],'m');
%% Stage 3
yM3  = yR2/2;
plot(xM,yM3,'r+');
sol2 = fsolve(@(x) cctie(x,xM,yM3,rx,ey,cc_y),0.7);
[xR3,yR3,xE3,yE3] = endpts(sol2,rx,ey,cc_y);
plot([xR3,xE3],[yR3,yE3],'m');
% %% Stage 4
% yM3  = yR3/2;
% plot(xM,yM3,'r+');
% sol2 = fsolve(@(x) cctie(x,xM,yM3,rx,ey,cc_y),0.7);
% [xR3,yR3,xE3,yE3] = endpts(sol2,rx,ey,cc_y);
% plot([xR3,xE3],[yR3,yE3],'m');
%% mass balance
raff_m = zeros(1,3)+mF1;
R = mF1;
y_E = [yE1 yE2 yE3];
y_R = [yF1 yR1 yR2 yR3];
for i = 1:2
    R = R*(2*y_E(i)-y_R(i))/(y_E(i)-y_R(i+1));
    raff_m(i+1) = R;
end
%% Function to get end pts of tie line given pt on cc
function [xR,yR,xE,yE] = endpts(x,rx,ey,cc_y)
    xE = x;
    yR = ppval(cc_y,x);
    xR = ppval(rx,yR);
    yE = ppval(ey,xE);
end
%% function to return slope difference given point on cc and mid pt
function val = cctie(x,xM,yM,rx,ey,cc_y)
    xE = x;
    yR = ppval(cc_y,x);
    xR = ppval(rx,yR);
    yE = ppval(ey,xE);
    val = (yE-yR)*(xE-xM) - (yE-yM)*(xE-xR);
end
