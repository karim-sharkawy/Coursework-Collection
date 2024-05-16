# CS 177 – prelab09.py
# {Karim Muhammad El-Sharkawy}
# functions open a file and red/state the country name as a string and relative size as a float
#import matplotlib.pyplot
def readCountriesData(countries):
    countriesList = []
    relativeSizeList = []
    myfile = open(countries, "r")
    myLine = myfile.readline()
    # countriesList, relativeSizeList = readCountriesData('countries.txt')
    # try and get the first half of each line to be in the countriesList and the next half to be in the size
    while myLine:
        x = myLine.index(",")
        print(x)
        countriesList.append(myLine[:x])
        relativeSizeList.append(myLine[x+1:])
        myLine = myfile.readline()
    myfile.close()
    return countriesList, relativeSizeList

# def plotPieChart(countriesList, relativeSizeList)

def main():
    countriesList, relativeSizeList = readCountriesData('countries.txt')
    print(countriesList)
    print(relativeSizeList)
    # print(plotPieChart(countries))
#Calling the main function.
    if __name__ == "__main__":
        main()
