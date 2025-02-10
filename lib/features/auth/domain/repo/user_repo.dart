import 'package:weather_app/features/auth/domain/entities/user.dart';

abstract class UserRepo {
  Future<AppUser?> signup(String name, String email, String password);
  Future<AppUser?> loginUser(String email, String password);
  Future<void> logoutUser();
  Future<AppUser?> checkAuthStatus();
}
