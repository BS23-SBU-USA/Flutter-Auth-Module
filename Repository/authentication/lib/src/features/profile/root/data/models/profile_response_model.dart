import 'package:auth_module/src/features/profile/root/data/models/profile_model.dart';

class ProfileResponseModel {
  ProfileResponseModel({
    required this.data,
    required this.message,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      message: json['message'],
      data: ProfileModel.fromJson(json['data']),
    );
  }
  final ProfileModel data;
  final String message;
}
