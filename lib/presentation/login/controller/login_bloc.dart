import 'package:code_nexus/core/repository/auth_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/model/user_model.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<LogInWithGithub>(onLoginWithGithub);
  }
  void onLoginWithGithub(
      LogInWithGithub event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final user = await _authRepository.loginWithGithub();
      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginFailure("User is empty"));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
