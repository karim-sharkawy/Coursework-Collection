# CS 177 – lab07.py
# Karim Muhammad El-Sharkawy
# We're encrypting one string with another. key_text string to encode the plain_text string.
import math
def encrypt(key_text, plain_text):
    quotients = [] # notice the wording. One letter is different
    encrypted_text = ""
    encryption_key = 0
    
    for element in key_text:
        encryption_key += ord(element)

    for letter in plain_text:
        summ = ord(letter) + encryption_key

        quotient = int(summ/127) # notice the wording. One letter is different

        remainder = (summ%127) + 33

        quotients.append(quotient) # notice the wording. One letter is different
        
        encrypted_text += chr(remainder)

    return encryption_key, quotients, encrypted_text

def main():
    key_text = input("Enter the key text: ")
    plain_text = input("Enter the plain text: ")


    encryption_key, quotients, encrypted_text = encrypt(key_text, plain_text)

    print("The encryption key: ",encryption_key)
    print("The quotients: ",quotients)
    print("The encrypted_text: ",encrypted_text)


#Calling the main function. Do we use predict and predict() this time?
if __name__ == "__main__":
    main()
