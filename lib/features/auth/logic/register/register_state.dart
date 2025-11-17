enum RegisterStatus { initial, loading, success, failure }

class RegisterState {
  final String email;
  final String password;
  final String confirmPassword;
  final RegisterStatus status;
  final String? error;

  RegisterState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.status = RegisterStatus.initial,
    this.error,
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    RegisterStatus? status,
    String? error,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
