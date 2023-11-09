part of 'change_password_provider.dart';

enum ChangePasswordStatus { initial, loading, success, failure }

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = ChangePasswordStatus.initial,
    this.email = '',
    this.errorMessage = '',
  });

  final ChangePasswordStatus status;
  final String email;
  final String errorMessage;

  ChangePasswordState copyWith({
    ChangePasswordStatus? status,
    String? email,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        errorMessage,
      ];
}
