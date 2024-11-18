% HW6: Q6
% Define the function
f = @(x) x .* sin(x) + cos(x);

% Given points and function values
x_points = [1.4, 1.5, 1.6];
f_values = f(x_points);

% Fit a quadratic polynomial to the points
p = polyfit(x_points, f_values, 2);

% Polynomial coefficients
a = p(1);
b = p(2);
c = p(3);

% Derivative of the polynomial at x = 1.5
x0 = 1.5;
g_prime_at_1_5 = 2 * a * x0 + b;

% Analytical derivative of f(x) at x = 1.5
f_prime_exact = x0 * cos(x0);

% Observed error
observed_error = abs(g_prime_at_1_5 - f_prime_exact);

% Display results
disp('Quadratic Polynomial Coefficients:');
disp(['a = ', num2str(a), ', b = ', num2str(b), ', c = ', num2str(c)]);
disp(['Estimated derivative g''(1.5) = ', num2str(g_prime_at_1_5)]);
disp(['Exact derivative f''(1.5) = ', num2str(f_prime_exact)]);
disp(['Observed error = ', num2str(observed_error)]);
