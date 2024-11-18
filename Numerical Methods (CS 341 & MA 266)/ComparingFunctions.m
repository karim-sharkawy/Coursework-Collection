f1 = @(x) -0.2232*x.^3 + 0.6051*x.^2 + 1;  % [0,1] interval
f2 = @(x) -2*x.^3 + 8.3137*x.^2 - 10.0871*x.^1 + 5.1551; % [1,2]
ftrue = @(x) x .* sin(x) + cos(x);

x_values = [0.2, 0.8, 1.4, 1.8];

% Evaluate the functions at the given x values
f1_values = f1(x_values);
f2_values = f2(x_values);
ftrue_values = ftrue(x_values);

% Compute the difference between the two functions at each x
difference1 = ftrue_values - f1_values;
difference2 = ftrue_values - f2_values;

% Optionally, display the maximum difference
fprintf('Maximum observable difference in first interval: %f\n', max(abs(difference1)));
fprintf('Maximum observable difference in second interval: %f\n', max(abs(difference2)));

