close all;clear;
xD = 0.97;
xW = 0.01;
zF = 0.67;
q = 0.7;
qline = @(x)(q/(q-1).*(x-zF) + zF);
xeqbm = [0,0.0296,0.0615,0.1106,0.1435,0.2585,0.3908,0.5318,0.663,0.7574,0.8604,1];
yeqbm = [0,0.0823,0.1555,0.266,0.3325,0.495,0.634,0.747, 0.829, 0.878, 0.932,1];
ec = spline(xeqbm,yeqbm);
%finding intersection of eqbm curve and q line
fun = @(x)(qline(x)-ppval(ec,x));
x_int = fsolve(fun,1);
m_min = (qline(x_int)-xD)/(x_int-xD);
ycept = (qline(x_int)-xD)/(x_int-xD)*(-xD) + xD;
R_min = (xD/ycept)-1;
R = 2*R_min;
R_OL = @(x)(R/(R+1)*(x-xD)+xD);
fun2 = @(x)(qline(x)-R_OL(x));
xint = fsolve(fun2,0);
yint = qline(xint);
pp = spline(yeqbm,xeqbm);
i = 0;
y = xD;
S_OL = @(x)((yint-xW)/(xint-xW)*(x-xW) + xW);
xcoords = zeros(1,13);
ycoords = zeros(1,13);
xcoords2 = zeros(1,14);
ycoords2 = zeros(1,14);
xcoords2(1)= xD;
ycoords2(1) = xD;
%Last stage wont be a tray but is the partial reboiler
while y>=xW
    i = i + 1;
    x = ppval(pp,y);
    xcoords(i) = x;
    xcoords2(i+1)=x;
    ycoords(i) = y;
    if x >= xint
        y = R_OL(x);
    else
        y = S_OL(x);
    end
    ycoords2(i+1) = y;
    
end
x = linspace(0,1,15);
N_actual = i-1;
figure();
plot(xeqbm,yeqbm,x,R_OL(x),x,qline(x),x,x,x,S_OL(x),xcoords,ycoords,'x',xcoords2,ycoords2,'o');
figure();
plot(xeqbm,yeqbm,x,R_OL(x),x,x,x,S_OL(x),xcoords,ycoords,'x',xcoords2,ycoords2,'o');
figure();
%Min number of trays => R->infinity
xcoords = zeros(1,7);
ycoords = zeros(1,7);
xcoords2 = zeros(1,8);
ycoords2 = zeros(1,8);
y = xD;
xcoords2(1)= xD;
ycoords2(1) = xD;
i = 0;
while y>=xW
    i = i + 1;
    x = ppval(pp,y);
    xcoords(i) = x;
    xcoords2(i+1)=x;
    ycoords(i) = y;
    y = x;
    ycoords2(i+1) = y;
end
N_th = i-1;
plot(xeqbm,yeqbm,xeqbm,xeqbm,xcoords,ycoords,'x',xcoords2,ycoords2,'o');
%Moral of the story: MATLAB automatically extends arrays? Or maybe it
%doesnt reset them in the first place?