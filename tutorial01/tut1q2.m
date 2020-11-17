close all;
Vs = 176.4;
Yentry = 0.02;
Yexit = 0.03*0.02;
Xentry = 0;
gamma = 6;
P = 110*10^3;
pvap = 10.5 * 10^3;
k = P/gamma/pvap;
X = @(Y)(k*Y);
Xexit = X(Yentry);
Lsmin = Vs*((Yentry-Yexit)/(Xexit));
Ls = 1.5*Lsmin;
m = Ls/Vs;
i = 0;
y = Yexit;
xcoords = zeros(1,3);
ycoords = zeros(1,3);
ycoords2 = ycoords;
while y <= Yentry
    i = i + 1;
    x = X(y);
    xcoords(i) = x;
    ycoords(i) = y;
    y = 0.03*0.02 + m*(x);
    ycoords2(i) = y;
    
end
ys = 0:0.0005:0.02;
xs = (ys - 0.03*0.02)/m;
plot(X(ys),ys,xs,ys,xcoords,ycoords,'o',xcoords,ycoords2,'x');