import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/features/auth/domain/entities/app_user.dart';
import 'package:todo_app/features/auth/domain/repo/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
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
      if(!doc.exists){
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

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
      UserCredential credential;

      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        credential = await _auth.signInWithPopup(provider);
      } else {
        final GoogleSignInAccount account = await GoogleSignIn.instance
            .authenticate();

        final GoogleSignInAuthentication googleAuth = account.authentication;

        final oauthCredential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        credential = await _auth.signInWithCredential(oauthCredential);
      }

      final user = credential.user;
      if (user == null) return null;
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
        });
      }

      return AppUser(uid: user.uid, email: user.email!);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } on GoogleSignInException catch (e) {
      throw Exception(e.code.name);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await GoogleSignIn.instance.signOut();
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
