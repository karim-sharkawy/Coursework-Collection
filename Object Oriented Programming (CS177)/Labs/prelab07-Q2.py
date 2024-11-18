# CS 177 – prelab07-Q2.py
# Karim Muhammad El-Sharkawy
# using a function called substitutePairs w/parameters num1 and num2

def substitutePairs(myString, pairsList):
    for i in pairsList:
        myString = myString.replace(i[0], i[1])
    return myString

def main():
    myString = "Indiana"
    pairsList = [['a', '@'], ['s', '$'], ['i', '1'], ['u', '*'], ['p','z']]
    print(substitutePairs(myString, pairsList))


#Calling the main function.
if __name__ == "__main__":
    main()

