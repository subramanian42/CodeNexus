part of 'auth_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

final class AuthState {
  const AuthState._({
    required this.status,
    this.user = User.empty,
  });

  const AuthState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AuthState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;
}
