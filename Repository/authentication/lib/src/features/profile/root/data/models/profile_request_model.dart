class ProfileRequestModel {
  ProfileRequestModel({
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.gender,
    required this.phone,
    required this.avatar,
  });

  String? firstname;
  String? lastname;
  String? dateOfBirth;
  String? gender;
  String? phone;
  String? avatar;

  Map<String, dynamic> toJson() {
    return {
      if (firstname != null && firstname!.isNotEmpty) 'firstname': firstname,
      if (lastname != null && lastname!.isNotEmpty) 'lastname': lastname,
      if (dateOfBirth != null && dateOfBirth!.isNotEmpty)
        'dateOfBirth': dateOfBirth,
      if (gender != null && gender!.isNotEmpty) 'gender': gender,
      if (phone != null && phone!.length >= 10) 'phone': phone,
      if (avatar != null && avatar!.isNotEmpty) 'avatar': avatar,
    };
  }
}
