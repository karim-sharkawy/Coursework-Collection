% HW 5: Q10a - solving the normal equations

x = linspace(-5,5,30)';
y = [25.198, 22.354, 11.286, -5.3643, -9.9406, 5.5574, 20.364, 10.826, ...
    12.018, 18.742, -4.5468, -6.2935, 11.038, -6.9372, 22.685, 10.281, ...
    -4.0523, -0.26773, 10.089, 13.64, 20.074, 13.906, 2.7136, 16.384, ...
    2.9209, 27.113, 30.377, 29.667, 22.724, 48.731]';

n = 30;
A = [ones(n, 1), x, x.^2];

c = (A' * A) \ (A' * y);

fprintf('The coefficients using normal equations are:\n');
fprintf('c1 (a_2) = %.4f\n', c(3));
fprintf('c2 (a_1)   = %.4f\n', c(2));
fprintf('c3 (a_0) = %.4f\n', c(1));

% Q10b - QR factorization

[m, n] = size(A);
Q = zeros(m, n);
R = zeros(n, n);

for j = 1:n
    v = A(:, j);
    for i = 1:j-1
        R(i, j) = Q(:, i)' * A(:, j);
        v = v - R(i, j) * Q(:, i);
    end
    R(j, j) = norm(v);
    Q(:, j) = v / R(j, j);
end

b = y;
c = R \ (Q' * b);

fprintf('The coefficients using QR decomp are:\n');
fprintf('c3 (a_2) = %.4f\n', c(3));
fprintf('c2 (a_1)   = %.4f\n', c(2));
fprintf('c1 (a_0) = %.4f\n', c(1));

% plotting (done after finding results)
x = linspace(-10, 10, 500);
y = 4.4095 + 1.7871 * x + 0.8943 * x.^2;

figure;
plot(x, y, 'b-', 'LineWidth', 1.5);
xlabel('x');
ylabel('y');
title('Plot of 4.4095 + 1.7871x + 0.8943x^2');
grid on;
