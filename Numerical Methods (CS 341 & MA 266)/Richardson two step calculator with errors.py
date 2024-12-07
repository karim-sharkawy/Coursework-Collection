import numpy as np

def f(x):
    return np.cos(x)

true_value = -0.5 #used for the errors

h_values = [0.2, 0.1, 0.05]
x = np.pi / 3

results_one_step = []
results_two_step = []

for h in h_values:
    phi_0_h = (f(x + h) - 2 * f(x) + f(x - h)) / h**2
    phi_0_h2 = (f(x + h / 2) - 2 * f(x) + f(x - h / 2)) / (h / 2)**2
    phi_0_h4 = (f(x + h / 4) - 2 * f(x) + f(x - h / 4)) / (h / 4)**2
    
    phi_1_h = (4 / 3) * phi_0_h2 - (1 / 3) * phi_0_h
    phi_1_h2 = (4 / 3) * phi_0_h4 - (1 / 3) * phi_0_h2
    phi_2_h = (16 / 15) * phi_1_h2 - (1 / 15) * phi_1_h
    
    # Errors
    error0 = abs(phi_0_h - true_value)
    error1 = abs(phi_1_h - true_value)
    error2 = abs(phi_2_h - true_value)
    
    results_one_step.append((h, phi_1_h, error1))
    results_two_step.append((h, phi_2_h, error2))

results_one_step, results_two_step

print(results_one_step)
print(results_two_step)
