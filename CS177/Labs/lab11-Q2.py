# CS 177 – lab11-Q2.py
# {Karim Muhammad El-Sharkawy}
# bryuhiuyguybuvuh

def calcListDiff (list1, list2):
    counts = 0
    list1 = set(list1)
    list2 = set(list2)
    for i in list1:
        if i not in list2:
            counts += 1
    for i in list2:
        if i not in list1:
            counts += 1
    return counts


def main():
    list1 = []
    list2 = ['b','c',3]
    print(calcListDiff (list1, list2))

#Calling the main function.
if __name__ == "__main__":
    main()