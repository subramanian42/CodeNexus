import 'dart:async';

import 'package:code_nexus/core/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authenticationRepository})
      : _authRepository = authenticationRepository,
        super(AuthSuccess(currentUser: User.empty)) {
    on<AppUserChanged>(onAppUserChanged);
    on<AppLogoutRequested>(onAppLogoutRequested);
    _userSubscription = _authRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }
  late final StreamSubscription<User> _userSubscription;

  void onAppUserChanged(AppUserChanged event, Emitter<AuthState> emit) async {
    try {
      emit(event.user.isNotEmpty
          ? AuthSuccess(currentUser: event.user)
          : AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void onAppLogoutRequested(AppLogoutRequested event, Emitter<AuthState> emit) {
    _authRepository.logout();
    emit(AuthInitial());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
