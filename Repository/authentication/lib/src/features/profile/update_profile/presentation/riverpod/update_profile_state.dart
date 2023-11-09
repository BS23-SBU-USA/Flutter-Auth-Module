import 'package:equatable/equatable.dart';
import 'package:auth_module/src/features/profile/root/domain/entities/profile_entity.dart';

enum UpdateProfileStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == UpdateProfileStatus.loading;
  bool get isSuccess => this == UpdateProfileStatus.success;
  bool get isFailure => this == UpdateProfileStatus.failure;
}

class UpdateProfileState extends Equatable {
  UpdateProfileState({
    this.status = UpdateProfileStatus.initial,
    this.data,
    this.error,
  });

  final UpdateProfileStatus status;
  ProfileEntity? data;
  final String? error;

  UpdateProfileState copyWith({
    UpdateProfileStatus? status,
    ProfileEntity? data,
    String? error,
  }) {
    return UpdateProfileState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, data, error];
}
