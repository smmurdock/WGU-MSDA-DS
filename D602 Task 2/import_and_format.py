#!/usr/bin/env python
# coding: utf-8

"""
Import and format flight data from the original CSV file.

This scipt reads the raw flight data, selects necessary columns,
renames them according to the expected format, and saves the cleaned
data to a new CSV file.

Output:
    formatted_flight_data.csv: CSV file containing the formatted data.
"""

import pandas as pd

df = pd.read_csv('T_ONTIME_REPORTING.csv')
#print(df.head().T) # Observe first five rows
#print(df.shape) # (54562, 19) - 12 columns expeected by poly_regressor
# print(df.info()) # Observe data types and non-null counts

# Select required columns
# Note: This provides flexibility for reproducibility if someone downloads
# extra data in the raw dataset.
columns_to_keep = [
    'YEAR',
    'MONTH',
    'DAY_OF_MONTH',
    'DAY_OF_WEEK',
    'ORIGIN',
    'DEST',
    'CRS_DEP_TIME',
    'DEP_TIME',
    'DEP_DELAY',
    'CRS_ARR_TIME',
    'ARR_TIME',
    'ARR_DELAY'
]
# Filter to keep only required columns
df = df[columns_to_keep]
# print(df.shape) # (54562, 12) - 12 columns expeected by poly_regressor

# Define column mapping from original to expected format
column_mapping = {
    'YEAR': 'YEAR',
    'MONTH': 'MONTH',
    'DAY_OF_MONTH': 'DAY',
    'DAY_OF_WEEK': 'DAY_OF_WEEK',
    'ORIGIN': 'ORG_AIRPORT',
    'DEST': 'DEST_AIRPORT',
    'CRS_DEP_TIME': 'SCHEDULED_DEPARTURE',
    'DEP_TIME': 'DEPARTURE_TIME',
    'DEP_DELAY': 'DEPARTURE_DELAY',
    'CRS_ARR_TIME': 'SCHEDULED_ARRIVAL',
    'ARR_TIME': 'ARRIVAL_TIME',
    'ARR_DELAY': 'ARRIVAL_DELAY'
}

# Replace column titles with column_mapping
df.rename(columns=column_mapping, inplace=True)

# Save the formatted DataFrame to a new CSV file to be picked up by
# clean_and_filter.py
formatted_csv = 'formatted_flight_data.csv'
df.to_csv(formatted_csv, index=False)