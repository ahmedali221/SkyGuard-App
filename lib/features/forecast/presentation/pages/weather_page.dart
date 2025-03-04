import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/widgets/customTextInput.dart';
import 'package:weather_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/presentation/cubit/auth_states.dart';
import '../../data/data resource/weather_remote_data_source.dart';
import '../Weather Cubit/weather_cubit.dart';
import '../Weather Cubit/weather_states.dart';
import '../components/weatherWidget.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final TextEditingController _cityController;
  Position? _currentPosition;
  final WeatherRemoteDataSource _weatherRemoteDataSource =
      WeatherRemoteDataSource();

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _currentPosition = await Geolocator.getCurrentPosition();
    if (_currentPosition != null) {
      _getForecastByLocation(_currentPosition!);
    }
  }

  void _getForecastByLocation(Position position) {
    context
        .read<ForecastCubit>()
        .getForecastByLocation(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState is AuthAuthenticated) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "SkyGuard",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 35,
                    ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  onPressed: () {
                    context.read<AuthCubit>().logout();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Greeting and city input
                    Text(
                      "Hi, ${authState.user.name}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: _cityController,
                      labelText: 'City',
                      hintText: 'Enter city name',
                      icon: Icons.location_on,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a city name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_cityController.text.isNotEmpty) {
                          context
                              .read<ForecastCubit>()
                              .getForecast(_cityController.text);
                        }
                      },
                      child: const Text('Get Forecast'),
                    ),
                    const SizedBox(height: 16),

                    // Weather forecast grid
                    Expanded(
                      child: BlocBuilder<ForecastCubit, ForecastState>(
                        builder: (context, state) {
                          if (state is ForecastLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ForecastLoaded) {
                            final forecast = state.forecast;
                            return Column(
                              children: [
                                Text(
                                  // this shows the name of the city
                                  forecast.cityName,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          MediaQuery.of(context).size.width >
                                                  600
                                              ? 3
                                              : 2,
                                      childAspectRatio: 0.8,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemCount: forecast.forecastDays.length,
                                    itemBuilder: (context, index) {
                                      final day = forecast.forecastDays[index];
                                      final isToday = day.date.day ==
                                              DateTime.now().day &&
                                          day.date.month ==
                                              DateTime.now().month &&
                                          day.date.year == DateTime.now().year;

                                      return FutureBuilder<int>(
                                        future: _weatherRemoteDataSource
                                            .predictWeather(day),
                                        builder: (context, predictionSnapshot) {
                                          int prediction = -1;
                                          if (predictionSnapshot.hasData) {
                                            prediction =
                                                predictionSnapshot.data!;
                                          }

                                          return WeatherWidget(
                                            isToday: isToday,
                                            day: day,
                                            prediction: prediction,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else if (state is ForecastError) {
                            return Center(child: Text(state.message));
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
