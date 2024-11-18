% HW6: Q2
f = @(x) x.^4 + 2*x.^2;

x_points = [0, 1, 2, 3];
f_values = f(x_points);

spline_coefs = spline(x_points, [0 f_values 0]);
x_fine = linspace(0, 3, 100);
spline_values = ppval(spline_coefs, x_fine);

figure;
fplot(f, [0, 3], 'LineWidth', 1.5);
hold on;
plot(x_fine, spline_values, 'r', 'LineWidth', 1.5);
legend('Original', 'Spline Interpolation');
xlabel('x');
ylabel('f(x) or Spline(x)');
title('Spline Interpolation of x^4 + 2x^2');
grid on;