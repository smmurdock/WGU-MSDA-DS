#!/usr/bin/env python
# coding: utf-8

"""
clean_and_filter.py - Flight data filtering and cleaning script

This script imports the formatted flight data CSV file and filters and cleans it
according to the requirements of the polynomial regression model.

Input: formatted_flight_data.csv (formatted flight data)
Output: cleaned_data.csv (formatted for model consumption)
        cleaned_data.csv.dvc (DVC metafile)
"""

# Load libraries
import pandas as pd

# Load the formatted flight data CSV file
df = pd.read_csv('formatted_flight_data.csv')

# Check for duplicate rows
duplicates = df.duplicated().sum()
if duplicates > 0:
    print(f"Found {duplicates} duplicate rows. Removing duplicates.")
    df = df.drop_duplicates()
else:
    print("No duplicate rows found.")

# Check for missing values
# print(df.isnull().sum())
# Fill missing float or integer values with 0
df.fillna(0, inplace=True)

# Check data types of each column
# print(df.info())
# Convert floats to integers where appropriate
float_columns = ['DEPARTURE_TIME', 'DEPARTURE_DELAY', 'ARRIVAL_TIME', 'ARRIVAL_DELAY']
df[float_columns] = df[float_columns].astype('int64')

# Filter for Atlanta (ATL) departures
# Print formatted data shape
# print(f"Formatted data shape:\n\tRows: {df.shape[0]}\n\tColumns: {df.shape[1]}")
df = df[df['ORG_AIRPORT'] == 'ATL']
# Print formatted data shape
# print(f"Filtered data shape:\n\tRows: {df.shape[0]}\n\tColumns: {df.shape[1]}")

# Save filtered data
df.to_csv('cleaned_data.csv', index=False)