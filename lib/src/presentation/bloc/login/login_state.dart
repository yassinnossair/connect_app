import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

enum LoginStatus { initial, loading }

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(LoginStatus.initial) LoginStatus status,
  }) = _LoginState;
}
