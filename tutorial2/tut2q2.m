clear; close all;
Ventry = 0.4*1.013*10^5/8.314/297;
yentry = 50/760;
xentry=0;
Vs = (1-yentry)*Ventry;
Yentry = yentry/(1-yentry);
yexit = 0.005;
Yexit = yexit/(1-yexit);
xeqbm = @(y)(760/346*y);
xexit = xeqbm(yentry);
Xexit = xexit/(1-xexit);
Lsmin = Vs*(Yentry-Yexit)/(Xexit);
Ratiomin = (Yentry-Yexit)/(Xexit);
Ls = 1.5*Lsmin*180/1000*3600;
m = 1.5*Ratiomin;
y = Yexit;
i = 0;
xcoords = zeros(1,6);
ycoords = zeros(1,6);
ycoords2 = ycoords;
while y <= Yentry
    i = i + 1;
    x = (y)/0.455;
    xcoords(i) = x;
    ycoords(i) = y;
    y = Yexit + m*(x);
    ycoords2(i) = y;
end
ypoints = linspace(Yentry,Yexit,10);
OL = 1/m.*(ypoints-Yexit);
Eqbm = ypoints/0.455;
figure();
plot(OL,ypoints,Eqbm,ypoints,xcoords,ycoords,'x',xcoords,ycoords2,'o');
%Kremser's method
K = 346/760;
A = m/(K);
N = log((yentry-K*xentry)/(yexit-K*xentry)*(1-1/A)+1/A)/log(A);
%efficiency
mu = 2*10^(-3);
pho = 0.81*1000;
abs = mu*0.455*180/pho;
Eo = 0.25;
N_actual = N/Eo;