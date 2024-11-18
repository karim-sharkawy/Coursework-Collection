% HW1: Q6
p = 0.7; % Probability of getting heads

results = zeros(1, 1000);

for i = 1:1000
    randVal = rand; % Generate a random number between 0 and 1 for each toss
    
    if randVal < p
        results(i) = 1; % heads
    else
        results(i) = 0; % tails
    end
end

count_Heads = sum(results == 1);
count_Tails = sum(results == 0);


%% PART 1: PLOTTING BAR GRAPH
figure;
bar([count_Heads, count_Tails]);
set(gca, 'XTickLabel', {'Heads', 'Tails'}); xlabel('Outcome'); ylabel('Count');
title('Number of Heads and Tails using a biased coin');

%% PART 2: CALCULATING E[X] & VAR
expectation_of_x = 0.7*(count_Heads) + 0.3*(count_Tails)

expectation_of_x_squared = 0.7*(count_Heads^2) + 0.3*(count_Tails^2);

Variance_of_x = expectation_of_x_squared - (expectation_of_x)^2

%% PART 3: REPEATING 100 TIMES
num_of_simulations = 100;
proportions = zeros(1, num_of_simulations); 

for j = 1:num_of_simulations
    for i = 1:1000
        randVal = rand;
        if randVal < p
            results(i) = 1;
        else
            results(i) = 0;
        end
    end
    proportions(j) = sum(results == 1) / 1000;
end

figure;
histogram(proportions, 10);
xlabel('Proportion of Heads (100s)');
ylabel('Frequency');
title('Histogram of Proportions of Heads over 100 Simulations');


%% PART 4: E[X], VAR, & SD OF THE PROPORTION OF HEADS FROM 3

expectation_of_100_sims = (0.7*(count_Heads) + 0.3*(count_Tails)) / 100

Variance_of_100_sims = expectation_of_x_squared - (expectation_of_x)^2 / 100

standarad_deviation_of_100_sims = (Variance_of_100_sims)^0.5