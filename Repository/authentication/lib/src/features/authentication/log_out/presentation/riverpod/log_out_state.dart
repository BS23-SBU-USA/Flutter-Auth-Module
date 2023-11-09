part of '../riverpod/log_out_providers.dart';

enum LogOutStatus { initial, success, failure, loading }

class LogOutState extends Equatable {
  const LogOutState({
    this.status = LogOutStatus.initial,
    this.errorMessage = '',
  });

  final LogOutStatus status;
  final String errorMessage;

  LogOutState copyWith({
    LogOutStatus? status,
    String? errorMessage,
  }) {
    return LogOutState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
      ];
}
