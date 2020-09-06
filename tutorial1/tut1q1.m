clear; close all;
X = [0.061571125 0.063829787 0.066098081 0.068376068 0.070663812 0.072961373 0.075268817 ];
Y = [0.006178288 0.014234875 0.032842582 0.065420561 0.121357433 0.204755614 0.341176471 ];
xl = 0.065:0.001:0.075;
yl = 0.1765.*ones(1,11);
xlol = linspace(0.06157,0.0722,10);
X_atminL = spline(Y,X,0.1765);
%determining number of trays
i = 0;
y = 0.02;
xcoords = zeros(1,4);
ycoords = zeros(1,4);
ycoords2 = ycoords;
while y <= 0.1765
    i = i + 1;
    x = spline(Y,X,y);
    xcoords(i) = x;
    ycoords(i) = y;
    y = 0.01765 + 1.2*14.722*(x-0.06157);
    ycoords2(i) = y;
end
xcoords(4)=0.06157;
ycoords(4) = 0.02;
plot(X,Y,xlol,0.01765 + 1.2*14.722.*(xlol-0.06157),xcoords,ycoords,'x',xcoords,ycoords2,'o');
a = [0.058
0.06
0.062
0.064
0.066
0.068
0.07
];
b = [0.006140351
0.014035088
0.031798246
0.061403509
0.108223684
0.16995614
0.254385965
];
figure();
plot(a,b);