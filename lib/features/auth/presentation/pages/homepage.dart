import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            // Show loading indicator while checking authentication
            return Center(child: CircularProgressIndicator());
          } else if (state is AuthAuthenticated) {
            // Show home screen content if authenticated
            return Center(
              child: Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${state.user.name}!'),
                  Text('Email: ${state.user.email}'),
                  ElevatedButton(
                    onPressed: () {
                      // Logout the user
                      context.read<AuthCubit>().logout();
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
            );
          } else {
            // Fallback for unknown states
            return Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}
