% Define the function and interval points
f = @(x) x.^4 + 2*x.^2;
x_points = [0, 1, 2, 3];
f_values = f(x_points);
n = 3;
h = 1;

% Define alpha and beta
alpha = 2 * h / 3;
beta = h / 6;

% Compute the b vector based on the equations provided
b = zeros(n-1, 1);
for i = 2:n
    if i == 2
        b(i-1) = (1/h(i-1)) * (f_values(i+1) - 2*f_values(i) + f_values(i-1)) - (h(i-1)/6) * 0; % z0 = 0 for natural spline
    elseif i == n
        b(i-1) = (1/h(i-1)) * (f_values(i+1) - 2*f_values(i) + f_values(i-1)) - (h(i-1)/6) * 0; % zn = 0 for natural spline
    else
        b(i-1) = (1/h(i-1)) * (f_values(i+1) - 2*f_values(i) + f_values(i-1));
    end
end

% Construct the tridiagonal matrix A
A = diag(alpha * ones(n-1, 1)) + diag(beta(1:end-1), 1) + diag(beta(1:end-1), -1);

% Solve for z (second derivatives at the knots)
z = A \ b;

% Add natural spline boundary conditions for z0 and zn
z = [0; z; 0];

% Define a fine range of x values for plotting
x_fine = linspace(0, 3, 100);
spline_values = zeros(size(x_fine));

% Compute each spline segment si(x) and evaluate over the fine range
for i = 1:n
    x_i = x_points(i);
    x_i_plus_1 = x_points(i+1);
    
    % Define the coefficients for si(x)
    idx = (x_fine >= x_i) & (x_fine <= x_i_plus_1);
    x = x_fine(idx);
    
    % Evaluate the spline function si(x) based on the provided formula
    spline_values(idx) = (1/h(i)) * z(i) * (x_i_plus_1 - x).^3 / 6 + ...
                         (1/h(i)) * z(i+1) * (x - x_i).^3 / 6 + ...
                         (f_values(i) / h(i) - z(i) * h(i) / 6) * (x_i_plus_1 - x) + ...
                         (f_values(i+1) / h(i) - z(i+1) * h(i) / 6) * (x - x_i);
end

% Plot the original function and the spline interpolation
figure;
fplot(f, [0, 3], 'LineWidth', 1.5);
hold on;
plot(x_fine, spline_values, 'r', 'LineWidth', 1.5);
legend('Original Function f(x)', 'Natural Cubic Spline Interpolation');
xlabel('x');
ylabel('f(x) or Spline(x)');
title('Natural Cubic Spline Interpolation of f(x) = x^4 + 2x^2');
grid on;