clear; close all;
%Given data
xeqbm = [0,0.019,0.0721,0.0966,0.1238,0.1661,0.2337,0.2608,0.3273,0.3965,0.5079,0.5198,0.5732,0.6763,0.7472,0.8943];
yeqbm = [0,0.17,0.3891,0.4375,0.4704,0.5089,0.5445,0.558,0.5826,0.6122,0.6564,0.6599,0.6841,0.7385,0.7815,0.8943];
pp = spline(xeqbm,yeqbm);
xD = 0.8;
xB = 0.01;
zF = 0.1;

%Rmin evaluation
m_min = (0.8-ppval(pp,0.1))/(0.8-0.1);
Rmin = m_min/(-m_min+1);
R = 1.5*Rmin;
OL = @(x) (R/(R+1).*(x-0.8)+0.8);
ycoord = OL(0.1);
x = linspace(0,0.8,30);
%Getting stripping section operating line
m_s = (ycoord-0.01)/(0.1-0.01);
SL = @(x)(m_s.*(x-0.01) + 0.01);
figure();
plot(x,ppval(pp,x),x,OL(x),x(1:6),SL(x(1:6)),x,x);
title('Operating lines');
legend('Eqbm curve','Rectification Line','Stripping Line');
xlabel('x');
ylabel('y');
%Stepping process
i=0;%Step counter
y = xD;
PP = spline(yeqbm,xeqbm);
xcoords = zeros(1,7);
ycoords = zeros(1,7);
xcoords2 = zeros(1,8);
ycoords2 = zeros(1,8);
xcoords2(1)= xD;
ycoords2(1) = xD;
while y >= 0.01
    i = i + 1;
    x = ppval(PP,y);
    xcoords(i) = x;
    xcoords2(i+1)=x;
    ycoords(i) = y;
    if x > 0.1
        y = OL(x);
    else
        y = SL(x);
    end
    ycoords2(i+1) = y;
end
%Plotting the steps
x = linspace(0,0.8,30);
figure();
plot(x,ppval(pp,x),x,OL(x),x(1:6),SL(x(1:6)),x,x);
title('Operating lines with steps');
xlabel('x');
ylabel('y');
hold on;
plot(xcoords,ycoords,'x',xcoords2,ycoords2,'o');
lgd = legend('Eqbm curve','Rectification Line','Stripping Line','x=y','steps','steps');
lgd.Location = 'northwest';
hold off;
%Part b
%choose (x,y) along the RL, get y*; evaluate 1/(y*-y) & integrate
x_above = linspace(0.10,0.8,30);
y_star_above = ppval(pp,x_above);
y_above = OL(x_above);
f_above = 1./(y_star_above-y_above);
NTU_above = trapz(y_above,f_above);
%P. reboiler conundrum-1
x_below = 0.01:0.005:0.1;
y_star_below = ppval(pp,x_below);
y_below = SL(x_below);
f_below = 1./(y_star_below-y_below);
NTU_below = trapz(y_below,f_below);
%Evaluating x,y at the tray just before the partial reboiler
y_start = ppval(pp,xB);
fun = @(x)(SL(x)-0.098);
x_start = fsolve(fun,0);
%choose (x,y) along the SL, get y*; evaluate 1/(y*-y) & integrate
x_below2 = linspace(x_start,zF,30);
y_star_below2 = ppval(pp,x_below2);
y_below2 = SL(x_below2);
f_below2 = 1./(y_star_below2-y_below2);
NTU_below2 = trapz(y_below2,f_below2);

