import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/features/auth/data/data%20Resource/auth_data_resource.dart';
import 'package:weather_app/features/auth/presentation/cubit/auth_cubit.dart'; // Import your AuthCubit
import 'package:weather_app/features/auth/presentation/pages/loginPage.dart';
import 'package:weather_app/features/auth/presentation/pages/signup.dart';
import 'package:weather_app/features/forecast/data/repo/weather_forcast_repoImp.dart';
import 'package:weather_app/features/forecast/presentation/Weather%20Cubit/weather_cubit.dart';

import 'features/auth/data/repo/firebase_authRepo.dart';
import 'features/forecast/data/data resource/weather_remote_data_source.dart';
import 'features/forecast/presentation/pages/weather_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ForecastCubit(
            weatherRepositry: WeatherRepositoryImpl(WeatherRemoteDataSource()),
          ),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            AuthRepositoryImpl(AuthRemoteDataSource()),
          ),
        ),
      ],
      child: MaterialApp(
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            headlineLarge: GoogleFonts.roboto(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
            bodyMedium: GoogleFonts.oswald(
              fontSize: 25,
              color: const Color.fromARGB(255, 71, 71, 71),
            ),
            bodySmall: GoogleFonts.akatab(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 71, 71, 71),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, iconColor: Colors.black),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
            ),
          ),
        ),
        routes: {
          '/': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/weather': (context) => WeatherPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
