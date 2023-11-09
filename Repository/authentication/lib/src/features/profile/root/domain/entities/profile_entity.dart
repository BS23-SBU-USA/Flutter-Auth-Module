class ProfileEntity {
  ProfileEntity({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.phone,
    this.countryCode,
    this.phoneWithoutCountryCode,
    this.avatar,
    this.notificationPreference,
  });

  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? dateOfBirth;
  String? gender;
  String? phone;
  String? countryCode;
  String? phoneWithoutCountryCode;
  String? avatar;
  bool? notificationPreference;
  String get fullName {
    firstname = firstname ?? 'firstName';
    lastname = lastname ?? 'lastName';
    final fullName = '$firstname $lastname';
    return fullName;
  }
}
