part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  UserModel user;
  LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  String error;
  LoginFailure(this.error);
}
