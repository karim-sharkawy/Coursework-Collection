# CS 177 – prelab04.py
# Karim Muhammad El-Sharkawy
# Following Coding Standards and Guidelines

#The definition of the main function
def main():
    o = eval(input("Order: "))
    n = eval(input("Number of items in the inventory: "))
    if o > n: print("Resupply inventory!")
    elif o > 6: print("We need multiple packages!")
    else: print("We need one package!")
#Calling the main function
if __name__ == "__main__":
    main()

