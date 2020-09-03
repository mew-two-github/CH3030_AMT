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
plot(Xeqbm,Yeqbm);
XY = spline(Yeqbm,Xeqbm);
Xexit = ppval(XY,Yentry);
Lsmin = Vs*(Yentry-Yexit)/(Xexit);
%Part b
Ls = 1.25*Lsmin;

kx=1.25;
ky=0.075;
cs = 0.781;
