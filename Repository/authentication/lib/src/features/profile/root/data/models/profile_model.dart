import 'package:auth_module/src/features/profile/root/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    super.id,
    super.firstname,
    super.lastname,
    super.email,
    super.dateOfBirth,
    super.gender,
    super.phone,
    super.avatar,
    super.notificationPreference,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      phone: json['phone'],
      avatar: json['avatar'],
      notificationPreference: json['notificationPreference'],
    );
  }
}
