clear; close all;
yentry = 0.1;
Yentry = yentry/(1-yentry);
xentry = 0;
yexit = 0.03*0.1/(0.03*0.1+0.9);
Yexit = yexit/(1-yexit);
mw = 0.1*64+0.9*29;
Vs = 1500/mw*0.9;
xeqbm = [0 0.562 1.403 2.8 4.22 8.42 14.03 19.65 27.9]*10^(-4);
yeqbm = [0 0.792 2.23 6.19 10.65 25.9 47.3 68.5 104]*(10^(-3));
xy = spline(yeqbm,xeqbm);
%part a
Xeqbm = xeqbm./(1-xeqbm);
Yeqbm = yeqbm./(1-yeqbm);
figure(1);
title('EqbmPlot')
xlabel('Xeqbm')
ylabel('Yeqbm')
plot(Xeqbm,Yeqbm);
XY = spline(Yeqbm,Xeqbm);
Xexit = ppval(XY,Yentry);
Lsmin = Vs*(Yentry-Yexit)/(Xexit);
%Part b
kx=1.25;
ky=0.075;
cs = 0.781;
Ls = 1.25*Lsmin;
%operating line in terms of mole ratio
OL = @(val)(Vs/Ls).*(val - Yexit);
%n points on operating line
n = 10;
Y = linspace(Yexit,Yentry,n);
X = OL(Y);
x = X./(1+X);
y = Y./(1+Y);
%From n points, draw lines of slope -kx/ky and find intersection at eqbm
%curve. Substitute Xi in terms of the line equation & curve equation,
%equate them and set to zero
func = @(yi)(-ky/kx*(yi-y)+x) - ppval(xy,yi);
yi = fsolve(func,zeros(1,n));
%Value of function to be integrated
f = (1+Y)./((y-yi).*(1-y));
%Integrate yis using trapezoidal rule
AUC = trapz(y,f);
H = AUC*(Vs/(cs*3600*ky));
figure(2);
title('f(y) vs y(mole fraction)')
xlabel('y')
ylabel('f(y)')
plot(y,f)
