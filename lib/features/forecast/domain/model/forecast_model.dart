class Forecast {
  final String cityName;
  final List<ForecastDay> forecastDays;

  Forecast({required this.cityName, required this.forecastDays});
}

class ForecastDay {
  final DateTime date;
  final double temperature;
  final String condition;
  final String conditionIcon;

  ForecastDay(
      {required this.date,
      required this.temperature,
      required this.condition,
      required this.conditionIcon});
}
