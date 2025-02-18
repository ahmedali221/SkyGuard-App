import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/model/forecast_model.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    super.key,
    required this.isToday,
    required this.day,
  });

  final bool isToday;
  final ForecastDay day;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isToday ? "TODAY" : DateFormat('EEEE').format(day.date),
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Image.network(
                  "https:${day.conditionIcon}",
                  width: constraints.maxWidth * 0.25,
                  height: constraints.maxWidth * 0.25,
                  fit: BoxFit.cover,
                  errorBuilder: (context, object, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${day.temperature}°C',
                      style: TextStyle(fontSize: constraints.maxWidth * 0.10),
                    ),
                    Text(
                      day.condition,
                      style: TextStyle(fontSize: constraints.maxWidth * 0.06),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
