import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Compost Maturity Predictor',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.green[50],
      ),
      home: const SplashScreen(),
    );
  }
}

// Splash Screen that appears for 5 seconds
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PredictionPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.eco, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              "Compost Maturity Predictor",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "This tool helps farmers and researchers predict compost maturity based on key environmental and chemical parameters. Enter your data and get an accurate compost maturity score!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PredictionPageState createState() => _PredictionPageState();
}

class ResultPage extends StatelessWidget {
  final double predictionScore;

  const ResultPage({super.key, required this.predictionScore});

  String getPredictionExplanation(double score) {
    if (score >= 80) {
      return "Your compost is fully mature and ready for use!";
    } else if (score >= 50) {
      return "Your compost is partially mature. Allow more time for better results.";
    } else {
      return "Your compost is still in the early stages. Continue the composting process.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prediction Result"),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.eco, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              Text(
                "Predicted Compost Maturity Score:",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                predictionScore.toStringAsFixed(1), // Show one decimal place
                style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 20),
              Text(
                getPredictionExplanation(predictionScore),
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to prediction page
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _PredictionPageState extends State<PredictionPage> {
  _PredictionPageState();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController mcController = TextEditingController();
  final TextEditingController phController = TextEditingController();
  final TextEditingController cnRatioController = TextEditingController();
  final TextEditingController ammoniaController = TextEditingController();
  final TextEditingController nitrateController = TextEditingController();
  final TextEditingController tnController = TextEditingController();
  final TextEditingController tocController = TextEditingController();
  final TextEditingController ecController = TextEditingController();
  final TextEditingController omController = TextEditingController();
  final TextEditingController tValueController = TextEditingController();
  final TextEditingController giController = TextEditingController();
  
  String predictionResult = "";

  Future<void> predictCompostMaturity() async {
  final url = Uri.parse('http://10.0.2.2:8500/predict/');

  final Map<String, dynamic> requestBody = {
    "day": int.tryParse(dayController.text) ?? 0,
    "temperature": double.tryParse(temperatureController.text.replaceAll(',', '.')) ?? 0.0,
    "mc": double.tryParse(mcController.text.replaceAll(',', '.')) ?? 0.0,
    "ph": double.tryParse(phController.text.replaceAll(',', '.')) ?? 0.0,
    "cn_ratio": double.tryParse(cnRatioController.text.replaceAll(',', '.')) ?? 0.0,
    "ammonia": double.tryParse(ammoniaController.text.replaceAll(',', '.')) ?? 0.0,
    "nitrate": double.tryParse(nitrateController.text.replaceAll(',', '.')) ?? 0.0,
    "tn": double.tryParse(tnController.text.replaceAll(',', '.')) ?? 0.0,
    "toc": double.tryParse(tocController.text.replaceAll(',', '.')) ?? 0.0,
    "ec": double.tryParse(ecController.text.replaceAll(',', '.')) ?? 0.0,
    "om": double.tryParse(omController.text.replaceAll(',', '.')) ?? 0.0,
    "t_value": double.tryParse(tValueController.text.replaceAll(',', '.')) ?? 0.0,
    "gi": double.tryParse(giController.text.replaceAll(',', '.')) ?? 0.0,
  };

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      double predictedScore = data['predicted_compost_maturity_score'];

      // Navigate to ResultPage
      // ignore: use_build_context_synchronously
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(predictionScore: predictedScore),
        ),
      );
    } else {
      setState(() {
        predictionResult = "Error: ${response.body}";
      });
    }
  } catch (e) {
    setState(() {
      predictionResult = "Failed to connect to API: $e";
    });
  }
}


  Widget buildTextField(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.green[50], // Light green shade for better look
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Compost Maturity Predictor"),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(Icons.eco, size: 100, color: Colors.green),
              buildTextField("Days", dayController),
              buildTextField("Temperature (°C)", temperatureController),
              buildTextField("Moisture Content (%)", mcController),
              buildTextField("pH", phController),
              buildTextField("C/N Ratio", cnRatioController),
              buildTextField("Ammonia (mg/kg)", ammoniaController),
              buildTextField("Nitrate (mg/kg)", nitrateController),
              buildTextField("Total Nitrogen (%)", tnController),
              buildTextField("Total Organic Carbon (%)", tocController),
              buildTextField("Electrical Conductivity (ms/cm)", ecController),
              buildTextField("Organic Matter (%)", omController),
              buildTextField("Transformation Value", tValueController),
              buildTextField("Germination Index (%)", giController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: predictCompostMaturity,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
                child: const Text("Predict"),
              ),
              const SizedBox(height: 20),
              Text(
                predictionResult.isNotEmpty ? predictionResult : " ",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
