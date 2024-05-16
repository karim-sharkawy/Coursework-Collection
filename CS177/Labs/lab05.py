# CS 177 – lab05.py
# Karim Muhammad El-Sharkawy
# This is going to deal with Q1.

#The definition of the main function
def main():
    createlist = []
    for  n in range(100,500):
        a = n%10
        b = (n//10)%10
        c = ((n//10)//10)%10
        A = (a**3)
        B = (b**3)
        C = (c**3)
        d = (A + B + C)
        if n == d:
            createlist.append(d)
    print(createlist)
    
    
#Calling the main function
if __name__ == "__main__":
    main()

    # d == (A + B + C)
