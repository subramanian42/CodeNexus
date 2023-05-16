part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AppLogoutRequested extends AuthEvent {}

class AppUserChanged extends AuthEvent {
  final User user;

  AppUserChanged(this.user);
}
