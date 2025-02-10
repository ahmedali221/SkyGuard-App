import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/domain/repo/user_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepo repository;

  AuthCubit(this.repository) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await repository.loginUser(email, password);
      emit(AuthAuthenticated(user!));
    } catch (e) {
      emit(AuthError('Login failed: $e'));
    }
  }

  Future<void> signup(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      final user = await repository.signup(email, password, name);
      emit(AuthAuthenticated(user!));
    } catch (e) {
      emit(AuthError('Signup failed: $e'));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await repository.logoutUser();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Logout failed: $e'));
    }
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      final user = await repository.checkAuthStatus();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError('Failed to check auth status: $e'));
    }
  }
}
