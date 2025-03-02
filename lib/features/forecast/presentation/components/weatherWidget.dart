import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../../domain/model/forecast_model.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    super.key,
    required this.isToday,
    required this.day,
    required this.cityName,
    this.prediction = -1,
  });

  final bool isToday;
  final ForecastDay day;
  final String cityName;
  final int prediction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isToday ? "TODAY" : DateFormat('EEEE').format(day.date),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              Image.network(
                "https:${day.conditionIcon}",
                width: constraints.maxWidth * 0.35,
                height: constraints.maxWidth * 0.35,
                fit: BoxFit.cover,
                errorBuilder: (context, object, stackTrace) {
                  return const Icon(Icons.error_outline,
                      size: 50, color: Colors.grey);
                },
              ),
              Text(
                cityName,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '${day.temperature}°C',
                style: TextStyle(
                  fontSize: constraints.maxWidth * 0.12,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              Text(
                day.condition,
                style: TextStyle(
                  fontSize: constraints.maxWidth * 0.07,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              // New Bar Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildInfoColumn(
                        "Time", DateFormat('HH:mm').format(DateTime.now())),
                    _buildInfoColumn("UV", "${day.uv}"),
                    _buildInfoColumn("Rain", "${day.rainChance}%"),
                    _buildInfoColumn("AQ", "${day.airQuality}"),
                  ],
                ),
              ),
              if (prediction == 0 || prediction == 1)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: prediction == 1
                          ? Colors.lightGreen[100]
                          : Colors.amber[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: prediction == 1
                            ? Colors.lightGreen[600]!
                            : Colors.amber[600]!,
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          prediction == 1
                              ? Icons.thumb_up_alt_outlined
                              : Icons.warning_amber_outlined,
                          size: 36,
                          color: prediction == 1
                              ? Colors.lightGreen[800]!
                              : Colors.amber[800]!,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          getMessageForPrediction(prediction),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: prediction == 1
                                ? Colors.lightGreen[800]!
                                : Colors.amber[800]!,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              if (prediction == -1)
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoColumn(String header, String value) {
    return Column(
      children: [
        Text(
          header,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  String getMessageForPrediction(int prediction) {
    final List<String> goodWeatherMessages = [
      "Perfect day for outdoor fun!",
      "Enjoy the beautiful weather!",
      "A great day to explore!",
      "Ideal weather for any activity!",
    ];

    final List<String> badWeatherMessages = [
      "Stay indoors if possible.",
      "Consider postponing outdoor plans.",
      "Not the best weather to be outside.",
      "Might be best to stay cozy inside.",
    ];

    final random = Random();
    if (prediction == 1) {
      return goodWeatherMessages[random.nextInt(goodWeatherMessages.length)];
    } else {
      return badWeatherMessages[random.nextInt(badWeatherMessages.length)];
    }
  }
}
