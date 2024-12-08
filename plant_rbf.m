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
sizes.NumOutputs = 8;
sizes.NumInputs = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0 = [];
str = [];
ts = [];
end

function sys = mdlOutputs(t,x,u)
x1 = u(1);
x2 = u(2);
x = [x1 x2]';
c = [-0.5 -0.25 0 0.25 0.5;
    -0.5 -0.25 0 0.25 0.5]; %cij represents coordinate value of the center point of the Gaussian function of neural net j for the ith input
b = [0.2 0.2 0.2 0.2 0.2]'; %bj represents the width value of Gaussian function of neural net j
W = ones(5,1); %weight values
h = zeros(5,1); 
for j =1:1:5
    h(j) = exp(-norm(x-c(:,j))^2/(2*b(j)*b(j))) %Gaussian neuran calculation
end
yout = W'*h; %output of the RBF

sys(1) = yout;
sys(2) = x1;
sys(3) = x2;
sys(4) = h(1);
sys(5) = h(2);
sys(6) = h(3);
sys(7) = h(4);
sys(8) = h(5);
end