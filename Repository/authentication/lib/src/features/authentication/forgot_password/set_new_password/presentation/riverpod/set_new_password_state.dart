part of 'set_new_password_notifier.dart';

enum SetNewPasswordStatus { initial, loading, success, failure }

class SetNewPasswordState extends Equatable {
  const SetNewPasswordState({
    this.status = SetNewPasswordStatus.initial,
    this.newPassword = '',
    this.confirmPassword = '',
    this.errorMessage = '',
  });

  final SetNewPasswordStatus status;
  final String newPassword;
  final String confirmPassword;
  final String errorMessage;

  SetNewPasswordState copyWith({
    SetNewPasswordStatus? status,
    String? newPassword,
    String? confirmPassword,
    String? errorMessage,
  }) {
    return SetNewPasswordState(
      status: status ?? this.status,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        newPassword,
        confirmPassword,
        errorMessage,
      ];
}
