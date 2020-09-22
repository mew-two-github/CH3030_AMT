close all; clear;
%Given data
x = [0 0.0417 0.0891 0.146 0.207 0.281 0.37 0.477 0.61 0.779 1];
HL = [7540 7125 6880 6915 7097 7397 7750 8105 8471 8945 9523];
HV = [48150 48250 48300 48328 48436 48450 48450 48631 48694 48950];
%composition in terms of mole fractions
xD = 0.7416;
xB = 0.016;
xF = 0.1436;
%Flow rates
F = 227.05;
D = 227.05*(xB-xF)/(xB-xD);
B = F-D;
%Enthalpy-Concentration curves(linear regression)
hlcurve = polyfit(x,HL,1);
hvcurve = polyfit(x(1:length(HV)),HV,1);
%Enthalpy-Concentration curves(splines)
hv_spline = spline(x(1:10),HV);
hl_spline = spline(x,HL);
Hv1 = spline(x(1:10),HV,xD);
Hlo = spline(x,HL,xD);%Since total condenser, same comp as incoming v1
%Using the reflux ratio to get HD'
Hd = 2*Hv1-Hlo;%NOTE: This is Hd'
Hf = 4790;
%Determining Hb by extrapolating teh Hd-Hf line
Hb = Hf + (xB-xF)*(Hd-Hf)/(xD-xF);%NOTE: This is Hb'
a = linspace(0,1,10);
plot(a,polyval(hvcurve,a),a,polyval(hlcurve,a),xB,Hb,'rx',xF,Hf,'r+',xD,Hd,'ro');
%Eqbm data
xeqbm = [0 0.00792 0.016 0.0202 0.0417 0.0891 0.1436 0.281 0.37 0.477 0.61 0.641 0.706 0.779 0.86 0.904 0.95 1];
yeqbm = [0 0.0850 0.1585 0.191 0.304 0.427 0.493 0.568 0.603 0.644 0.703 0.72 0.756 0.802 0.864 0.902 0.9456 1];
pp = spline(yeqbm,xeqbm);
%Rectification line
m = linspace((Hd-Hf)/(xD-xF),(Hd-Hf)/(xD-xF)*10,10);
fnrl = @(x)(m.*(x-xD)+Hd - polyval(hlcurve,x));
fnrl2 = @(y)(m.*(y-xD)+Hd - polyval(hvcurve,y));
x_RL = fsolve(fnrl,zeros(1,10));
y_RL = fsolve(fnrl2,zeros(1,10));
RL_eqn = polyfit(x_RL,y_RL,1);
RL = @(x)(polyval(RL_eqn,x));
%Stripping line
m = linspace((Hb-Hf)/(xB-xF),(Hb-Hf)/(xB-xF)*10,10);
fnol = @(x)(m.*(x-xB)+Hb - ppval(hl_spline,x));
fnol2 = @(y)(m.*(y-xB)+Hb-ppval(hv_spline,y));
x_SL = fsolve(fnol,zeros(1,10));
y_SL = fsolve(fnol2,zeros(1,10));
SL_eqn = polyfit(x_SL,y_SL,1);
SL = @(x)(polyval(SL_eqn,x));
xcoords = linspace(0,1,10);
figure();
plot(xcoords,RL(xcoords),xcoords(1:3),SL(xcoords(1:3)),xeqbm,yeqbm);
%Stepping process
i = 0;
y_c = xD;
x_intersection = fsolve(@(x)(SL(x)-RL(x)),0);
y_inters = RL(x_intersection);
x_c = 0;
xcoords = zeros(1,7);
ycoords = zeros(1,7);
xcoords2 = zeros(1,8);
ycoords2 = zeros(1,8);
xcoords2(1)= xD;
ycoords2(1) = xD;
while y_c >= xB
    i=i+1;
    x_c = ppval(pp,y_c);
    xcoords(i) = x_c;
    xcoords2(i+1) = x_c;
    ycoords(i)=y_c;
    if x_c >= x_intersection
        y_c = RL(x_c);
    else
        y_c = SL(x_c);
    end
    ycoords2(i+1) = y_c;
end
figure();
plot(xeqbm,yeqbm,x(1:6),SL(x(1:6)),xcoords2,RL(xcoords2),xcoords,ycoords,'x',xcoords2,ycoords2,'o');
%Actual Enthalpy calculation
Hda = spline(x,HL,xD);
Hba = spline(x,HL,xB);
%Flow rate calculations
D = F*(xF-xB)/(xD-xB);
B = F - D;
%Heat duties
Qc = D*(Hd-Hda);
QB = Qc + D*Hda+B*Hba-F*Hf;
