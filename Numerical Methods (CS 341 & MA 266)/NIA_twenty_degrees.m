% HW 5: Q8
format shortg % to display very small numbers

n = 20;
x = -5 + (0:n)*(1/2); % 21 equally spaced x_i points
y = 2*sin(x) + cos(3*x); % Calculating y_i for every x_i

function divided_diff = difference_matrix(x, y)
    n = length(x);
    divided_diff = zeros(n, n); % Initialize table
    divided_diff(:, 1) = y(:);  % setting the ith row of the first column to y_i

    % Calculate divided differences
    for j = 2:n % for each column 
        for i = j:n %for each row of that column
            divided_diff(i, j) = (divided_diff(i, j-1) - divided_diff(i-1, j-1)) / (x(i) - x(i-j+1));
        end % compute the divided difference
    end
end
divided_diff = difference_matrix(x, y); %the divided difference table

polynomial_coefficients = diag(divided_diff); %getting the diagonal entries

fprintf('Polynomial coefficients: ');
fprintf('%g \n', polynomial_coefficients);

% Construct the Newton polynomial using symbolic variable X
syms X;
n = length(polynomial_coefficients);
newton_polynomial = polynomial_coefficients(1);

for i = 1:n
    term = polynomial_coefficients(i);
    for j = 1:i-1
        term = term * (X - x(j));
    end
    newton_polynomial = newton_polynomial + term;
end

% Display the polynomial if you want!
%disp('Newton Polynomial:');
%simplify(vpa(newton_polynomial)) % Using vpa to maintain decimal form

% plotting
x_plot = linspace(min(x), max(x), 500);
y_plot = double(subs(newton_polynomial, X, x_plot));

figure;
plot(x_plot, y_plot, 'b-', 'LineWidth', 1.5);
xlabel('x');
ylabel('y');
title('Newton Interpolating Polynomial of degree 20');
legend('Interpolating Polynomial');
grid on;