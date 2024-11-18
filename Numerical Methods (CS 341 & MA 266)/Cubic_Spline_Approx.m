% Define the function
f = @(x) x .* sin(x) + cos(x);

% Define the knots (10 points including endpoints)
x_knots = linspace(0, 1, 9);
f_values = f(x_knots);

% Compute the cubic spline
spline_coefs = spline(x_knots, f_values);

% Define a fine range of x values for plotting
x_fine = linspace(0, 1, 100);
spline_values = ppval(spline_coefs, x_fine);

% Plot the original function and the spline approximation
figure;
fplot(f, [0, 1], 'LineWidth', 1.5);
hold on;
plot(x_fine, spline_values, 'r--', 'LineWidth', 1.5);
legend('Original Function f(x)', 'Cubic Spline Approximation');
xlabel('x');
ylabel('f(x) or Spline(x)');
title('Cubic Spline Approximation of f(x) = x sin(x) + cos(x)');
grid on;
