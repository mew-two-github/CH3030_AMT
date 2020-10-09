clear; close all;
kl = 2.25*10^-5;%m/s
L = 10;%Litres
wmin = (3.5-0.1)/(50*0.1^(0.32))*L;%g
w = 2*wmin;%g
ci = 3.5;%mg/L
K = 50;%q should be in mg/g, c in mg/L
a = 5;%m^2/kg
time = integral(@dtbydc,3.5,0.1);
t_inhours = time/3600;
function val = dtbydc(c)
    kl = 2.25*10^-5;%m/s
    L = 10;%Litres
    wmin = (3.5-0.1)/(50*0.1^(0.32))*L;%g
    w = 2*wmin;%g
    ci = 3.5;%mg/L
    K = 50;%q should be in mg/g, c in mg/L
    a = 5;%m^2/kg
    %units of val 
    %c is the conc in solution, second term is the ideal c in soln
    val = -1./(kl*(a*w/L).*(c-((ci-c)*L/(w*K)).^(1/0.32))); 
end