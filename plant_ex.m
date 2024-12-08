function [sys, x0, str, ts] = s_function(t,x,u,flag)
switch flag
    case 0
        [sys , x0, str, ts] = mdlInitializeSizes;
    case 1
        sys = mdlDerivatives(t,x,u); % Correct function for derivatives
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
sizes.NumContStates = 2;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 1;
sizes.NumInputs = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0 = [0, 0];
str = [];
ts = [];
end

function sys = mdlDerivatives(t,x,u)
sys(1) = x(2);
sys(2) = -25 * x(2) + 133 * u; % Define derivatives
end

function sys = mdlOutputs(t,x,u)
sys(1) = x(1); % Output is the first state
end