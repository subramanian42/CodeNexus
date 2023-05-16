part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User? currentUser;
  AuthSuccess({required this.currentUser});
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
