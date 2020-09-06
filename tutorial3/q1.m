clear; close all;
gamma = 2407.407;
p_vapor = 95.22/760*1.01*10^5;
p_air = 2*1.01*10^5;
yeqbm = @(xeqbm)(xeqbm*gamma*p_vapor/p_air);
K= gamma*p_vapor/p_air;
xentry = 2.3077*10^(-6);
Xentry = xentry/(1-xentry);
xexit = 1.154*10^(-9);
Xexit = xexit/(1-xexit);
Yentry = 0;
yexit = yeqbm(xentry);
Yexit = yexit/(1-yexit);
Ls = 2.1056;

Vsmin = Ls*(Xentry-Xexit)/(Yexit);
S = 1.423;
Vs = 1.9867*10^(-2);
Yexit = Ls/Vs*(Xentry-Xexit);
% yex = Yexit/(1+Yexit);
% S = 1.425;
% K=150.76;
% yex = 2.436*10^-4;
% xe
yex = Yexit/(1+Yexit);
Nog = log(((1-S)*(-K*xentry)/(yex-K*xentry))+S)/(1-S);