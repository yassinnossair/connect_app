import 'package:bloc/bloc.dart';
import 'package:connect/src/domain/repositories/auth_repository.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailChanged>(_onEmailChanged);
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(
    ForgotPasswordEmailChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _onSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (state.status == ForgotPasswordStatus.loading) return;
    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    try {
      await _authRepository.sendPasswordResetEmail(email: state.email);

      emit(state.copyWith(status: ForgotPasswordStatus.initial));
    } catch (_) {
      emit(state.copyWith(status: ForgotPasswordStatus.initial));
    }
  }
}
