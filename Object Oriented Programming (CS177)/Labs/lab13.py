# CS 177 – lab13.py
# {Karim Muhammad El-Sharkawy}

testDic1 = [{"name": "Sam", "assignments": [90.0, 50.0, 75.0, 60.0], "projects": [35.0, 80.0, 72.0],"exams": [42.0, 56.5]}, {"name": "Anna","assignments": [100.0, 90, 92, 88.0], "projects": [85.0, 75.0, 88.0],"exams": [95.0, 75.0]},{"name": "Maria", "assignments": [60.0, 70, 80.0, 90.0], "projects": [40.0, 80.0, 95.0], "exams": [80, 70]} ]
testDic2 = [{"name": "Emma", "assignments": [10.0,20,30], "projects": [50.0,60.0],"exams": [75,98]}, {"name": "John", "assignments": [15, 24, 35, 62.0], "projects": [30, 60], "exams": [40, 70]} ]

def gradebook(studentsDictList):

    gb = {}

    # computing the average
    for i in studentsDictList:
        avgassignment = sum(i["assignments"])/len(i["assignments"])
        avgexam = sum(i["exams"])/len(i["exams"])
        avgproject = sum(i["projects"])/len(i["projects"])

        # computing the final score
        finalscore = (0.35 * avgassignment) + (0.30 * avgexam) + (0.35 * avgproject)

        #finding the final letter grade
        if finalscore < 50:
            finalscore = "F"

        elif finalscore >= 50 and finalscore < 60:
            finalscore = "E"

        elif finalscore >= 60 and finalscore < 70:
            finalscore = "D"

        elif finalscore >= 70 and finalscore < 80:
            finalscore = "C"

        elif finalscore >= 80 and finalscore < 90:
            finalscore = "B"

        else:
            finalscore = "A"
        gb[i["name"]] = finalscore

    return gb
    
def main():    
    print(gradebook(testDic1))
    print(gradebook(testDic2))

if __name__ == "__main__":
    main()
