# CS 177 – project3.py
# {Karim Muhammad El-Sharkawy}
# write code that reads data from files, processes them in lists, and create plots about the data.

import matplotlib.pyplot as pyplot

# task 1 starts here
def readCustomerData(fileName):
    customer_data = []
    myfile = open(fileName, 'r')
    read_file = myfile.readlines()
    myfile.close()

    for i in range(len(read_file)):
        read_file[i] = read_file[i].rstrip('\n')
    for line in read_file:
        customer_data.append(line.split(','))

    return customer_data

def readTransactionData(fileName):
    transaction_data = []
    myfile = open(fileName, 'r')
    read_file = myfile.readlines()
    myfile.close()

    for i in range(len(read_file)):
        read_file[i] = read_file[i].rstrip('\n')
    for line in read_file:
        transaction_data.append(line.split(','))
    for integer in transaction_data:
        integer[2] = float(integer[2])

    return transaction_data

def readProductData(fileName):
    product_data = []
    myfile = open(fileName, 'r')
    read_file = myfile.readlines()
    myfile.close()

    for i in range(len(read_file)):
        read_file[i] = read_file[i].rstrip('\n')
    for line in read_file:
        product_data.append(line.split(','))
    for integer in product_data:
        integer[2] = float(integer[2])
    

    return product_data



# task 2 starts here
def countCustomers(customerList, category, state):
    count = 0
    for alist in customerList:
        if ((alist[2] == category) & (alist[3] == state)):
            count += 1
    return count

# task 3 starts here

def HighValueCustomers(customer_data, product_data, transaction_data):
    list1 = []
    for customer in customer_data:
        total = 0
        for transaction in transaction_data:
            if customer[0] == transaction[0]:
                for product in product_data:
                    if transaction[1] == product[0]:
                        total += transaction[2] * product[2]
        if total > 4000:
            list1.append(customer[1])
    list1 = sorted(list1)

    return list1                        


# task 4 starts here
def monthlyEarnings(transaction_data, product_data,month):
    initial_gains = 0
    for i in range(len(transaction_data)):
        if transaction_data[i][3] == month:
            for p in range(len(product_data)):
                if transaction_data[i][1] == product_data[p][0]:
                    initial_gains = initial_gains + (transaction_data[i][2] * product_data[p][2])
    initial_gains = round(initial_gains, 2)
    return (initial_gains)

# task 5 starts here
def stateCategoryStatistics(customer_data, transaction_data, product_data, productCategory):
    stateList = []
    for i in product_data:
        if i[1] == productCategory:
            for t in transaction_data:
                if i[0] == t[1]:
                    for k in customer_data:
                        if k[0] == t[0]:
                            stateList.append(k[3])
    totalList =[]
    for i in list(set(stateList)):
        stateList.count(i)
        totalList.append([i, stateList.count(i)])
    return(sorted(totalList))
          
task 6 starts here
def plotPieChart(transaction_data,product_data):

def plotBarChart(statesCountList):



#task 7 starts here
def main():
    customerList = readCustomerData('customerData.txt')
    print(customerList)

    transactionList = readTransactionData('transactionData.txt')
    print(transactionList)

    productList = readProductData('productData.txt')
    print(productList)
    
    #print(countCustomers(customerList, 'Wholesale', 'Indiana'))

    statesCount = stateCategoryStatistics(customerList, transactionList, productList,'Diodes')
    print(statesCount)

    valueList = HighValueCustomers(customerList, productList, transactionList) 
    print(valueList)

    print(monthlyEarnings(transactionList, productList, 'Feb'))

    statesCount = stateCategoryStatistics(customerList, transactionList, productList,'Diodes')
    print(statesCount)

    #plotPieChart(transactionList, productList)
    #plotPieChart.pdf

    #statesCountList = stateCategoryStatistics(customerList, transactionList, productList,'Diodes')
    #plotBarChart(statesCountList)


#Calling the main function.
if __name__ == "__main__":
    main()
