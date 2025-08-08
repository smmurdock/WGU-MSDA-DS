#!/usr/bin/env python
# coding: utf-8

# import statements
from fastapi import FastAPI, HTTPException
import json
import numpy as np
import pickle
import datetime

# Create FastAPI app instance
app = FastAPI(
    title="Flight Delay Prediction API",
    description="API for predicting flight departure delays based on route and timing"
)

# Import the airport encodings file
with open('airport_encodings.json', 'r') as f:
    # returns JSON object as a dictionary
    airports = json.load(f)

# Import finalized_model.pkl
with open('finalized_model.pkl', 'rb') as f:
    # returns the model object
    model = pickle.load(f)

def create_airport_encoding(airport: str, airports: dict) -> np.array:
    """
    create_airport_encoding is a function that creates an array the length of all arrival airports from the chosen departure aiport. The array consists of all zeros except for the specified arrival airport, which is a 1.

    Parameters
    ----------
    airport : str
        The specified arrival airport code as a string
    airports: dict
        A dictionary containing all of the arrival airport codes served from the chosen departure airport

    Returns
    -------
    np.array
        A NumPy array the length of the number of arrival airports.  All zeros except for a single 1
        denoting the arrival airport.  Returns None if arrival airport is not found in the input list.
        This is a one-hot encoded airport array.

    """
    temp = np.zeros(len(airports))
    if airport in airports:
        temp[airports.get(airport)] = 1
        temp = temp.T
        return temp
    else:
        return None

# TODO:  write the back-end logic to provide a prediction given the inputs
# requires finalized_model.pkl to be loaded
# the model must be passed a NumPy array consisting of the following:
# (polynomial order, encoded airport array, departure time as seconds since midnight, arrival time as seconds since midnight)
# the polynomial order is 1 unless you changed it during model training in Task 2
# YOUR CODE GOES HERE
def predict_delay(arrival_airport: str, departure_time: str, arrival_time: str):
    """
    Predict the flight delay based on the arrival airport, departure time, and arrival time.

    Parameters
    ----------
    arrival_airport : str
        The airport code for the arrival airport.
    departure_time : str
        The departure time in HH:MM format.
    arrival_time : str
        The arrival time in HH:MM format.

    Returns
    -------
    float
        The predicted flight delay in minutes.
    """
    # Get one-hot encoding for the arrival airport
    encoded_airport = create_airport_encoding(arrival_airport, airports)
    if encoded_airport is None:
        raise HTTPException(status_code=400, detail="Invalid arrival airport code")

    # Convert departure and arrival times to seconds since midnight
    try:
        dep_time = datetime.datetime.strptime(departure_time, "%H:%M")
        arr_time = datetime.datetime.strptime(arrival_time, "%H:%M")

        dep_seconds = dep_time.hour * 3600 + dep_time.minute * 60
        arr_seconds = arr_time.hour * 3600 + arr_time.minute * 60
    except ValueError:
        raise HTTPException(status_code=400, detail="Invalid time format. Use HH:MM format.")

    # Prepare the input array for the model
    input_data = np.concatenate(([1], encoded_airport, [dep_seconds], [arr_seconds]))

    # Make prediction using the model
    prediction = model.predict(input_data.reshape(1, -1))

    return float(prediction[0])  # Return the predicted delay in minutes

# TODO:  write the API endpoints.
# YOUR CODE GOES HERE
@app.get("/")
async def read_root():
    return {"message": "API is functional."}

@app.get("/predict/delays")
async def predict_delays(arrival_airport: str, departure_time: str, arrival_time: str):
    """
    API endpoint to predict flight delays.

    Parameters
    ----------
    arrival_airport : str
        The airport code for the arrival airport.
    departure_time : str
        The departure time in HH:MM format.
    arrival_time : str
        The arrival time in HH:MM format.

    Returns
    -------
    dict
        JSON response containing the predicted delay in minutes.
    """
    try:
        delay = predict_delay(arrival_airport, departure_time, arrival_time)
        return {"predicted_delay": delay}
    except HTTPException as e:
        # Re-raise the HTTPException to return the error response
        raise e
    except Exception as e:
        # Handle any other exceptions and return a generic error message
        raise HTTPException(status_code=500, detail="An error occurred while processing the request.")