# Question 1
import pandas as pd
pd.set_option('display.max_columns', None) # make columns visible and wide

#specifying what columns we want
mycols = [
    'DepDelay', 'ArrDelay', 'Distance',
    'CarrierDelay', 'WeatherDelay',
    'DepTime', 'ArrTime', 'Diverted', 'AirTime'
]

# specifying the types of columns 
my_col_types = {
    'DepDelay': 'float64',
    'ArrDelay': 'float64',
    'Distance': 'float64',
    'CarrierDelay': 'float64',
    'WeatherDelay': 'float64',
    'DepTime': 'float64',
    'ArrTime': 'float64',
    'Diverted': 'float64',
    'AirTime': 'float64',
}

# Data Loading and Preprocessing
myDF140 = pd.read_csv("/anvil/projects/tdm/data/flights/2014.csv", nrows=100000, usecols=mycols, dtype=my_col_types)
myDF140.shape  # to confirm the size of the columns and rows
myDF140.head()

# TensorFlow and scikit-learn imports
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import pandas as pd
import numpy as np
import time

# Data Cleaning
for col in myDF140.columns:
    myDF140[col] = myDF140[col].fillna(myDF140[col].median())

features10 = myDF140.drop('ArrDelay', axis=1)  # dropping 'ArrDelay' from the training set
labels10 = myDF140['ArrDelay']  # predicting 'ArrDelay' using our data in features

# Splitting Data
X_train, X_test, y_train, y_test = train_test_split(features, labels, test_size=0.2, random_state=42)

# Feature Scaling
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train).astype(np.float32)
X_test_scaled = scaler.transform(X_test).astype(np.float32)

# Creating TensorFlow Datasets
train_dataset = tf.data.Dataset.from_tensor_slices((X_train_scaled, y_train)).batch(14)
test_dataset = tf.data.Dataset.from_tensor_slices((X_test_scaled, y_test)).batch(14)

# Defining the Model
model = tf.keras.Sequential([
    tf.keras.layers.Dense(128, activation='relu', input_shape=(X_train_scaled.shape[1],)),
    tf.keras.layers.Dropout(0.2),
    tf.keras.layers.Dense(1)
])

# Compiling the Model
model.compile(optimizer='adam',
              loss='mean_squared_error',
              metrics=['mean_absolute_error'])

# Training the Model
history = model.fit(train_dataset, epochs=10, validation_data=test_dataset)

# Memory Management
del X_train_scaled, X_test_scaled, train_dataset, test_dataset

# Question 2
myDF190 = pd.read_csv("/anvil/projects/tdm/data/flights/2019.csv", nrows=100000, usecols=mycols, dtype=my_col_types)

for col in myDF190.columns:
    myDF190[col] = myDF190[col].fillna(myDF190[col].median())

features20 = myDF190.drop('ArrDelay', axis=1) # Dropping 'ArrDelay' from the training set
labels20 = myDF190['ArrDelay'] # Predicting 'ArrDelay' using our data in features

features20 = scaler.transform(features20).astype(np.float32)
predictedvalues20 = model.predict(features20)

# Question 3

#### 2014 flight data set ###
myDF141 = pd.read_csv("/anvil/projects/tdm/data/flights/2014.csv", nrows=500000, usecols=mycols, dtype=my_col_types)

for col in myDF141.columns:
    myDF141[col] = myDF141[col].fillna(myDF141[col].median())

features11 = myDF141.drop('ArrDelay', axis=1)  # Dropping 'ArrDelay' from the features
labels11 = myDF141['ArrDelay']  # ArrDelay is the label to predict

# Scaling features using the previously defined scaler object
features11 = scaler.transform(features11).astype(np.float32)

# Making predictions using the trained model
predictedvalues11 = model.predict(features11)

### 2019 flight data set ###
myDF191 = pd.read_csv("/anvil/projects/tdm/data/flights/2019.csv", nrows=500000, usecols=mycols, dtype=my_col_types)

for col in myDF191.columns:
    myDF191[col] = myDF191[col].fillna(myDF191[col].median())

features21 = myDF191.drop('ArrDelay', axis=1) # Dropping 'ArrDelay' from the training set
labels21 = myDF191['ArrDelay'] # Predicting 'ArrDelay' using our data in features

features21 = scaler.transform(features21).astype(np.float32)
predictedvalues21 = model.predict(features21)

# Question 4
import plotly.express as px

mylist14 = [xi - yi for xi, yi in zip(list(labels20), list(np.hstack(predictedvalues20)))]
print(sum(mylist14)/len(mylist14))

fig14 = px.box(mylist14)
fig14.show()

# Question 5

mylist19 = [xi - yi for xi, yi in zip(list(labels21), list(np.hstack(predictedvalues21)))]
print(sum(mylist19)/len(mylist19))

fig19 = px.box(mylist19)
fig19.show()