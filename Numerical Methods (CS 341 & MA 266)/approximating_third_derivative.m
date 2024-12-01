% HW7: Q7b - approximating f''' using the second-order formula from a)

function result = centralDifference(f, x0, h) % this is what i approximated in a)
    result = (-f(x0 + 2*h) + 2*f(x0 + h) - 2*f(x0 - h) + f(x0 - 2*h)) / (2*h^3);
end

% main variables
f = @(x) sin(x); % the function
f_third_true = @(x) cos(x); % true f'''
x0 = pi;
h_values = 10.^(-1:-1:-9); % step sizes

% Using approx function for each h
approximations = arrayfun(@(h) centralDifference(f, x0, h), h_values);
errors = abs(approximations - f_third_true(x0));

% results
disp('   h value       Approximation     Error');

for i = 1:length(h_values)
    fprintf('%e   %12.8f   %12.8e\n', h_values(i), approximations(i), errors(i));
end

% Find the h that gives the closest approximation
[~, best_index] = min(errors);
best_h = h_values(best_index);
best_approximation = approximations(best_index);

fprintf('\nThe best h is %e, giving an approximation of f''(pi) = %.8f\n', ...
    best_h, best_approximation);

% Plot the error vs. step size
figure;
loglog(h_values, errors, '-o');
xlabel('Step size h');
ylabel('Absolute Error');
title('Error vs. Step Size');
grid on;
