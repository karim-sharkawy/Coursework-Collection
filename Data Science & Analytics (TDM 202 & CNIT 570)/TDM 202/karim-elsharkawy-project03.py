from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.service import Service
from webdriver_manager.firefox import GeckoDriverManager
from selenium.webdriver.firefox.options import Options

firefox_options = Options()
firefox_options.add_argument("--headless")
firefox_options.add_argument("--disable-extensions")
firefox_options.add_argument("--no-sandbox")
firefox_options.add_argument("--disable-dev-shm-usage")

driver = webdriver.Firefox(service=Service(GeckoDriverManager().install()),options=firefox_options)

driver.get("https://books.toscrape.com")
# the code is extremely long so I have it set to a limit of 1000 characters
print(driver.page_source[:1000])

driver.title

for e in driver.find_elements("xpath", "//li/ul/li/a"):
    print(e.text) #note: I'm using xpath. If I was using CSS.Selector, then the .text function doesn't work
    
for e in driver.find_elements("xpath", "//li/ul/li/a"):
    print("The link for",e.text, "is", e.get_attribute('href'))
    
categories = driver.find_elements(By.CSS_SELECTOR,".nav-list>li>ul>li>a" ) #finding the categories using CSS_SELECTOR
for book in categories:
    if book.text == "Romance": #finding the romance section
        myResult = book.get_attribute('href') #getting the link
        print( f"Category: {book.text.strip()}, Link: {myResult}") #printing it out and making it look nice
        break
        
driver.get(myResult)

for e in driver.find_elements("xpath","//article/div/a/img"): #telling xpath to go to the a and img tags
    bookResult = e.get_attribute('alt') #getting the books
    print(bookResult)
    
for e in driver.find_elements("xpath","//li[@class='next']/a"):
    nextResult = e.get_attribute('href') #getting the link
driver.get(nextResult) #accessing the link exaclty like in #1

for e in driver.find_elements("xpath","//article/div/a/img"):
    print(e.get_attribute('alt')) #finding all the books in the link and printing them out