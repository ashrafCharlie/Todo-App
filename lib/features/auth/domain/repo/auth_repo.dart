import 'package:todo_app/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String uid);
  Future<AppUser?> signUpWithEmailPassword(String email, String uid);
  Future<String> resetAccount(String email);
  Future<void> deleteAccount();
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}
