% Symbolic differentiation
syms x

% Function definition (example: f(x) = exp(2^x))
f = exp(2^x);

% Number of derivatives to compute
num_derivatives = 8;
derivatives = cell(1, num_derivatives);

% Compute derivatives and store them in a cell array
current_derivative = f;
for i = 1:num_derivatives
    current_derivative = diff(current_derivative, x);
    derivatives{i} = current_derivative;
    disp([num2str(i), 'th derivative: ', char(current_derivative)]);
end


% Secant Method Calculator
% Function definition for f(x) = x^3 - 5*x - 4
f_secant = @(x) x^3 - 5*x - 4;

% Function to compute x_(k+1) using the secant method
secant_method = @(x_k, x_k_minus_1, f) x_k - (f(x_k) * (x_k - x_k_minus_1)) / (f(x_k) - f(x_k_minus_1));

% Input values from the user (in MATLAB, using input() for user input)
x_k = input('Enter the value of x_k: ');
x_k_minus_1 = input('Enter the value of x_(k-1): ');

% Calculate x_(k+1) using the secant method
x_k_plus_1 = secant_method(x_k, x_k_minus_1, f_secant);
disp(['The value of x_(k+1) is: ', num2str(x_k_plus_1)]);


% Newton's Method Calculator
% Function definition for f(x) = x^3 - 5*x - 4 and its derivative
f_newton = @(x) x^3 - 5*x - 4;
f_prime_newton = @(x) 3*x^2 - 5;

% Newton's Method Implementation
function root = newtons_method(x_k, tolerance, max_iterations)
    if nargin < 2
        tolerance = 1e-7;  % Default tolerance
    end
    if nargin < 3
        max_iterations = 10;  % Default max iterations
    end
    for iteration = 1:max_iterations
        f_x_k = f_newton(x_k);
        f_prime_x_k = f_prime_newton(x_k);

        if f_prime_x_k == 0
            disp('Derivative is zero. No solution found.');
            root = NaN;
            return;
        end

        x_k_plus_1 = x_k - f_x_k / f_prime_x_k;

        % Displaying the current iteration results
        disp(['Iteration ', num2str(iteration), ': x_k = ', num2str(x_k), ', x_k+1 = ', num2str(x_k_plus_1), ', f(x_k) = ', num2str(f_x_k)]);

        if abs(x_k_plus_1 - x_k) < tolerance
            disp('Convergence reached.');
            root = x_k_plus_1;
            return;
        end

        x_k = x_k_plus_1;
    end

    disp('Maximum iterations reached.');
    root = x_k;
end

% Example usage for Newton's method
initial_guess = 4;
root = newtons_method(initial_guess);
if ~isnan(root)
    disp(['The root found is: ', num2str(root)]);
end


% Taylor Expansion Calculator (Symbolic expansion)
% Function definition for Taylor series expansion
syms x

% Example function: f(x) = sin(x)
f_taylor = sin(x);

% Function to compute Taylor expansion up to a specified order
taylor_expansion = taylor(f_taylor, x, 'Order', 9);  % 'Order' is 9 to include the 8th derivative
disp('Taylor Expansion of sin(x) around x = 0:');
disp(taylor_expansion);
