part of 'identity_verification_notifier.dart';

enum IdentityVerificationStatus { initial, loading, success, failure }

class IdentityVerificationState extends Equatable {
  const IdentityVerificationState({
    this.status = IdentityVerificationStatus.initial,
    this.email = '',
    this.otp = '',
    this.errorMessage = '',
  });

  final IdentityVerificationStatus status;
  final String email;
  final String otp;
  final String errorMessage;

  IdentityVerificationState copyWith({
    IdentityVerificationStatus? status,
    String? email,
    String? otp,
    String? errorMessage,
  }) {
    return IdentityVerificationState(
      status: status ?? this.status,
      email: email ?? this.email,
      otp: otp ?? this.otp,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        otp,
        errorMessage,
      ];
}
