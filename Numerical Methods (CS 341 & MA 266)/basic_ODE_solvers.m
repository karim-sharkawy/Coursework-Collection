% One-Step Methods
% Define the ODE: dy/dt = f(t, y)
f = @(t, y) -2 * t * y^2;  % Example ODE: dy/dt = -2 * t * y^2
t0 = 0;   % Initial time
y0 = 1;   % Initial condition
t_end = 2; % End time
h = 0.1;   % Step size

% Time vector for plotting
t = t0:h:t_end;
N = length(t);  % Number of steps

% Preallocate arrays for results
y_euler = zeros(1, N);
y_taylor = zeros(1, N);
y_midpoint = zeros(1, N);
y_heun = zeros(1, N);
y_rk4 = zeros(1, N);

% Initial condition
y_euler(1) = y0;
y_taylor(1) = y0;
y_midpoint(1) = y0;
y_heun(1) = y0;
y_rk4(1) = y0;

% 1. Euler's Method
for i = 1:N-1
    y_euler(i+1) = y_euler(i) + h * f(t(i), y_euler(i));
end

% 2. Higher-order methods based on Taylor Series (2nd order)
for i = 1:N-1
    % Taylor series expansion: y(t + h) ≈ y(t) + h * f(t, y) + (h^2 / 2) * f'(t, y)
    % Assuming the second derivative is given or computed
    df = @(t, y) -2 * (t * y^2 + y);  % f'(t, y) = d/dt [-2 * t * y^2]
    y_taylor(i+1) = y_taylor(i) + h * f(t(i), y_taylor(i)) + (h^2 / 2) * df(t(i), y_taylor(i));
end

% 3. Midpoint Method
for i = 1:N-1
    k1 = f(t(i), y_midpoint(i));
    k2 = f(t(i) + h/2, y_midpoint(i) + h*k1/2);
    y_midpoint(i+1) = y_midpoint(i) + h * k2;
end

% 4. Heun's Method (Improved Euler)
for i = 1:N-1
    k1 = f(t(i), y_heun(i));
    k2 = f(t(i) + h, y_heun(i) + h * k1);
    y_heun(i+1) = y_heun(i) + h * (k1 + k2) / 2;
end

% 5. Classical Fourth-Order Runge-Kutta Method
for i = 1:N-1
    k1 = f(t(i), y_rk4(i));
    k2 = f(t(i) + h/2, y_rk4(i) + h*k1/2);
    k3 = f(t(i) + h/2, y_rk4(i) + h*k2/2);
    k4 = f(t(i) + h, y_rk4(i) + h*k3);
    y_rk4(i+1) = y_rk4(i) + h * (k1 + 2*k2 + 2*k3 + k4) / 6;
end

% Plot the results
figure;
hold on;
plot(t, y_euler, '-o', 'DisplayName', 'Euler''s Method');
plot(t, y_taylor, '-x', 'DisplayName', 'Taylor Series (2nd order)');
plot(t, y_midpoint, '-s', 'DisplayName', 'Midpoint Method');
plot(t, y_heun, '-^', 'DisplayName', 'Heun''s Method');
plot(t, y_rk4, '-d', 'DisplayName', 'Runge-Kutta 4th order');
legend;
xlabel('Time (t)');
ylabel('Solution (y)');
title('Comparison of Numerical ODE Solvers');
grid on;
hold off;

%% Basic Multistep Methods covered in class
function ODE_Solver()
    % Define the ODE: dy/dt = f(t,y)
    f = @(t,y) -2 * t * y;  % Example: dy/dt = -2ty (this is a test ODE)
    
    % Set the initial condition
    y0 = 1; % Initial value y(0) = 1
    t0 = 0; % Initial time
    tf = 5; % Final time
    h = 0.1; % Step size
    N = (tf - t0) / h; % Number of steps

    % 1) Adams-Bashforth Method (2-step for example)
    [t_ab, y_ab] = AdamsBashforth(f, t0, y0, h, N);
    fprintf('Adams-Bashforth 2-step Method: \n');
    disp([t_ab', y_ab']);
    
    % 2) Adams-Moulton Method (3-step for example)
    [t_am, y_am] = AdamsMoulton(f, t0, y0, h, N);
    fprintf('Adams-Moulton 3-step Method: \n');
    disp([t_am', y_am']);
    
    % 3) General Linear m-step Method (Generalized version)
    [t_gl, y_gl] = GeneralLinearMethod(f, t0, y0, h, N);
    fprintf('General Linear m-step Method: \n');
    disp([t_gl', y_gl']);
end

% Adams-Bashforth Method (2-step)
function [t, y] = AdamsBashforth(f, t0, y0, h, N)
    t = t0:h:t0+N*h;  % Time vector
    y = zeros(N+1,1); % Solution vector
    y(1) = y0; % Initial condition
    y(2) = y(1) + h * f(t(1), y(1)); % Use Euler's method to start
    
    for n = 2:N
        y(n+1) = y(n) + h * (3/2 * f(t(n), y(n)) - 1/2 * f(t(n-1), y(n-1)));
    end
end

% Adams-Moulton Method (3-step)
function [t, y] = AdamsMoulton(f, t0, y0, h, N)
    t = t0:h:t0+N*h;  % Time vector
    y = zeros(N+1,1); % Solution vector
    y(1) = y0; % Initial condition
    y(2) = y(1) + h * f(t(1), y(1)); % Use Euler's method to start
    y(3) = y(2) + h * (3/2 * f(t(2), y(2)) - 1/2 * f(t(1), y(1))); % Use 2nd order method to start

    for n = 3:N
        y(n+1) = y(n) + h * (5/12 * f(t(n), y(n)) + 8/12 * f(t(n-1), y(n-1)) - 1/12 * f(t(n-2), y(n-2)));
    end
end

% General Linear m-step Method (Example implementation)
function [t, y] = GeneralLinearMethod(f, t0, y0, h, N)
    t = t0:h:t0+N*h;  % Time vector
    y = zeros(N+1,1); % Solution vector
    y(1) = y0; % Initial condition

    % Start with an explicit method (e.g., Euler or Adams-Bashforth)
    for n = 1:N
        y(n+1) = y(n) + h * f(t(n), y(n));
    end
end
