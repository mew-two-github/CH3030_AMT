close all; clear;
%number of yis
n = 20;
y = 0.03:(0.1-0.03)/n:0.1;
Yr = y./(1-y);
Mw = 0.9*28.9+0.1*64;
V = 1500/Mw;%in kmol/h
Vs = 0.9*V;

Yentry = 0.111;
Yexit = 0.03;

Xentry = 0;
xeqbm = [0 0.562 1.403 2.8 4.22 8.42 14.03 19.65 27.9]*10^(-4);
yeqbm = [0 0.792 2.23 6.19 10.65 25.9 47.3 68.5 104]*(10^(-3));
ky = 0.075;
kx = 1.25;
X = xeqbm./(1-xeqbm);
Y = yeqbm./(1-yeqbm);
PP =  spline(Y,X);

%function having the slope -kx/ky intersecting the eqbm curve

Xexit = ppval(PP,Yentry);
Lsmin = Vs*(Yentry-Yexit)/(Xexit-Xentry);
Ls = 1.25*Lsmin;

pp = spline(yeqbm,xeqbm);

Xr  = Vs/Ls.*(Yr - Yexit);
x = Xr./(1+Xr);
yi = y;
for i = 1:11
    func = @(val) (-1*ky/kx.*(val-y(i)) + x(i)) - ppval(pp,val);
    yi(i) = fsolve(func,0);
end
func_val = 1./((1-y).^2.*(y-yi));
AUC = trapz(y,func_val);
H = AUC*(Vs/(ky*3600))/0.781;
plot(y,func_val);
figure();
plot(y,x);