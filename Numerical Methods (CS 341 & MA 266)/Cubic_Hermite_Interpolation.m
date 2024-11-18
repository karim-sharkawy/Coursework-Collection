% HW6: Q1
% Define the function and its derivative
f = @(x) x.^4 + 2*x.^2;
f_prime = @(x) 4*x.^3 + 4*x;

% Define the interval endpoints
x_points = [0, 1, 2, 3];
f_values = f(x_points);
f_prime_values = f_prime(x_points);

% Initialize empty array to store interpolated curves
x_all = [];
p_all = [];

% Loop through each interval
for i = 2:length(x_points)
    x_i_minus_1 = x_points(i-1);
    x_i = x_points(i);
    h = x_i - x_i_minus_1;
    
    % Calculate alpha
    alpha = (3 / h^2) * (f_prime_values(i-1) + f_prime_values(i)) + ...
            (6 / h^3) * (f_values(i-1) - f_values(i));
    
    % Generate points within the current interval
    x_interval = linspace(x_i_minus_1, x_i, 100);
    
    % Apply the Cubic Hermite Interpolation formula
    p_x = -f_prime_values(i-1) / h .* ((x_interval - x_i).^2 / 2 - h^2 / 2) + ...
          f_prime_values(i) / h .* ((x_interval - x_i_minus_1).^2 / 2) + ...
          alpha * (x_interval - x_i_minus_1).^2 .* ((x_interval - x_i) / 3 - h / 2) + ...
          f_values(i-1);
      
    % Append to the arrays for plotting
    x_all = [x_all, x_interval];
    p_all = [p_all, p_x];
end

% Plot the original function and interpolated curves
figure;
fplot(f, [0, 3], 'LineWidth', 1.5);
hold on;
plot(x_all, p_all, 'r', 'LineWidth', 1.5);
legend('Original', 'Interpolation');
xlabel('x');
ylabel('f(x) or p(x)');
title('Cubic Hermite Interpolation of x^4 + 2x^2');
grid on;
