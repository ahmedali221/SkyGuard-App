import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/model/forecast_model.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    super.key,
    required this.isToday,
    required this.day,
    this.prediction = -1,
  });

  final bool isToday;
  final ForecastDay day;
  final int prediction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Day or "TODAY" label
                Text(
                  isToday ? "TODAY" : DateFormat('EEEE').format(day.date),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),

                // Weather icon
                Image.network(
                  "https:${day.conditionIcon}",
                  width: constraints.maxWidth * 0.3,
                  height: constraints.maxWidth * 0.3,
                  fit: BoxFit.cover,
                  errorBuilder: (context, object, stackTrace) {
                    return const Icon(Icons.error, size: 50);
                  },
                ),
                const SizedBox(height: 8),

                // Temperature
                Text(
                  '${day.temperature}°C',
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Weather condition
                Text(
                  day.condition,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.06,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Prediction result
                if (prediction == 0 || prediction == 1)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color:
                          prediction == 1 ? Colors.green[50] : Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: prediction == 1 ? Colors.green : Colors.red,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      getMessageForPrediction(prediction),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxWidth * 0.042,
                        color: prediction == 1 ? Colors.green : Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (prediction == -1)
                  Text(
                    "Prediction unavailable.",
                    style: TextStyle(
                      fontSize: constraints.maxWidth * 0.05,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getMessageForPrediction(int prediction) {
    if (prediction == 1) {
      return "Great day for outdoor activities!";
    } else {
      return "It might not be the best time to go outside.";
    }
  }
}
