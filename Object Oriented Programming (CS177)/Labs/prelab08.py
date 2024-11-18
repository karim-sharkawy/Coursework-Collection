# CS 177 – prelab08.py
# Karim Muhammad El-Sharkawy
# just try to survive this week bro

def readCourses(courses):
    list1 = []
    myfile = open(courses, 'r')
    myline = myfile.readline()
    while myline:
        line = myline.strip('\n')
        line2 = line.split(',')
        list1.append(line2)
        myline = myfile.readline()
    for i in list1:
        i[2] = float(i[2])
    print(list1)
    return list1
def computeAverage(list1):
    list2 = []
    for i in list1:
        list2.append(i[2])

    avg = sum(list2)/len(list2)
    return avg

def main():
    courses = readCourses('courses.txt')
    print(computeAverage(courses))
#Calling the main function.
if __name__ == "__main__":
    main()
