import 'package:equatable/equatable.dart';
import 'package:todo_app/features/auth/domain/entities/app_user.dart';

abstract class AuthState extends Equatable {

   List<Object?> get props => [];
}

class AuthInit extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticate extends AuthState {
  final AppUser appUser;
  Authenticate({required this.appUser});
  
  @override
  List<Object?> get props => [appUser];
}

class UnAuthenticate extends AuthState {}

class AuthError extends AuthState {
  final String errorMsg;
  AuthError({required this.errorMsg});
  @override

  List<Object?> get props => [errorMsg];
}
