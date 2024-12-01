%% 1. First Order Linear Differential Equations
% Example: dy/dx + p(x)y = q(x)
% General solution approach using the integrating factor method

clc;
clear;

% Define the functions p(x) and q(x)
syms y(x) x p(x) q(x);

% Example functions p(x) = 1/x and q(x) = x^2
p(x) = 1/x;
q(x) = x^2;

% First-order linear ODE: dy/dx + p(x)y = q(x)
ode1 = diff(y, x) + p(x)*y == q(x);

% Solve the ODE using the dsolve function symbolically
sol1 = dsolve(ode1);
disp('Solution to the first-order equation:');
disp(sol1);

% Plot the solution for a specific range (numerical plot)
f1 = matlabFunction(sol1); % Convert symbolic solution to a function
fplot(f1, [0.1, 5]);
title('First Order ODE Solution');
xlabel('x');
ylabel('y(x)');
grid on;

%% 2. Second and nth Order Linear Differential Equations
% Example: y'' + p(x)y' + q(x)y = r(x), generalize to nth order
% Solve a second-order linear ODE

% Example: y'' + y' - 2y = 0
syms y(x);
ode2 = diff(y, x, 2) + diff(y, x) - 2*y == 0;

% Solve the ODE symbolically
sol2 = dsolve(ode2);
disp('Solution to the second-order equation:');
disp(sol2);

% Plot the solution for a specific range (numerical plot)
f2 = matlabFunction(sol2); % Convert symbolic solution to a function
fplot(f2, [0, 10]);
title('Second Order ODE Solution');
xlabel('x');
ylabel('y(x)');
grid on;

% For nth order, solve the equation y^(n) + ... = 0
n = 3; % nth order
ode_n = diff(y, x, n) + 4*diff(y, x, n-1) == 0;
sol_n = dsolve(ode_n);
disp(['Solution to the ' num2str(n) '-th order equation:']);
disp(sol_n);

%% 3. Series Solutions
% Solving the ODE using a power series expansion
% Example: y'' + y = 0 around x=0

syms x y(x);
ode_series = diff(y, x, 2) + y == 0;

% Assume the solution as a power series
y_series = taylor(ode_series, 'Order', 10); % Expand to 10th order

disp('Series solution around x=0:');
disp(y_series);

% Plot the series solution
f3 = matlabFunction(y_series); % Convert symbolic series to a function
fplot(f3, [-1, 1]);
title('Series Solution (y'' + y = 0)');
xlabel('x');
ylabel('y(x)');
grid on;

%% 4. Solution by Laplace Transform
% Solve an ODE using the Laplace transform
% Example: y'' + y = 0 with initial conditions y(0)=0 and y'(0)=1

syms t s Y;
% Laplace transform of y'' + y = 0
laplace_ode = laplace(diff(y, t, 2) + y, t, s);

% Substitute initial conditions Y(s) = L{y}(s)
L = laplace(y, t, s);
Y_s = solve(laplace_ode == 0, L);

% Inverse Laplace to get back to the time domain solution
y_laplace = ilaplace(Y_s, s, t);
disp('Solution using Laplace transform:');
disp(y_laplace);

% Plot the solution of the Laplace-transformed ODE
f4 = matlabFunction(y_laplace); % Convert symbolic solution to a function
fplot(f4, [0, 10]);
title('Solution by Laplace Transform');
xlabel('t');
ylabel('y(t)');
grid on;

%% 5. Systems of Linear Equations
% Solve a system of linear equations

% Define the system as A*x = b
A = [2, 1; -1, 3];
b = [5; 7];

% Solve the system using matrix division
x = A\b;

disp('Solution to the system of linear equations:');
disp(x);
