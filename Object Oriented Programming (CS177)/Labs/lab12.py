# CS 177 – lab12.py
# {Karim Muhammad El-Sharkawy}
# bru this returns some stuff. I hate this class so much i even hate the summaries now

def readStudents(filename):
    studentdictionary = {}
    try:
        if type(filename) is str:
            with open(filename, "r") as myfile:
                contents = myfile.readlines()
            contents = [x.strip() for x in contents]

        for stuff in contents:
            key = stuff.split(",")[0].strip()
            value = stuff.split(",")[1].strip()
            studentdictionary[key] = value
    except:
        print("Exception occured in readStudents function.")
    return studentdictionary

#this is pretty similar. Just copy and pasted code really
def readGrades(filename):
    gradesList = [] #this is a list, not a dictionary
    try:
        if type(filename) is str:
            with open(filename, "r")as myfile:
                contents = myfile.readlines()
            contents = [x.strip() for x in contents]
        for stuff in contents:
            gradesList.append(stuff.split(","))

    except:
        print("Exception occured in readGrades function.")
    return gradesList


def finalGrades(studentsDict, gradesList):
    finals = {}
    try:
        if type(studentsDict) is dict and type(gradesList) is list:
            for key,value in studentsDict.items():
                initial = 0
                summ = 0
                for something in gradesList:
                    if key in something:
                        initial = initial + 1
                        summ = summ + int(something[-1])
                        if value not in finals:
                            finals[value] = [1, int(something[-1])]
                        else:
                            finals[value] = [initial, summ]
    except:
        print("Exception occured in finalGrades function.")
    return finals
def main():
    studentsDict = readStudents('students.txt')
    gradesList = readGrades('gradebook.txt')

    print(finalGrades(studentsDict, gradesList))

if __name__ == "__main__":
    main()
