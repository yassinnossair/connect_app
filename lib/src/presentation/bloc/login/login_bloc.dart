import 'package:bloc/bloc.dart';
import 'package:connect/src/domain/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginWithEmailAndPasswordPressed>(_onLoginWithEmailAndPasswordPressed);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginWithEmailAndPasswordPressed(
      LoginWithEmailAndPasswordPressed event,
      Emitter<LoginState> emit,
      ) async {
    if (state.status == LoginStatus.loading) return;
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _authRepository.logInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      // On success, we do nothing. The AuthBloc handles navigation.
    } catch (_) {
      // On ANY failure, we simply reset the state to initial.
      // This stops the loading spinner and allows the user to try again.
      // No error message is shown on screen. This fixes the bug.
      emit(state.copyWith(status: LoginStatus.initial));
    }
  }
}