# CS 177 – lab03.py
# Karim Muhammad El-Sharkawy
# This program uses a log function and allows us to approximate it using a similar function

import math
def main():
    # Prompt the user for a few values
    x = eval(input("Please enter the number whose logarithm you want to be computed: "))
    n = eval(input("Please enter how many terms of the series expansion for logarithm you want to use: "))
    total = 0
    difference = 0


    for i in range(1, n+1):
        total = total + (-1)**(i-1)*(((x-1)**i)/i)
    p = math.log(x)
    difference = abs(p- total)
    total = round(total, 6)
    difference = round (difference, 6)
    print('The computed approximation to log', x, "is:" ,total)
    print('The difference between the approximation and the actual value for log', x, "is:" ,difference)
    
if __name__ == "__main__":
    main()

