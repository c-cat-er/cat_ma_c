function [sys,x0,str,ts,simStateCompliance] = systemA(t,x,u,flag,pa)
    switch flag
        % Initialization
        case 0
            [sys,x0,str,ts,simStateCompliance] = mdlInitializeSizes(pa);

        % Derivatives
        case 1
            sys = mdlDerivatives(t,x,u,pa);

        % Update
        case 2
            sys = mdlUpdate(t,x,u);

        % Outputs
        case 3
            sys = mdlOutputs(t,x,u);

        % GetTimeOfNextVarHit
        case 4
            sys = mdlGetTimeOfNextVarHit(t,x,u);

        % Terminate
        case 9
            sys = mdlTerminate(t,x,u);

        % Unexpected flags
        otherwise
            error(['Unhandled flag = ',num2str(flag)]);
    end
end

% Model initialization
function [sys,x0,str,ts,simStateCompliance] = mdlInitializeSizes(pa)
    sizes = simsizes;
    sizes.NumContStates  = 5;
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 5;
    sizes.NumInputs      = 1;
    sizes.DirFeedthrough = 1;
    sizes.NumSampleTimes = 1;
    
    sys = simsizes(sizes);
    x0  = pa.x0; % Initial state
    str = [];
    ts  = [0 0];
    simStateCompliance = 'DefaultSimState';
end

% Calculate derivatives
function sys = mdlDerivatives(t,x,u,pa)
    V = x(1);
    gamma = x(2);
    h = x(3);
    alpha = x(4);
    q = x(5);
    delta_e = u;

    D = 0.5 * pa.rho * V^2 * pa.S * CD(alpha);
    r = h + pa.RE;
    Myy = 0.5 * pa.rho * V^2 * pa.S * pa.c * (CMalpha(alpha) + CMdeltaE(pa.ce, alpha, delta_e) + CMq(q, pa.c, alpha, V));
    L = 0.5 * pa.rho * V^2 * pa.S * CL(alpha);
    T = 0.5 * pa.rho * V^2 * pa.S * CT(pa.delta_T);

    dx1 = (T * cos(alpha) - D) / pa.m - pa.mu * sin(gamma) / (r^2);
    dx2 = (L * sin(alpha) / (pa.m * V)) - (pa.mu * V * cos(gamma)) / (V^2 * r);
    dx3 = V * sin(gamma);
    dx4 = q - dx2;
    dx5 = Myy / pa.Jyy;

    sys = [dx1; dx2; dx3; dx4; dx5];
end

function y = CMalpha(alpha)
    y = -0.035 * alpha^2 - 0.036617 * alpha + 5.3261e-6;
end

function y = CMq(q, c, alpha, V)
    y = c / (2 * V) * q * (-6.796 * alpha^2 + 0.3015 * alpha - 0.2289);
end

function y = CMdeltaE(ce, alpha, delta_e)
    y = ce * (delta_e - alpha);
end

function y = CL(alpha)
    y = 0.6203 * alpha;
end

function y = CD(alpha)
    y = 0.645 * alpha^2 + 0.0043378 * alpha + 0.003772;
end

function y = CT(delta_T)
    if delta_T < 1
        y = 0.02576 * delta_T;
    else
        y = 0.0224 + 0.00336 * delta_T;
    end
end

% Update function
function sys = mdlUpdate(t,x,u)
    sys = [];
end

% Calculate outputs
function sys = mdlOutputs(t,x,u)
    sys = x; % Output equals input
end

% Terminate function
function sys = mdlTerminate(t,x,u)
    sys = [];
end