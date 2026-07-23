import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/features/auth/domain/entities/app_user.dart';
import 'package:todo_app/features/auth/domain/repo/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  static bool _isGoogleInitialized = false;
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return AppUser(email: user.email!, uid: user.uid);
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user!;
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
        });
      }

      return AppUser(email: email, uid: userCredential.user!.uid);
    } catch (e) {
      throw Exception("Signup Failed: $e");
    }
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

  Future<void> initGoogleSignIn() async {
    if (!_isGoogleInitialized) {
      await GoogleSignIn.instance.initialize();
      _isGoogleInitialized = true;
    }
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    UserCredential userCredential;
    try {
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        await initGoogleSignIn();
        final GoogleSignInAccount? user = await GoogleSignIn.instance
            .authenticate();

        if (user == null) {
          throw Exception("Google Sign-In cancelled by user.");
        }

        final googleAuth = user.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(credential);
      }
      final user = userCredential.user!;
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
        });
      }
      return AppUser(email: user.email!, uid: user.uid);
    } catch (e) {
      throw Exception("Google sign-in failed: $e");
    }
  }

  @override
  Future<void> logout() async {
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
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("user not found");
    await user.delete();
    await logout();
  }
}
