# CS 177 – project1.py
# Karim Muhammad El-Sharkawy
# This is going to deal with Q1. This evaluates the readability based on the length of the words used in the text using a for loop.


#The definition of the main function
def main():
    s = input("Please enter a sentence: ") #s for "sentence"
    i = eval(input("Please enter an integer: ")) #i for "integer"
    s = s.split(" ")
    avg_word_len = 0
    c = len(s)
    count = 0
    for word in s:
        if len(word) > i:
            count += 1
    print("Number of words:", count)
#Calling the main function
if __name__ == "__main__":
    main()
