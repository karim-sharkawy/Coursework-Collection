# CS 177 – lab11-Q1.py
# {Karim Muhammad El-Sharkawy}
# bryuhiuyguybuvuh

def uniqueOccurrence(list1, list2, list3):
    list4 = list1 + list2 + list3

    counts = {}
    for i in list4:
        counts[i] = counts.get(i,0) + 1
    return counts #sorted(counts, key = lambda x:x[0])





def main():
    list1 = [1]
    list2 = [1,2]
    list3 = [1,2,3]
    print(uniqueOccurrence(list1,list2,list3))

#Calling the main function.
if __name__ == "__main__":
    main()
    