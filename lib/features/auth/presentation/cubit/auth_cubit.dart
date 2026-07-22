import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/data/firebase_auth_repo.dart';
import 'package:todo_app/features/auth/domain/entities/app_user.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthRepo firebaseAuthRepo;
  AppUser? _currentUser;
  AuthCubit({required this.firebaseAuthRepo}) : super(AuthInit());

  AppUser? get currentUser => _currentUser;

  void checkAuth() async {
    emit(AuthLoading());

    final AppUser? user = await firebaseAuthRepo.getCurrentUser();
    if (user != null) {
      _currentUser = user;
      emit(Authenticate(appUser: user));
    } else {
      emit(UnAuthenticate());
    }
  }

  Future<void> login(String email, String pass) async {
    emit(AuthLoading());
    try {
      final user = await firebaseAuthRepo.loginWithEmailPassword(email, pass);
      if (user != null) {
        _currentUser = user;
        emit(Authenticate(appUser: user));
      } else {
        emit(UnAuthenticate());
      }
    } catch (e) {
      emit(AuthError(errorMsg: e.toString()));
    }
  }

  Future<void> register(String email, String pass) async {
    emit(AuthLoading());
    try {
      final user = await firebaseAuthRepo.registerWithEmailPassword(
        email,
        pass,
      );
      if (user != null) {
        _currentUser = user;
        emit(Authenticate(appUser: user));
      } else {
        emit(UnAuthenticate());
      }
    } catch (e) {
      emit(AuthError(errorMsg: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await firebaseAuthRepo.logout();
    emit(UnAuthenticate());
  }

  Future<String> forgetPassword(String email) async {
    try {
      final msg = await firebaseAuthRepo.resetAccount(email);
      return msg;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deleteAccount() async {
    emit(AuthLoading());
    try {
      await firebaseAuthRepo.deleteAccount();
      await firebaseAuthRepo.logout();
      emit(UnAuthenticate());
    } catch (e) {
      emit(AuthError(errorMsg: e.toString()));
      emit(UnAuthenticate());
    }
  }
}
