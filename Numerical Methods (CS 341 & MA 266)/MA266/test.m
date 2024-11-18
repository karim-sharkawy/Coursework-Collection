% Add the path to the folder containing readNPY.m
addpath('path_to_folder_containing_readNPY');

% Load .npy files using readNPY
extendable_class = readNPY('extendableMappings.npy');
nonextendable_class = readNPY('nonExtendableMappings.npy');
goodclassifier_class = readNPY('trueClassifiersGoodMORE.npy');

% Reshape and convert goodclassifier_class
reshaped_matrices = cell(1, size(goodclassifier_class, 1));

for i = 1:size(goodclassifier_class, 1)
    reshaped_matrix = reshape(goodclassifier_class(i, :), [4, 4]);
    reshaped_matrices{i} = reshaped_matrix;
end

reshaped_goodclassifier_class = cat(3, reshaped_matrices{:});
reshaped_goodclassifier_class = int32(reshaped_goodclassifier_class);

% Assign colors and labels to each set of vectors
colors = {'r', 'g', 'b', 'y'};
labels = {'Good Classifier', 'Extends', 'Doesn''t Extend', 'Farthest B'};

% Create a new figure and axis for 3D plotting
figure;
ax = axes;
hold on;

% Plot classifiers
for i = 1:25
    soa0 = reshaped_goodclassifier_class(:,:,i);
    soa0(:, end) = [];  % delete the last column bc we don't use it to graph
    scatter3(soa0(:,1), soa0(:,2), soa0(:,3), 36, colors{1}, 'filled', 'DisplayName', labels{1}, 'MarkerFaceAlpha', 0.2);
end

% Plot extendable mappings
for i = 1:25
    soa1 = extendable_class{i};
    soa1(:, end) = [];  % delete the last column bc we don't use it to graph
    scatter3(soa1(:,1), soa1(:,2), soa1(:,3), 36, colors{2}, 'filled', 'DisplayName', labels{2}, 'MarkerFaceAlpha', 0.2);
end

% Plot nonextendable mappings
for i = 1:25
    soa2 = nonextendable_class{i};
    soa2(:, end) = [];  % delete the last column bc we don't use it to graph
    scatter3(soa2(:,1), soa2(:,2), soa2(:,3), 36, colors{3}, 'filled', 'DisplayName', labels{3}, 'MarkerFaceAlpha', 0.2);
end

% Set limits for the axes
xlim([-20, 20]);
ylim([-20, 20]);
zlim([-20, 20]);

% Set labels for the axes
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');

% Set title for the plot
title('3D Vector Plot');

% Show legend
legend;

% Used for later part, might need to delete later:
% PLOT CLASSIFIER
soa = [0, 0, 0, 0, -4, -4; 0, 0, 0, -7, 1, -2; 
       0, 0, 0, -1, -1, -3; 0, 0, 0, -6, -2, -3];  % Vectors representing a "Good Classifier"
% Unpack the arrays for plotting
X = soa(:, 1);
Y = soa(:, 2);
Z = soa(:, 3);
U = soa(:, 4);
V = soa(:, 5);
W = soa(:, 6);

% Plot each set of vectors using quiver plot
quiver3(X, Y, Z, U, V, W, 'Color', colors{1}, 'DisplayName', labels{1}, 'LineWidth', 0.5);

hold off;