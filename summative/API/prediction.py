from fastapi import FastAPI
from pydantic import BaseModel, Field
import joblib
import numpy as np
import os
import pandas as pd
from fastapi.middleware.cors import CORSMiddleware
from sklearn.preprocessing import StandardScaler

# Load the trained model
current_dir = os.path.dirname(__file__)
model_path = os.path.join(current_dir, "best_model.pkl")
scaler_path = os.path.join(current_dir, "scaler.pkl")

model = joblib.load(model_path)
scaler = joblib.load(scaler_path)  # ✅ Load the trained scaler

# Define input features
features = ['Day', 'Temperature', 'MC(%)', 'pH', 'C/N Ratio', 'Ammonia(mg/kg)',
            'Nitrate(mg/kg)', 'TN(%)', 'TOC(%)', 'EC(ms/cm)', 'OM(%)', 'T Value', 'GI(%)']

# Initialize FastAPI app
app = FastAPI(
    title="Compost Maturity Prediction API",
    description="This API predicts compost maturity based on environmental and chemical parameters.",
    version="1.0.0",
    docs_url="/docs",  # Default is `/docs`
    redoc_url="/redoc"
)

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define input data model using Pydantic
class CompostInput(BaseModel):
    day: int = Field(..., ge=0, description="Days since composting started")
    temperature: float = Field(..., ge=0, le=100, description="Temperature in Celsius")
    mc: float = Field(..., ge=0, le=100, description="Moisture Content (%)")
    ph: float = Field(..., ge=0, le=14, description="pH level")
    cn_ratio: float = Field(..., ge=0, description="Carbon-to-Nitrogen ratio")
    ammonia: float = Field(..., ge=0, description="Ammonia (mg/kg)")
    nitrate: float = Field(..., ge=0, description="Nitrate (mg/kg)")
    tn: float = Field(..., ge=0, description="Total Nitrogen (%)")
    toc: float = Field(..., ge=0, description="Total Organic Carbon (%)")
    ec: float = Field(..., ge=0, description="Electrical Conductivity (ms/cm)")
    om: float = Field(..., ge=0, description="Organic Matter (%)")
    t_value: float = Field(..., ge=0, description="Transformation Value")
    gi: float = Field(..., ge=0, description="Germination Index (%)")

@app.post("/predict/")
def predict_compost_maturity(data: CompostInput):
    """Predict compost maturity score based on input features."""
    # Convert input to array
    input_features = np.array([[data.day, data.temperature, data.mc, data.ph, data.cn_ratio, 
                                data.ammonia, data.nitrate, data.tn, data.toc, 
                                data.ec, data.om, data.t_value, data.gi]])

    # Scale input features before prediction using the correct scaler
    input_scaled = scaler.transform(input_features)  # ✅ Now using the correct scaler

    # Make prediction
    predicted_score = model.predict(input_scaled)[0]

    return {"predicted_compost_maturity_score": round(predicted_score, 5)}  # ✅ Match precision

@app.get("/")
def home():
    return {"message": "Welcome to the Compost Maturity Prediction API"}
