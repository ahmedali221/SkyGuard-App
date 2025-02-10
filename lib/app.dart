import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/data/data%20Resource/auth_data_resource.dart';
import 'package:weather_app/features/auth/presentation/cubit/auth_cubit.dart'; // Import your AuthCubit
import 'package:weather_app/features/auth/presentation/pages/loginPage.dart';
import 'package:weather_app/features/auth/presentation/pages/signup.dart';

import 'features/auth/data/repo/firebase_authRepo.dart';
import 'features/auth/presentation/pages/homepage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            AuthRepositoryImpl(AuthRemoteDataSource()),
          ),
        ),
      ],
      child: MaterialApp(
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/home': (context) => HomeScreen(),
        },
        initialRoute: '/',
      ),
    );
  }
}
