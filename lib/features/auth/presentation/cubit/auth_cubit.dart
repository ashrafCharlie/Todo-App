import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/domain/entities/app_user.dart';
import 'package:todo_app/features/auth/domain/repo/auth_repo.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  AppUser? _currentUser;
  AuthCubit(this._authRepo) : super(AuthInit());

  AppUser? get currentUser => _currentUser;

  void checkAuth() async {
    emit(AuthLoading());

    final AppUser? user = await _authRepo.getCurrentUser();
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
      final user = await _authRepo.loginWithEmailPassword(email, pass);
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
      final user = await _authRepo.registerWithEmailPassword(email, pass);
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

    try {
      print("Logout cubit method");
      await _authRepo.logout();
      emit(UnAuthenticate());
    } catch (e) {
      emit(AuthError(errorMsg: e.toString()));
    }
  }

  Future<String> forgetPassword(String email) async {
    try {
      final msg = await _authRepo.resetAccount(email);
      return msg;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deleteAccount() async {
    emit(AuthLoading());
    try {
      await _authRepo.deleteAccount();
      emit(UnAuthenticate());
    } catch (e) {
      emit(AuthError(errorMsg: e.toString()));
      emit(UnAuthenticate());
    }
  }
}
