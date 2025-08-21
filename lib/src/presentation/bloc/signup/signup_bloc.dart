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
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _onConfirmPasswordChanged(
    SignUpConfirmPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(confirmPassword: event.password));
  }

  Future<void> _onSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    if (state.status == SignUpStatus.loading) return;

    if (state.password != state.confirmPassword) {
      return;
    }

    emit(state.copyWith(status: SignUpStatus.loading));
    try {
      await _authRepository.signUp(
        email: state.email,
        password: state.password,
      );
    } catch (_) {
      emit(state.copyWith(status: SignUpStatus.initial));
    }
  }
}
