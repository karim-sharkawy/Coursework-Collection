# CS 177 – lab08.py
# Karim Muhammad El-Sharkawy
# just try to survive this week bro

def readSalesData(filename):
    sales_data = []
    myfile = open(filename, 'r')
    bruh = myfile.read()
    somestuff = bruh.split('\n')
    somestuff = list(filter(None, somestuff))

    for value in somestuff:
        part_list = value.strip().split(',')
        f = [part_list[0]]

        for x in part_list[1:]:
            f.append(float(x))

        salesData.append(f)

    myfile.close
    return salesData

def computeAverageSales(salesData):

    averages_list = []

    for something in range(5):
        pairs_list = []
        pairs_list.append(salesData[something][0])

        avg = 0
        num_terms = 0

        for number in range(len(salesData[something])):
            if number != 0:
                if float (salesData[something][number]) < 0:
                    break
                num_terms = number
                avg += float (salesData[something][number])
        avg /= num_terms
        pairs_list.append(avg)
        averages_list.append(pairs_list)

    mySortedList = sorted(averages_list, key = lambda x:x[0])
    return mySortedList
    
def main():
    filename = input("Input filename: ")

    print(redSalesData(fruit))
    
#Calling the main function.
if __name__ == "__main__":
    main()
