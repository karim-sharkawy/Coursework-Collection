# CS 177 lab04.py
# Karim Muhammad El-Sharkawy 00329-43874
# This program prompts the user for two attributes of the cap they want
#The definition of the main function
print("Enter the attributes of the cap you want:")
def main():
    b = input("Brand: ")
    s = input("Size: ")

    if b == "X":
        if s == "S": print("Cost: 5")
        elif s == "M": print("Cost: 7")
        elif s == "L": print("Cost: 9")
        else: print("INVALID INPUT!")

    if b == "Y":
        if s == "S": print("Cost: 6")
        elif s == "M": print("Cost: 7")
        elif s == "L": print("Cost: 8")
        else: print("INVALID INPUT!")

    if b == "Z":
        if s == "S": print("Cost: 4")
        elif s == "M": print("Cost: 6")
        elif s == "L": print("Cost: 8")
        else: print("INVALID INPUT!")
    
#Calling the main function
if __name__ == "__main__":
    main()
