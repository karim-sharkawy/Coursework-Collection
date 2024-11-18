% HW4: Q7
% matrix with the values of r_i corresponding to the equations
A = [1 -1 0 0;
    -1 0 1 0;
    1 0 0 -1;
    0 0 1 -1;
    0 1 0 -1;
    1 1 1 1]; % 6 equations (rows) and 4 variables (columns)

b = [4; 9; 6; 3; 7; 20]; % the value of the equations represented in A

x = A\b;

disp('Solving for (r1, r2, r3, r4) we get:');
disp(x);

[p, rank] = sort(x, 'descend');
disp("Ranking of the Teams (from highest to lowest):")
disp(rank);