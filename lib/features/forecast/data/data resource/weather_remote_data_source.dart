import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../domain/model/forecast_model.dart';

class WeatherRemoteDataSource {
  final String apiKey = 'c056fb5428cf41edab2210401251702';
  final String baseUrl = 'https://api.weatherapi.com/v1/forecast.json';

  Future<Forecast> getForecast(String cityName) async {
    final url =
        Uri.parse('$baseUrl?key=$apiKey&q=$cityName&days=3&aqi=no&alerts=no');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final cityName = jsonData['location']['name'];

      final forecastDaysData = jsonData['forecast']['forecastday'] as List;
      List<ForecastDay> forecastDays = forecastDaysData.map((item) {
        final date = DateTime.parse(item['date']);
        final temperature = item['day']['maxtemp_c'];
        final condition = item['day']['condition']['text'];
        final conditionIcon = item['day']['condition']['icon'];

        return ForecastDay(
          date: date,
          temperature: temperature.toDouble(),
          condition: condition,
          conditionIcon: conditionIcon,
        );
      }).toList();

      return Forecast(cityName: cityName, forecastDays: forecastDays);
    } else {
      throw Exception('Failed to fetch forecast data: ${response.statusCode}');
    }
  }

  Future<Forecast> getForecastByLocation(
      double latitude, double longitude) async {
    final url = Uri.parse(
        '$baseUrl?key=$apiKey&q=$latitude,$longitude&days=3&aqi=no&alerts=no');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['location'] == null ||
            jsonData['forecast'] == null ||
            jsonData['forecast']['forecastday'] == null) {
          throw Exception(
              'Invalid JSON response: Missing location or forecast data');
        }

        final cityName = jsonData['location']['name'] as String;

        final forecastDaysData = jsonData['forecast']['forecastday'] as List;

        List<ForecastDay> forecastDays = forecastDaysData.map((item) {
          final dateString = item['date'] as String?;
          final temperature = item['day']['maxtemp_c'] as num?;
          final condition = item['day']['condition']['text'] as String?;
          final conditionIcon = item['day']['condition']['icon'] as String?;

          if (dateString == null ||
              temperature == null ||
              condition == null ||
              conditionIcon == null) {
            throw Exception(
                'Invalid forecast data: Missing fields in forecast day');
          }

          final date = DateTime.parse(dateString);

          return ForecastDay(
            date: date,
            temperature: temperature.toDouble(),
            condition: condition,
            conditionIcon: conditionIcon,
          );
        }).toList();

        return Forecast(cityName: cityName, forecastDays: forecastDays);
      } else {
        throw Exception(
            'Failed to fetch forecast data: Status code ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
