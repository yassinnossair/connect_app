import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_state.freezed.dart';

// The status can now only be initial or loading.
enum SignUpStatus { initial, loading }

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(SignUpStatus.initial) SignUpStatus status,
  }) = _SignUpState;
}