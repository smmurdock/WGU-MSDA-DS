#!/usr/bin/env python
# coding: utf-8

from fastapi.testclient import TestClient
from app import app

client = TestClient(app)

def test_root():
    """Test root endpoint - correctly formatted request."""
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "API is functional."}


def test_predict_delays_valid():
    """Test /predict/delays endpoint with valid input - correctly formatted request."""
    response = client.get("/predict/delays", params={
        "arrival_airport": "JFK",
        "departure_time": "14:30",
        "arrival_time": "18:30"
    })
    assert response.status_code == 200
    assert "predicted_delay" in response.json()
    assert isinstance(response.json()["predicted_delay"], float)


def test_predict_delays_invalid_airport():
    """Test /predict/delays with invalid airport code - incorrectly formatted request."""
    response = client.get("/predict/delays", params={
        "arrival_airport": "INVALID",
        "departure_time": "14:30",
        "arrival_time": "18:30"
    })
    assert response.status_code == 400
    assert response.json() == {"detail": "Invalid arrival airport code"}