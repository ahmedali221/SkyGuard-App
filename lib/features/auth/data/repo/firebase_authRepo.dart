import 'package:weather_app/features/auth/domain/repo/user_repo.dart';

import '../../domain/entities/user.dart';
import '../data Resource/auth_data_resource.dart';

class AuthRepositoryImpl implements UserRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AppUser> loginUser(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<AppUser> signup(String email, String password, String name) async {
    return await remoteDataSource.signup(email, password, name);
  }

  @override
  Future<void> logoutUser() async {
    await remoteDataSource.logout();
  }

  @override
  Future<AppUser?> checkAuthStatus() async {
    return await remoteDataSource.checkAuthStatus();
  }
}
