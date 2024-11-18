#1

from pyspark.sql import SparkSession
import pandas as pd
import numpy as np
import time

# Create the Session
spark = SparkSession.builder\
    .master("local")\
    .appName("PySpark Tutorial")\
    .getOrCreate()

# Generate a random dataframe with 10^7 rows
data = {'col1':np.random.randint(1,10,10000000),'col2':np.random.randint(1,10,10000000)}
df = pd.DataFrame(data)

# Creating our pandas dataframe
pandasDF = df.copy()

startPandas = time.time()
pandasDF['col2'] = pandasDF['col2'].map(lambda x: x - (x*10/100))
endPandas = time.time()
print(endPandas - startPandas)

# Creating our spark dataframe
spark.conf.set("spark.sql.execution.arrow.pyspark.enabled","true")
sparkDF = spark.createDataFrame(df)

startSpark = time.time()
sparkRDD = sparkDF.rdd.map(lambda x: [x[0],x[1] - (x[1]*10/100)])
endSpark = time.time()
print(endSpark - startSpark)

#2
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql.functions import *
# creating a spark application named TDM_S that uses 2 gigabytes of the spark driver program
sp = SparkSession.builder.appName('TDM_S').config("spark.driver.memory", "2g").getOrCreate()
#.getOrCreate() actually creates the spark sessions

myDF = sp.read.parquet("/anvil/projects/tdm/data/whin/weather.parquet")
myDF.show(5) #Showing the first 5 rows of the dataframe

#3A
myDF.printSchema() #Listing column names and data types of the WHIN dataframe

#B
# couting and print the rows
myDF.count()

#C
myDF.select('station_id').distinct().count() # counting the number of stations

#4A
myDF.createOrReplaceTempView("weather")

#B
# Get the total number of records for each station
myresults = sp.sql("SELECT station_id, COUNT(*) AS Total_Records FROM weather GROUP BY station_id")
myresults.show()

#C
myresults = sp.sql("SELECT station_id, MAX(wind_speed_mph) AS wind_speed FROM weather GROUP BY station_id")
myresults.show()

#D
myresults = sp.sql("SELECT station_id, AVG(temperature) AS avg_temperature FROM weather GROUP BY station_id")
myresults.show()

#5
myresults = sp.sql("SELECT station_id, AVG(solar_radiation) AS avg_solar_radiation FROM weather GROUP BY station_id")
myresults.show() # in watts per square meter

myresults = sp.sql("SELECT station_id, AVG(pressure) AS avg_pressure FROM weather GROUP BY station_id")
myresults.show() # in inches Hg