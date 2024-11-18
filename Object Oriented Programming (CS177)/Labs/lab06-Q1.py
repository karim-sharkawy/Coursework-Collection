# CS 177 – lab06-Q1.py
# Karim Muhammad El-Sharkawy
#  we're predict how many days it’s gonna take a stock price to increase 5 times given a fixed daily increase ratio.
#The definition of the predict function
def main():
    currentPrice = eval(input("Please input the current price: "))
    fixedDailyIncreaseRatio = eval(input("Please input the ratio: "))
    total = predict(currentPrice, fixedDailyIncreaseRatio)
    print(total)
    # the return value has to be an integer, not a float like the others

def predict(currentPrice, fixedDailyIncreaseRatio):
    fixed = 5*currentPrice
    total = 1
    while currentPrice < fixed:
        # in the while loop, use the eqn: currentPrice = currentPrice * (1 + ratio)
        currentPrice = currentPrice * (1 + fixedDailyIncreaseRatio)
        total += 1 # total = total + 1

    return total
    
#Calling the main function.
if __name__ == "__main__":
    main()
