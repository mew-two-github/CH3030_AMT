clear; close all;
F = 158.21;
xD = 0.9745;
R = 3.5;
m = R/(R+1);
yeqbm = [0.21 0.37 0.51 0.64 0.72 0.79 0.86 0.91 0.96 0.98];
xeqbm = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.95];
pp = spline(yeqbm,xeqbm);
fun = @(x)(m*(x-xD)+xD);
y = xD;
zF = 0.44;
xcoords = zeros(1,7);
ycoords = zeros(1,7);
xcoords2 = zeros(1,8);
ycoords2 = zeros(1,8);
xcoords2(1)= xD;
ycoords2(1) = xD;
i = 0;
while y >= zF
    i = i + 1;
    x = ppval(pp,y);
    xcoords(i) = x;
    xcoords2(i+1)=x;
    ycoords(i) = y;
    y = fun(x);
    ycoords2(i+1) = y;
    
end
x = linspace(0,1,15);
qline = @(x)(zeros(size(x))+zF);
plot(xeqbm,yeqbm,x,fun(x),x,qline(x),x,x,xcoords,ycoords,'x',xcoords2,ycoords2,'o');