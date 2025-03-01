import '../model/forecast_model.dart';

abstract class WeatherRepository {
  Future<Forecast> getForecast(String cityName);
  Future<Forecast> getForecastByLocation(double latitude, double longitude);
}
