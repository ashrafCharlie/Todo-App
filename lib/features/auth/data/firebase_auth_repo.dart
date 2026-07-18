import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/features/auth/domain/entities/app_user.dart';
import 'package:todo_app/features/auth/domain/repo/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final _auth = FirebaseAuth.instance;
  @override
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("user not found");
    user.delete();
    await logout();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return AppUser(email: user.email!, uid: user.uid);
  }

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      final userCreadential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AppUser(email: email, uid: userCreadential.user!.uid);
    } catch (e) {
      throw Exception("Login Failed: $e");
    }
  }

  @override
  Future<void> logout() async  {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Logout Failed: $e");
    }
  }

  @override
  Future<String> resetAccount(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "Reset link send succesful";
    } catch (e) {
      throw Exception("Some Error Occured: $e");
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return AppUser(email: email, uid: userCredential.user!.uid);
    } catch (e) {
      throw Exception("Signup Failed: $e");
    }
  }
}
