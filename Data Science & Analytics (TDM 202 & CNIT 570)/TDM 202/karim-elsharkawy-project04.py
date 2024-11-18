# Question 1

import pandas as pd
import lxml.etree
import glob

tree = lxml.etree.parse("/anvil/projects/tdm/data/otc/valu.xml")
ingredients = tree.xpath("//ns:ingredient", namespaces = {'ns': 'urn:hl7-org:v3'})
for e in ingredients:
    for s in e.xpath("//ns:ingredientSubstance", namespaces = {'ns': 'urn:hl7-org:v3'}):
        print(s[1].text)
        
# Same as the code above, however the file is different
tree = lxml.etree.parse("/anvil/projects/tdm/data/otc/hawaii.xml")
ingredients = tree.xpath("//ns:ingredient", namespaces = {'ns': 'urn:hl7-org:v3'})
for e in ingredients:
    for s in e.xpath("//ns:ingredientSubstance", namespaces = {'ns': 'urn:hl7-org:v3'}):
        print(s[1].text) #using .text to get the name instead of location of the compounds
        
# Question 2
for myfile in glob.glob("/anvil/projects/tdm/data/otc/archive1/*.xml")[0:11]:
    tree = lxml.etree.parse(myfile)
    ingredients = tree.xpath("//ns:ingredient", namespaces = {'ns': 'urn:hl7-org:v3'})
    for e in ingredients:
        for s in e.xpath("//ns:ingredientSubstance", namespaces = {'ns': 'urn:hl7-org:v3'}):
            print(s[1].text) #using .text to get the name instead of location of the compounds
            
mydict = {}
for myfile in glob.glob("/anvil/projects/tdm/data/otc/archive1/*.xml")[0:11]: #print files 0 to 10
    tree = lxml.etree.parse(myfile)
    ingredients = tree.xpath("//ns:ingredient", namespaces = {'ns': 'urn:hl7-org:v3'})
    for e in ingredients:
        for s in e.xpath("//ns:ingredientSubstance", namespaces = {'ns': 'urn:hl7-org:v3'}):
            if s[1].text not in mydict: #seeing how many times every compound shows up
                mydict[s[1].text] = 1 #if it's not in the dictionary yet, it gets added
            else:
                mydict[s[1].text] += 1 #if it is in the dictionary, we add one to its value
for i in mydict:
    print(i, mydict[i]) #printing the key and value so it looks nice
    
# Note: I was forgot how to print keys and values together since I haven't worked with dictionaries before
# I used the link below to make the printing look nice
    # https://stackoverflow.com/questions/26660654/how-do-i-print-the-key-value-pairs-of-a-dictionary-in-python

# Question 3
pd.DataFrame(mydict.items()).sort_values(by=[1])
Newdf = pd.DataFrame(mydict.items()).sort_values(by=[1])
print(Newdf)

Newdf.sort_values(1).tail(5)

# Question 4
mynew_dict = {}
for myfile in glob.glob("/anvil/projects/tdm/data/otc/archive1/*.xml")[0:1000]:
    tree = lxml.etree.parse(myfile)
    ingredients = tree.xpath("//ns:ingredient", namespaces = {'ns': 'urn:hl7-org:v3'})
    for e in ingredients:
        for s in e.xpath("//ns:ingredientSubstance", namespaces = {'ns': 'urn:hl7-org:v3'}):
            if s[1].text not in mynew_dict:
                mynew_dict[s[1].text] = 1
            else:
                mynew_dict[s[1].text] += 1
    
pd.DataFrame(mynew_dict.items()).sort_values(by=[1]).tail(5)

from lxml.etree import XMLParser, parse
p = XMLParser(huge_tree=True)

third_dict = {}
for myfile in glob.glob("/anvil/projects/tdm/data/otc/archive1/*.xml"): #parsing every file in the archive 1 directory
    tree = lxml.etree.parse(myfile, parser=p)
    ingredients = tree.xpath("//ns:ingredient", namespaces = {'ns': 'urn:hl7-org:v3'})
    for e in ingredients:
        for s in e.xpath("//ns:ingredientSubstance", namespaces = {'ns': 'urn:hl7-org:v3'}):
            if s[1].text not in third_dict:
                third_dict[s[1].text] = 1
            else:
                third_dict[s[1].text] += 1
    
pd.DataFrame(third_dict.items()).sort_values(by=[1]).tail(5) #sorting by post popular and printing the 5 most popular

# Question 5
mydict = {}
for number in range(1,11):
    for myfile in glob.glob(f'/anvil/projects/tdm/data/otc/archive{number}/*.xml'): # running through 10 directories number 1 to 10
        tree = lxml.etree.parse(myfile, parser=p) #using parser=p because this is too large for XML to handle
        ingredients = tree.xpath("//ns:ingredient", namespaces = {'ns': 'urn:hl7-org:v3'}) #every line of code below is the same as the previous ones
        for e in ingredients:
            for s in e.xpath("//ns:ingredientSubstance", namespaces = {'ns': 'urn:hl7-org:v3'}):
                if len(s) >= 2:
                    if s[1].text not in mydict:
                        mydict[s[1].text] = 1
                    else:
                        mydict[s[1].text] += 1
                        
pd.DataFrame(mydict.items()).sort_values(by=[1]).tail(5)