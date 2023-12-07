class AuthConfigureEntity {
  final bool logoVisibility;
  final bool ssoVisibility;
  final String userOption;

  AuthConfigureEntity({
    required this.logoVisibility,
    required this.ssoVisibility,
    required this.userOption,
  });

  factory AuthConfigureEntity.fromJson(Map<String, dynamic> json) {
    return AuthConfigureEntity(
      logoVisibility: json['logoVisibility'],
      ssoVisibility: json['ssoVisibility'],
      userOption: json['userOption'],
    );
  }
}
