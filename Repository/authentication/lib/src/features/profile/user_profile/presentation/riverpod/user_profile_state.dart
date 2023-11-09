import 'package:equatable/equatable.dart';
import 'package:auth_module/src/features/profile/root/domain/entities/profile_entity.dart';

enum UserProfileStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == UserProfileStatus.loading;
  bool get isSuccess => this == UserProfileStatus.success;
  bool get isFailure => this == UserProfileStatus.failure;
}

class UserProfileState extends Equatable {
  UserProfileState({
    this.status = UserProfileStatus.initial,
    this.data,
    this.error,
  });

  final UserProfileStatus status;
  ProfileEntity? data;
  final String? error;

  UserProfileState copyWith({
    UserProfileStatus? status,
    ProfileEntity? data,
    String? error,
  }) {
    return UserProfileState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, data, error];
}
