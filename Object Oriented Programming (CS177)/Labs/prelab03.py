# CS 177 – Prelab03.py
# Karim Muhammad El-Sharkawy
# Following Coding Standards and Guidelines
# This program accepts 2 values and outputs 4 lines per each iteration

# call the main function and set i to get the number of iterations
import math

# <Write HERE the definition of the main function>
def main():
    i = eval(input("Number of iterations "))

    for item in range(i):
        a = eval(input("Enter the first number: ")) #assigning a value to a (whatever value I choose. In this case, 4 and then 12)
        b = eval(input("Enter the second number: ")) #assigning a value to b (whatever value I choose. In this case, 2 and then 4)
        
        c = a + b
        d = a - b
        e = a*b
        f = a//b
        
        w = print(a, "+", b, "=", c)
        x = print(a, "-", b, "=",d)
        y = print(a, "*", b, "=", e)
        z = print(a, "/", b, "=", f)
main() # < Call HERE the main function>
