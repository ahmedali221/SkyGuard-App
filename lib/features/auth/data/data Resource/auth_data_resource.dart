// data/data_sources/auth_remote_data_source.dart
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<AppUser> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AppUser(
        name: userCredential.user!.displayName ?? 'No Name',
        email: userCredential.user!.email!,
        password: password, // Store the password for consistency
      );
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<AppUser> signup(String email, String password, String name) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(name);
      return AppUser(
        name: name,
        email: userCredential.user!.email!,
        password: password,
      );
    } catch (e) {
      print(e);
      throw Exception('Signup failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<AppUser?> checkAuthStatus() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        return AppUser(
          name: user.displayName ?? 'No Name',
          email: user.email!,
          password: '',
        );
      }
      return null;
    } catch (e) {
      throw Exception('Failed to check auth status: $e');
    }
  }
}
