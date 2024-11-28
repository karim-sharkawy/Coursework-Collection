% HW7: Q6a: creating orthogonal bases using GS process
disp('a:');
syms x;
basis = [1, x, x^2, x^3];  % Original basis
n = length(basis);

% The GS process
orth_basis = sym(zeros(1, n));
for i = 1:n
    v = basis(i);
    for j = 1:i-1
        % projection of v onto the previous basis
        proj = (int(orth_basis(j) * v, -1, 1) / int(orth_basis(j)^2, -1, 1)) * orth_basis(j);
        v = v - proj; % updating v
    end
    orth_basis(i) = simplify(v / sqrt(int(v^2, -1, 1))); % normalize
end

disp('Orthonormal basis:');
disp(orth_basis);

% b: Gauss Quadrature
disp('b:');
% Find the 3rd-degree polynomial in the orthogonal basis
P3 = orth_basis(4);
coeffs_P3 = fliplr(coeffs(P3, x));
roots_P3 = double(roots(coeffs_P3));  % Roots of the polynomial

% Weights for the Gauss Quadrature
weights = zeros(size(roots_P3));
for i = 1:length(roots_P3)
    li = 1;
    for j = 1:length(roots_P3)
        if i ~= j
            li = li * (x - roots_P3(j)) / (roots_P3(i) - roots_P3(j));
        end
    end
    weights(i) = double(int(li, x, -1, 1));
end

disp('Gauss Quadrature Points:');
disp(roots_P3);
disp('Weights:');
disp(weights);

% c: Degree of Exactness
disp('c:');
largest_degree = 2 * length(roots_P3) - 1;
disp('largest degree polynomial for which this formula is exact:');
disp(largest_degree);

% d: Approximation of Integral
disp('d:');
f = cos(x); 
f_vals = subs(f, x, roots_P3);  % Evaluate f at Gauss points
approx_integral = dot(weights, f_vals);
disp('Integral approximation of cos(x) from [0, 1]: ');
disp(num2str(actual_integral, '%.9f'));

% Compute the actual integral for comparison
actual_integral = double(int(f, 0, 1));
disp('True integral of cos(x):');
disp(actual_integral);