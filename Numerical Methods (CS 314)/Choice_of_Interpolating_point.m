% HW 5: Q9a - equi-spaced points
format shortg % to display very small numbers

n = 4;
x = -1 + (0:n)*(1/2);
y = sin(x);

function divided_diff = difference_matrix(x, y)
    n = length(x);
    divided_diff = zeros(n, n);
    divided_diff(:, 1) = y(:);

    for j = 2:n
        for i = j:n 
            divided_diff(i, j) = (divided_diff(i, j-1) - divided_diff(i-1, j-1)) / (x(i) - x(i-j+1));
        end 
    end
end
divided_diff = difference_matrix(x, y);

polynomial_coefficients = diag(divided_diff);

fprintf('Polynomial coefficients using equi-spaced points: ');
fprintf('%g \n', polynomial_coefficients);

% Construct the Newton polynomial using symbolic variable X
syms X;
n = length(polynomial_coefficients);
newton_polynomial = polynomial_coefficients(1);

% plotting
x_plot = linspace(min(x), max(x), 500);
y_plot = double(subs(newton_polynomial, X, x_plot));

figure;
plot(x_plot, y_plot, 'b-', 'LineWidth', 1.5);
xlabel('x');
ylabel('y');
title('Polynomial using equi-spaced points');
grid on;

%% Q9b - Now using Chebyshev points

x = cos(pi*(0:n)/n); % Chebyshev points
y = sin(x);

% essentially the same as 9a
divided_diff = difference_matrix(x, y);

polynomial_coefficients = diag(divided_diff);

fprintf('Polynomial coefficients using Chebyshev points: ');
fprintf('%g \n', polynomial_coefficients);

% plotting
x_plot = linspace(min(x), max(x), 500);
y_plot = double(subs(newton_polynomial, X, x_plot));

figure;
plot(x_plot, y_plot, 'r-', 'LineWidth', 1.5);
xlabel('x');
ylabel('y');
title('Polynomial using cheb points');
grid on;
%% Q9d - plotting errors
% Note: use this code in tandem with 9a and 9b code!

f = @(x) sin(x);

%finding the max interpolation error
function error_max = max_interpolation_error(nodes_x)
    m = length(nodes_x) - 1;
    syms x;

    product_expr = 1;
    for i = 1:length(nodes_x)
        product_expr = product_expr * (x - nodes_x(i));
    end

    x_points = linspace(-1, 1, 1000);
    abs_product_vals = double(subs(abs(product_expr), x, x_points));
    max_val_product = max(abs_product_vals);

    error_max = max_val_product / factorial(m + 1);
end

range_vals = 3:7; % the range of degrees we want to test
error_set_1 = zeros(1, length(range_vals));
error_set_2 = zeros(1, length(range_vals));

for idx = 1:length(range_vals)
    n = range_vals(idx); 
    
    nodes_equal = 2^n / factorial(n + 1);
    error_set_1(idx) = max_interpolation_error(nodes_equal);
    nodes_chebyshev = 1 / 2^n;
    error_set_2(idx) = max_interpolation_error(nodes_chebyshev);
end

figure;
plot(range_vals, error_set_1, '-o', 'LineWidth', 1.5);
hold on;
plot(range_vals, error_set_2, '-o', 'LineWidth', 1.5);
xlabel('Polynomial Degree (n)');
ylabel('Max Error');
legend('Equi-spaced points', 'Chebyshev points');
title('Max interpolation error: Equi-Spaced vs Chebyshev Points');
grid on;
