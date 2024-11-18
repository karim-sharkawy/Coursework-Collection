% HW4 : Q2
A = [10^(-16), 1; 1, 1;];
b = [2; 3];
n = 2;

cond_A = cond(A);
disp('Condition number of A:');
disp(cond_A);

for j = 1:n-1
    for i = j+1:n
        mult = A(i,j) / A(j,j);
        A(i,:) = A(i,:) - mult * A(j,:); % Use * for multiplication
        b(i) = b(i) - mult * b(j);       % Use * for multiplication
    end;
end

disp(b(1));
disp(b(2));

x = A\b