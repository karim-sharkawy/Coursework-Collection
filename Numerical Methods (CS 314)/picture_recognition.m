% HW4: Q8
load('mnist_all.mat');

digit = train0(1,:); 
digitImage = reshape(digit,28,28);
image(rot90(flipud(digitImage),-1)),
colormap(gray(256)), axis square tight off;

% Part a
T = zeros(10, 784);

% Compute the average pixel values for each digit using a for loop
for i = 0:9
    T(i + 1, :) = mean(eval(['train' num2str(i)]), 1); % For digit 'i'
end

% Plotting average digit images
figure;
for i = 1:10
    digitImage = reshape(T(i, :), 28, 28); % Reshape from T matrix
    subplot(2, 5, i);
    image(rot90(flipud(digitImage), -1)); % Rotate and flip the image
    colormap(gray(256)), axis square tight off;
    title(['Digit ' num2str(i-1)]);
end


%%
% part b

test_digits = [test0(1,:); test1(1,:); test2(1,:); test3(1,:); test4(1,:)];
digits = zeros(1, 5);

test_digits = double(test_digits);

for j = 1:5
    d = test_digits(j, :);
    distances = zeros(1, 10);
    
    for i = 1:10
        distances(i) = norm(T(i, :) - d);
    end
    
    [~, digits(j)] = min(distances);
    digits(j) = digits(j) - 1;
end

disp('Digits:');
disp(predicted);

figure;
for j = 1:5
    subplot(1, 5, j);
    digitImage = reshape(test_digits(j,:), 28, 28)';
    imagesc(digitImage);
    colormap(gray(256));
    axis square tight off;
    title(['Digit: ' num2str(digits(j))]);
end
