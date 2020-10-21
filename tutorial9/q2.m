% Ether-Carrier, Alcohol-A, Water-Solvent
clear; close all;
%% Equilibrium data
ar = 0.01*[2.4 3.2 5 9.3 24.9 38 45.2];
sr = 0.01*[0.9 1.1 1.4 2.1 5.7 11.8 21.2];
raff = spline(ar,sr);
r = spline(sr,ar);
ae = 0.01*[8.1 8.6 10.2 11.7 17.5 21.7 26.8];
se = 0.01*[90.1 89.6 88.3 86.7 80.6 76 69.8];
ext = spline(ae,se);
e = spline(se,ae);
%additional points
a_add = 0.01*[45.37 44.55 39.57 36.23 24.74 21.33 0 0];
s_add = 0.01*[24.93 33 47.01 54.11 72.52 76.61 99.4 0.5];
% %binodal curve
% a = zeros(1,22);
% a(1:7) = ar; 
% a(8:14) = ae; 
% a(15:21) = a_add(1:7);
% s = zeros(1,2);
% s(1:7) = sr; 
% s(8:14) = se; 
% s(15:21) = a_add(1:7);
% eqbm1 = spline(a,s);
% eqbm2 = spline(s,a);
%% plot
hold on;
plot(sr,ar,'b',se,ae,'r',s_add,a_add,'c');
%Completing the triangle
plot(linspace(0,1,5),1-linspace(0,1,5));
%Plotting the axes
plot(zeros(1,2),linspace(-0.5,1.5,2),'k');
plot(linspace(-0.5,1,2),zeros(1,2),'k');
plot(sr,ar,'rx',se,ae,'bx');
grid on; grid minor;
%% conjugate curve
curve = spline(se,ar);
plot(linspace(0.7,0.9,10),ppval(curve,linspace(0.7,0.9,10)),se,ar,'ro');
%% Given Feed Data
yF =0.5;
xF = 0.05;
yRN = 0.05;
xRN = ppval(raff,yRN);
yE1 = 0.2;
xE1 = ppval(ext,yE1);
plot([xF,xE1,xRN,1],[yF,yE1,yRN,0],'x');
%% Finding Del point
RS = polyfit([xRN,1],[yRN,0],1);
FE = polyfit([xE1,xF],[yE1,yF],1);
fun = @(x)(polyval(RS,x)-polyval(FE,x));
delx = fsolve(fun,0);
dely = polyval(RS,delx);
%% Drawing lines from the del point
%no. of lines
n = 10;
m = linspace(FE(1),RS(1),n);
line = @(y)(delx + 1./m.*(y-dely));
raff_int = @(y)(line(y)-ppval(raff,y));
% ext_int = @(y)(line(y)-ppval(ext,y));
xA = fsolve(raff_int,zeros(1,n)+1);
xB = line(xA);
line1 = @(x)(m.*(x-delx)+dely);
% raff_int = @(x)(line(x)-ppval(r,x));
[p,s] = polyfit(se,ae,4);
ext_int = @(x)(line1(x)-polyval(p,x));
yB = fsolve(ext_int,zeros(1,n)+1);
yA = line1(yB);
plot([xF,xE1,xRN,1],[yF,yE1,yRN,0],'x');
% % Resizing since only 7 points were properly obtained
% yB = yB(1:7);
% yA = yA(1:7);
% xA = xA(1:7);
% xB = xB(1:7);
figure();
hold on;
plot(sr,ar,'b',se,ae,'r',s_add,a_add,'c');
plot(delx,dely,'x');
%Completing the triangle
plot(linspace(0,1,5),1-linspace(0,1,5));
%Plotting the axes
plot(zeros(1,2),linspace(-0.5,1.5,2),'k');
plot(linspace(-0.5,1,2),zeros(1,2),'k');
grid on; grid minor;
plot(xB,xA,'rx',yB,yA,'bx');%,linspace(0.7,1,10),polyval(p,linspace(0.7,1,10)),'k');
%% Equilibrium projection
xeqbm = ar;
yeqbm = ae;
figure();
hold on; 
plot(xeqbm,yeqbm,[0.21,0],[0.21,0],xA,yA,'.',xA,yA);
grid on; grid minor;
legend('eqbm curve','x=y','operating line','Location','northwest');
%% Stepping
i = 1;
xy = spline(yeqbm,xeqbm);
OL = spline(xA,yA);
xcoords = zeros(1,7);
ycoords = zeros(1,7);
xcoords2 = zeros(1,8);
ycoords2 = zeros(1,8);
% y0 = 0.2;
% x0 = spline(yA,xA,y0);
% xcoords2(1)= x0;
% ycoords2(1) = y0;
% while y0>0.05
%     x0 = ppval(xy,y0);
%     xcoords(i) = x0;
%     xcoords2(i+1) = x0;
%     ycoords(i)=y0;
%     y0 = ppval(OL,x0);
%     ycoords2(i+1) = y0;
%     i = i + 1;yeqbm,xeqbm
% end
x0 = 0.05;
y0 = spline(xA,yA,x0);
yx = spline(xeqbm,yeqbm);
LO = spline(yA,xA);
xcoords2(1)= x0;
ycoords2(1) = y0;
while y0 < 0.2
    y0 = ppval(yx,x0);
    xcoords(i) = x0;
    ycoords(i)=y0;
    x0 = ppval(LO,y0);
    xcoords2(i+1) = x0;
    ycoords2(i+1) = y0;
    i = i + 1;
end
plot(xcoords,ycoords,'x',xcoords2,ycoords2,'o');
% %% Extract limit
% f = @(x)(ppval(yx,x)-ppval(OL,x));
% xlimit = fsolve(f,0.45);
% ylimit = ppval(OL,xlimit);