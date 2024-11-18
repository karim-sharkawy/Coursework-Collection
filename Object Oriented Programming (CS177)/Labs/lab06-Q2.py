# CS 177 – lab06-Q2.py
# Karim Muhammad El-Sharkawy
#receives a string as a parameter and returns a modified version of the given string based on the length of the string.
#The definition of the predict function
import math
def main():
    myString = "abcde"
    print(splitAndJoin(myString))
    
def splitAndJoin(myString):
    if len(myString)%2 == 0: # even.
        even = myString[int(len(myString)/2):] + myString[0:int(len(myString)/2)]
        return even
    else: # odd.
        odd = myString[math.ceil((len(myString)/2)):] + myString[math.floor((len(myString)/2))] + myString[0:math.floor((len(myString)/2))]
        return odd
#Calling the main function.
if __name__ == "__main__":
    main()
