# 🌱 Compost Maturity Predictor API & Mobile App

## 🌾 How This Supports My Agricultural Mission

As part of my mission to revolutionize the agriculture sector through innovative and sustainable practices, this project directly addresses one of the most overlooked aspects in organic farming: **precision composting**.

By building a tool that predicts compost maturity based on environmental and chemical parameters, I aim to help farmers:
- Apply compost at the **optimal time** for maximum soil health and crop yield
- **Reduce guesswork** and dependency on physical cues alone
- Adopt **data-driven practices** in organic waste recycling and soil management

This aligns with my broader vision to **empower local farmers with accessible technology** that enhances productivity, supports sustainability, and contributes to a circular economy in agriculture.

---

## 📊 About the Dataset

The dataset used in this project was sourced from:  
📂 [Compost Dataset by Hafsa Kibria](https://github.com/hafsa-kibria/Compost-Datasetdataset)

It contains various **chemical and physical properties** measured during composting, including:

| Feature | Description |
|--------|-------------|
| `Day` | Number of days since composting started |
| `Temperature` | Compost temperature (°C) |
| `MC(%)` | Moisture content |
| `pH` | Acidity level |
| `C/N Ratio` | Carbon-to-Nitrogen ratio |
| `Ammonia`, `Nitrate` | Nitrogen-based compounds (mg/kg) |
| `TN(%)` | Total nitrogen |
| `TOC(%)` | Total organic carbon |
| `EC(ms/cm)` | Electrical conductivity |
| `OM(%)` | Organic matter |
| `T Value`, `GI(%)` | Germination Index and maturity indicators |
| `Score` | Compost maturity score (target variable) |

We trained a **linear regression model** on this data to predict the `Score`.

---

## 🔧 How to Run This Project on Your Laptop

### 🔹 1. Clone the Repository
```bash
git clone https://github.com/Annemarie535257/linear_regression_model.git
cd linear_regression_model
```

### 🔹 2. Create and Activate a Virtual Environment
```bash
python -m venv envir
envir\Scripts\activate  # On Windows
```

### 🔹 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 🔹 4. Start the API
```bash
uvicorn summative.API.prediction:app --host 0.0.0.0 --port 8500
```

You should see the server running locally at:  
`http://127.0.0.1:8500`

You can access the Swagger UI for testing here:  
`http://127.0.0.1:8500/docs`

---

## 📱 How the Flutter Mobile App Works

The Flutter app is a **user-friendly interface** that lets farmers and compost managers:
- Enter current compost values (e.g. temperature, pH, moisture)
- Click **"Predict"**
- Instantly get a **maturity score** with an explanation

### 🧠 Behind the Scenes:
- The app sends the entered values to the FastAPI backend via **HTTP POST**.
- The API processes the data and returns a predicted compost score.
- The score is displayed with a message like:
  - "Compost is still in early stages"
  - "Ready for application to soil"

---

## 📡 How the API Works

The FastAPI backend:
- Loads the trained model (`best_model.pkl`)
- Accepts POST requests at `/predict/` with compost values
- Scales the input (if required)
- Returns a JSON response with the **predicted maturity score**

### Sample API Request:
```json
POST /predict/
{
  "day": 12,
  "temperature": 38.955,
  "mc": 45.2203,
  "ph": 8.0177,
  "cn_ratio": 17.0303,
  "ammonia": 814.4,
  "nitrate": 200.52,
  "tn": 1.91893,
  "toc": 32.67995,
  "ec": 3.5596,
  "om": 56.34024,
  "t_value": 0.63604,
  "gi": 79.4691
}
```

### Sample Response:
```json
{
  "predicted_compost_maturity_score": 59.69
}
```

Try it live:  
**Swagger UI:**  
```
https://linear-regression-model-r0fj.onrender.com/docs
```

---

## 🎥 YouTube Demo

📺 Watch the short 3-minute video of how the API and mobile app work together:  
[🔗 YouTube Demo]([https://your-youtube-demo-link.com](https://youtu.be/EseDDkZuox0))

---

## 🛠️ Technologies Used

| Tool | Purpose |
|------|---------|
| **Flutter** | Mobile frontend |
| **FastAPI** | Backend API |
| **Uvicorn** | ASGI server |
| **scikit-learn** | Machine learning model |
| **pandas / numpy** | Data processing |
| **Swagger UI** | API testing and documentation |

---

## 👩‍💻 Author

**Anne Marie T.**  
🎓 Passionate about digital solutions in agriculture  
📬 Email: a.twagiraye@alustudent.com  
💻 GitHub: [@Annemarie535257](https://github.com/Annemarie535257)

---

> Empowering sustainable farming through technology 🌍🌱🚜  
```

---

