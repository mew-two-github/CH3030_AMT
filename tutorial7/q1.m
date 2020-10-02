clear;close all; clc;
c = [3.9;6.8;9.9;12;16;23;35.7;61.8;80.2];
q= [9.6;11.6;14.9;17.6;21.0;25.6;32.1;38.2;40.1];
options = statset('MaxIter',500);
[beta,R,J,COVB,MSE] = nlinfit(c,q,@Freund,[1,1]);
[beta1,R1,J1,COVB1,MSE1] = nlinfit(c,q,@Lang,[0.00001,2*10000],options);
qlang = Lang(beta1,c);
qfreund = Freund(beta,c);
plot(c,q,'x',c,qlang,c,qfreund);
title('Equilibrium Adsorption curves');
legend('Data points','Langmuir', 'Freundlich');
xlabel('c');
ylabel('q');
function y = Freund(parms,c)
    k = parms(1);
    n = parms(2);
    y = k.*(c.^(1./n));
end
function y= Lang(parms,c)
    k = parms(1);
    qm = parms(2);
    y = qm.*(k.*c./(1+k.*c));
end
