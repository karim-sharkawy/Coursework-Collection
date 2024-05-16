# CS 177 – prelab07-Q1.py
# Karim Muhammad El-Sharkawy
# using a function called isMultiple w/parameters num1 and num2\

def isMultiple(num1, num2):
    count = 0
    if num1 >=0 and num2 >= 0:
        for i in range(1, num1 + 1):
            if i%num2 == 0:
                count += 1
        return count
    else:
        return -1

def main():
    num1 = eval(input("Please input the first integer: "))
    num2 = eval(input("Please input the second integer: "))
    print(isMultiple(num1, num2))
#Calling the main function.
if __name__ == "__main__":
    main()
