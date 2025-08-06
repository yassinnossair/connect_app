import 'package:bloc/bloc.dart';
import 'package:connect/src/domain/repositories/auth_repository.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignUpSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(
      SignUpPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onConfirmPasswordChanged(
      SignUpConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(confirmPassword: event.password));
  }

  Future<void> _onSubmitted(
      SignUpSubmitted event,
      Emitter<SignUpState> emit,
      ) async {
    if (state.status == SignUpStatus.loading) return;

    // Note: We can still handle simple validation like this before loading.
    if (state.password != state.confirmPassword) {
      // In a real app, you might show a text error here instead of a SnackBar.
      // For now, we just stop.
      return;
    }

    emit(state.copyWith(status: SignUpStatus.loading));
    try {
      await _authRepository.signUp(
        email: state.email,
        password: state.password,
      );
      // On success, we do nothing. The AuthBloc handles navigation.
    } catch (_) {
      // On ANY failure, we simply reset the state to initial.
      // This stops the loading spinner and allows the user to try again.
      emit(state.copyWith(status: SignUpStatus.initial));
    }
  }
}