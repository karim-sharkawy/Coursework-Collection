function dxdt = ode(t,x)

eps = 0;
% omega = 0.5;

% + cos(omega * t)
% Whaddup


dxdt1 = x(2);
dxdt2 = -x(1) - eps * x(1).^3; %This is x2 prime

dxdt = [dxdt1; dxdt2]; % Final x prime vector
end


