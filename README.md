# 🌱 Compost Maturity Predictor API & Mobile App

## 📌 Project Overview
This project provides an API that predicts **compost maturity** based on environmental and chemical parameters.  
It includes a **Flutter mobile app** that interacts with the FastAPI backend to deliver real-time predictions.

---

## 🌍 Public API Endpoint

**Swagger UI (for testing):**  
```
https://your-api-deployment-url.onrender.com/docs
```

---

## 🔄 Sample Request Payload (POST `/predict/`)
```json
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
The prediction should or be close to 59.69828181
---

## 🎥 YouTube Demo

📺 **Watch the short 3-minute demo video of this project:**  
[🔗 YouTube Link](https://your-youtube-demo-link.com)

---

## 📱 How to Run the Flutter Mobile App

### 1️⃣ Install Flutter SDK
If not already installed, follow the [Flutter installation guide](https://docs.flutter.dev/get-started/install).

Verify installation:
```bash
flutter doctor
```

---

### 2️⃣ Clone This Repository
```bash
git clone https://github.com/Annemarie535257/linear_regression_model.git
cd linear_regression_model/flutter_app
```

---

### 3️⃣ Install Flutter Dependencies
```bash
flutter pub get
```

---

### 4️⃣ Update the API Endpoint in `main.dart`
In your Flutter app, find:
```dart
final url = Uri.parse('http://10.0.2.2:8500/predict/');
```
Replace with your public API URL:
```dart
final url = Uri.parse('https://your-api-deployment-url.onrender.com/predict/');
```

---

### 5️⃣ Run the App
```bash
flutter run
```

✅ You can also run on a specific device or emulator.

---


## 🔐 Note on Model and Dataset

To keep the repository clean, large files like the model (`.pkl`) and dataset (`.csv`) are **not pushed to GitHub**.  
Instead, they are automatically **downloaded at runtime using a script** (e.g. from Google Drive).

---

## 🛠️ Technologies Used

- **Flutter** – Mobile UI
- **FastAPI** – Backend API
- **scikit-learn** – Model training
- **pandas / numpy** – Data processing
- **Swagger UI** – API documentation

---

## 👩‍💻 Author

**Annemarie T.**  
GitHub: [@Annemarie535257](https://github.com/Annemarie535257)  
Email: _a.twagiraye@alustudent.com_

---