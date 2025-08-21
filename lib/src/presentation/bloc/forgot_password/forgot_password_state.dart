import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

enum ForgotPasswordStatus { initial, loading }

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default('') String email,
    @Default(ForgotPasswordStatus.initial) ForgotPasswordStatus status,
  }) = _ForgotPasswordState;
}
