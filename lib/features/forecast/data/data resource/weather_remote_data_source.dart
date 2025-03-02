import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../domain/model/forecast_model.dart';

class WeatherRemoteDataSource {
  final String apiKey = 'c056fb5428cf41edab2210401251702';
  final String baseUrl = 'https://api.weatherapi.com/v1/forecast.json';

  Future<Forecast> getForecast(String cityName) async {
    final url =
<<<<<<< HEAD
        Uri.parse('$baseUrl?key=$apiKey&q=$cityName&days=3&aqi=yes&alerts=no');
=======
        Uri.parse('$baseUrl?key=$apiKey&q=$cityName&days=3&aqi=no&alerts=no');
>>>>>>> e94cac065677c722f1f08d6badcb74b14e21e408
    try {
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
<<<<<<< HEAD
          final uv = item['day']['uv'].toDouble();
          final rainChance = item['day']['daily_chance_of_rain'];
          final airQuality = item['day']['air_quality']['us-epa-index'];
=======
>>>>>>> e94cac065677c722f1f08d6badcb74b14e21e408

          return ForecastDay(
            date: date,
            temperature: temperature.toDouble(),
            condition: condition,
            conditionIcon: conditionIcon,
<<<<<<< HEAD
            uv: uv,
            rainChance: rainChance,
            airQuality: airQuality,
=======
>>>>>>> e94cac065677c722f1f08d6badcb74b14e21e408
          );
        }).toList();

        return Forecast(cityName: cityName, forecastDays: forecastDays);
      } else {
        throw Exception(
            'Failed to fetch forecast data: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Forecast> getForecastByLocation(
      double latitude, double longitude) async {
    final url = Uri.parse(
        '$baseUrl?key=$apiKey&q=$latitude,$longitude&days=3&aqi=yes&alerts=no');
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
          final uv = item['day']['uv'] as num?;
          final rainChance = item['day']['daily_chance_of_rain'] as int?;
          final airQuality = item['day']['air_quality']['us-epa-index'] as int?;

          if (dateString == null ||
              temperature == null ||
              condition == null ||
              conditionIcon == null ||
              uv == null ||
              rainChance == null ||
              airQuality == null) {
            throw Exception(
                'Invalid forecast data: Missing fields in forecast day');
          }

          final date = DateTime.parse(dateString);

          return ForecastDay(
            date: date,
            temperature: temperature.toDouble(),
            condition: condition,
            conditionIcon: conditionIcon,
            uv: uv.toDouble(),
            rainChance: rainChance,
            airQuality: airQuality,
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

  Future<int> predictWeather(ForecastDay forecastDay) async {
    try {
      List<int> features = _translateWeatherToFeatures(forecastDay);
<<<<<<< HEAD

      final url = Uri.parse('http://192.168.1.4:5001/predict');
=======
      print("Features being sent to API: $features");

      final url = Uri.parse('http://192.168.1.8:5001/predict');
>>>>>>> e94cac065677c722f1f08d6badcb74b14e21e408

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'features': [features], // Wrap features in a list to make it 2D
        }),
      );

<<<<<<< HEAD
=======
      print("API Response: ${response.body}");

>>>>>>> e94cac065677c722f1f08d6badcb74b14e21e408
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // Check if 'prediction' key exists and is a list
        if (jsonData.containsKey('prediction') &&
            jsonData['prediction'] is List) {
          final predictionList = jsonData['prediction'] as List;

          // Ensure the list is not empty and contains an integer
          if (predictionList.isNotEmpty && predictionList[0] is int) {
            final prediction = predictionList[0];
<<<<<<< HEAD
=======
            print("Prediction from API: $prediction");
>>>>>>> e94cac065677c722f1f08d6badcb74b14e21e408
            return prediction;
          } else {
            throw Exception(
                'Invalid prediction format: Prediction list is empty or not an integer');
          }
        } else {
          throw Exception(
              'Invalid prediction format: Missing or invalid "prediction" key');
        }
      } else {
        throw Exception(
            'Failed to get prediction: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
<<<<<<< HEAD
      print(e.toString());
=======
      print("Prediction Error: ${e.toString()}");
>>>>>>> e94cac065677c722f1f08d6badcb74b14e21e408
      return -1;
    }
  }

  List<int> _translateWeatherToFeatures(ForecastDay forecastDay) {
    final condition = forecastDay.condition.toLowerCase();

    int outlookRainy = condition.contains('rain') ? 1 : 0;

    int outlookSunny = condition.contains('sunny') ? 1 : 0;

    int temperatureHot = forecastDay.temperature > 25 ? 1 : 0;

    int temperatureMild =
        forecastDay.temperature >= 15 && forecastDay.temperature <= 25 ? 1 : 0;

    int humidityNormal = condition.contains('clear') ? 1 : 0;

    return [
      outlookRainy,
      outlookSunny,
      temperatureHot,
      temperatureMild,
      humidityNormal
    ];
  }
}
