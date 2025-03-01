import '../../domain/model/forecast_model.dart';

abstract class ForecastState {}

class ForecastInitial extends ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastLoaded extends ForecastState {
  final Forecast forecast;
  ForecastLoaded(this.forecast);
}

class ForecastError extends ForecastState {
  final String message;
  ForecastError(this.message);
}
