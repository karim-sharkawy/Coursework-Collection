# CS 177 – prelab12.py
# {Karim Muhammad El-Sharkawy}
# summarize the lab in a few sentences

def mergeDictionaries(dictEx1, dictEx2):
    combineddictionary = {**dictEx1, **dictEx2}
    mergedictionary = {}

    for key,value in combineddictionary.items():
        if (key in dictEx1.keys() and key in dictEx2.keys()):
            if(dictEx1[key] == dictEx2[key]):
                mergedictionary[key] = value
            else:
                mergedictionary[key] = [dictEx1[key], dictEx2[key]]
        elif(key in dictEx1.keys() or key in dictEx2.keys()):
            mergedictionary[key] = value

    return mergedictionary

if __name__ == "__main__":

    dict1Ex1 = {1 : 'a', 2 : 'b'}
    dict2Ex1 = {3 : 5, 4 : 6}

    dict1Ex2 = {1 : 'a', 2 : 'b'}
    dict2Ex2 = {1 : 5, 2 : 6}

    dict1Ex3 = {1 : 'a', 2 : 'b'}
    dict2Ex3 = {2 : 5}

    dict1Ex4 = {1 : [1,2]}
    dict2Ex4 = {1 : [2, 3, 4]}

    print(mergeDictionaries(dict1Ex1, dict2Ex1))
    print(mergeDictionaries(dict1Ex2, dict2Ex2))
    print(mergeDictionaries(dict1Ex3, dict2Ex3))
    print(mergeDictionaries(dict1Ex4, dict2Ex4))
