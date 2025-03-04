import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repo/weather_forecast_repo.dart';
import 'weather_states.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final WeatherRepository weatherRepositry;

  ForecastCubit({required this.weatherRepositry}) : super(ForecastInitial());

  Future<void> getForecast(String cityName) async {
    emit(ForecastLoading());
    try {
      final forecast = await weatherRepositry.getForecast(cityName);
      emit(ForecastLoaded(forecast));
    } catch (e) {
      // this is a new update
      emit(ForecastError(e.toString()));
    }
  }

  Future<void> getForecastByLocation(double latitude, double longitude) async {
    emit(ForecastLoading());
    try {
      final forecast =
          await weatherRepositry.getForecastByLocation(latitude, longitude);
      emit(ForecastLoaded(forecast));
    } catch (e) {
      emit(ForecastError(e.toString()));
    }
  }

  void clearForecast() {
    emit(ForecastInitial());
  }
}
