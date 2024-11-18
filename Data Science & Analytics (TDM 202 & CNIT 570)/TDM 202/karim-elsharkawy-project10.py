#1

import pandas as pd

# make columns visible and wide
pd.set_option('display.max_columns', None)

#specifying what columns we want
mycols = [
    'DepDelay', 'ArrDelay', 'Distance',
    'CarrierDelay', 'WeatherDelay',
    'DepTime', 'ArrTime', 'Diverted', 'AirTime'
]

#specifying the types of columns. 'int64' columns can still be 'float64' and they'll work just fine
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

myDF = pd.read_csv("/anvil/projects/tdm/data/flights/2014.csv", nrows = 10000, usecols=mycols, dtype=my_col_types)
myDF.shape #to confirm the size of the columns and rows

myDF.head()

#2A and B

import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import pandas as pd
import numpy as np
import time

# filling in the missing values within a column, with the median values available
for col in myDF.columns:
    myDF[col] = myDF[col].fillna(myDF[col].median())

#3
# Splitting features and labels
features = myDF.drop('ArrDelay', axis=1) #dropping 'ArrDelay' from the training set
labels = myDF['ArrDelay'] #predicting 'ArrDelay' using our data in features


# Split
X_train, X_test, y_train, y_test = train_test_split(features, labels, test_size=0.2, random_state=42)


#4A
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train).astype(np.float32)
X_test_scaled = scaler.transform(X_test).astype(np.float32)

#B
# Creating tensorflow dataset
train_dataset = tf.data.Dataset.from_tensor_slices((X_train_scaled, y_train)).batch(14)
test_dataset = tf.data.Dataset.from_tensor_slices((X_test_scaled, y_test)).batch(14)


# Define model
model = tf.keras.Sequential([
    tf.keras.layers.Dense(128, activation='relu', input_shape=(X_train_scaled.shape[1],)),
    tf.keras.layers.Dropout(0.2),
    tf.keras.layers.Dense(1)
])

# Compile
model.compile(optimizer='adam',
              loss='mean_squared_error',
              metrics=['mean_absolute_error'])

# Train
history = model.fit(train_dataset, epochs=10, validation_data=test_dataset)