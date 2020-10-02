clear; close all;
kl = 2.25*10^-3;
wmin = (3.5-0.1)/(50*0.1^(0.32));
w = 2*wmin;
ci = 3.5;%mg/L
time = integral(@dtbydc,3.5,0.1);
function val = dtbydc(c)
    kl = 2.25*10^-5;%m/s
    wmin = (3.5-0.1)/(50*0.1^(0.32));%g
    w = 2*wmin;%g
    ci = 3.5;%mg/L
    K = 50;%q should be in mg/g, c in mg/L
    a = 5;%m^2/kg
    L = 10;%Litres
    %units of val 
    val = -1./(kl*a.*(c-((ci-c)/(w*K*L)).^(1/0.32)));
end