function [sys, x0, str, ts] = s_function(t,x,u,flag)
switch flag
    case 0
        [sys , x0, str, ts] = mdlInitializeSizes;
    case 3
        sys = mdlOutputs(t,x,u); % Outputs computation
    case {2,4,9}
        sys = []; % These cases don't require specific handling
    otherwise
        error(['Unhandled flag = ', num2str(flag)])
end
end

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates = 0;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 1;
sizes.NumInputs = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0 = [];
str = [];
ts = [];
end

function sys = mdlOutputs(t,x,u)
persistent w w_1 w_2 b ci
alpha = 0.05;
eta = 0.5;

if t==0
   b = 1.5;
   ci = [-1 -0.5 0 0.5 1;
         -10 -5 0 5 10];
   w = rands(5,1);
   w_1 = w; w_2 = w_1;
end

ut = u(1);
yout = u(2);
xi = [ut yout]';
for j=1:1:5
    h(j) = exp(-norm(xi-ci(:,j))^2/(2*b^2));
end

yout = w'*h;
d_w = 0*w;
for j=1:1:5
    d_w(j) = eta*(you-ymout)*h(j);
end
w = w_1 + d_w + alpha(w_1 - w_2);
w_2 = w_1; w_1 = w;
sys(1) = ymout;

end