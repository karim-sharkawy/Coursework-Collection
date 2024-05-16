# CS 177 – project1.py
# Karim Muhammad El-Sharkawy
# This project calculates the distance travelled and and the new velocity using intial values and formulas

import math
print("This program simulates the distance traveled by a tennis ball as it falls within Earth’s gravity over time.")

#The definition of the main function
def main():
    # Set initial values
    a = 9.81
    vi = eval(input("Please enter the initial vertical velocity (meters per second): "))
    t = eval(input("Please ente the time interval (seconds): "))

    print("{0:<8} {1:<8} {2:<8}".format("time (s)", "Position (m)", "Velocity (m/s)"))

    for i in range(t):
        d = vi*i + (1/2)*a*i**2
        vt = vi + a*i
        print("{0:<8} {1:>8} {2:>15}".format(i, round(d,2), round(vt,2)))

#Calling the main function
if __name__ == "__main__": #make sure the actual parenthesis are green.
        main()
