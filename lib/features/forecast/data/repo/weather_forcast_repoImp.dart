import '../../domain/model/forecast_model.dart';
import '../../domain/repo/weather_forecast_repo.dart';
import '../data resource/weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<Forecast> getForecast(String cityName) async {
    return await remoteDataSource.getForecast(cityName);
  }

  @override
  Future<Forecast> getForecastByLocation(
      double latitude, double longitude) async {
    return await remoteDataSource.getForecastByLocation(latitude, longitude);
  }
}
