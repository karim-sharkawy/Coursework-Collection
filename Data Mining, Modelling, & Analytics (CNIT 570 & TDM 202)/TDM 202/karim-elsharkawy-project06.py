#1
#A
import pandas as pd
import plotly.express as px

# Reading the CSV file
myDF = pd.read_csv("/anvil/projects/tdm/data/zillow/Metro_time_series.csv")

#B
# Makes the 'Date' column into a 'datetime' datatype
myDF['Date'] = pd.to_datetime(myDF['Date'])

#C
# Summing the values of 'InventoryRaw_AllHomes' for each date
myresult = myDF.groupby('Date')['InventoryRaw_AllHomes'].sum()

#D
newDF = myDF[(myDF['Date'].dt.year >= 2010) & (myDF['Date'].dt.year <= 2015)] # Making a new df with the criteria that dates are between 2010-15
myfigure = px.line(myresult, title='Overall housing inventory from 2010 to 2015') # plotting a line graph with the critera
myfigure.show()

#2
#A
InvDF = myDF.dropna(subset=['InventoryRaw_AllHomes']) # Making a new df which removes 'NaN' values from 'InventoryRaw_AllHomes'
InvDF = InvDF[InvDF['RegionName'] != 'United_States'] # removing the US region name

# Printing a sorted table of the average inventory of all homes in the year 2013
homeresultsbymonth = InvDF[InvDF['Date'].dt.year == 2013].groupby('RegionName')['InventoryRaw_AllHomes'].mean().sort_values()
print(homeresultsbymonth)

#B
AgeDF = myDF.dropna(subset=['AgeOfInventory'])
ageresultsbymonth = AgeDF[AgeDF['Date'].dt.year == 2013].groupby('RegionName')['AgeOfInventory'].mean().sort_values()
print(ageresultsbymonth)
# Very similar to A, except it's the age of the inventories now

#C
homeresultsbymonth = InvDF[InvDF['Date'].dt.year == 2013].groupby('RegionName')['InventoryRaw_AllHomes'].mean().sort_values().tail()
px.bar(homeresultsbymonth, title='Regions of highest average inventory of raw homes') # making a bar plot of the specified criteria above

#D
ageresultsbymonth = AgeDF[AgeDF['Date'].dt.year == 2013].groupby('RegionName')['AgeOfInventory'].mean().sort_values().tail()
px.bar(ageresultsbymonth, title='Regions of highest age of inventory')
# Very similar to C, except it's the age of the inventories now

#3
# The same as 2D, but it's a box plot instead of bar plot
px.box(ageresultsbymonth, title='Regions of highest age of inventory')

#4
#A
# Using the 'loc' function which stands for location to find a specific element. In this case, RegionNameof '28580'
famDF = myDF.loc[myDF['RegionName'] == '28580',["Date","ZHVI_SingleFamilyResidence"]] # Making a table called famDF, which has the date and ZHVI for all specified region names
print(famDF)

#B
famresults = famDF[famDF['Date'].dt.year >= 2015].groupby('Date')['ZHVI_SingleFamilyResidence'].mean().sort_values().tail()
fam = px.bar(famresults, title='Zillow Home Value Index for Single Family Homes from late 2016 to early 2017')
fam.update_traces(width=1.5e9) #Making the width slightly smaller so the graph is nicer to look at
fam.show()

#5
myDF = myDF.dropna(subset=['AgeOfInventory'])
USonlyDF = myDF.loc[myDF['RegionName'] == 'United_States', ["Date", "AgeOfInventory"]]

USonlyDF = USonlyDF[USonlyDF['Date'].dt.year == 2015]

USonlyresults = USonlyDF.groupby('Date')['AgeOfInventory'].mean().reset_index()
# I don't know why, but I can only put the names of the axes when I use reset_index()

# Creating the line plot
USonly = px.line(USonlyresults, x='Date', y='AgeOfInventory', title='Average Age of Inventory in 2015')
USonly.show()