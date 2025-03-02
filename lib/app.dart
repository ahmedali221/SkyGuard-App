import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/features/auth/data/data%20Resource/auth_data_resource.dart';
import 'package:weather_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/presentation/pages/loginPage.dart';
import 'package:weather_app/features/auth/presentation/pages/signup.dart';
import 'package:weather_app/features/forecast/data/repo/weather_forcast_repoImp.dart';
import 'package:weather_app/features/forecast/presentation/Weather%20Cubit/weather_cubit.dart';
import 'package:weather_app/features/introduction/pages/introductionDemo.dart';

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
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            headlineLarge: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headlineMedium: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
            bodyLarge: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.grey[800],
            ),
            bodyMedium: GoogleFonts.openSans(
              fontSize: 25,
              color: const Color.fromARGB(255, 71, 71, 71),
            ),
            bodySmall: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 71, 71, 71),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              iconColor: Colors.black,
              backgroundColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              side: BorderSide(color: Colors.blue[200]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue[400]!),
            ),
            hintStyle: TextStyle(color: Colors.grey[500]), // Updated hint color
            labelStyle: TextStyle(color: Colors.grey[700]),
          ),
        ),
        routes: {
          '/': (context) => IntroScreenDemo(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/weather': (context) => WeatherPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
