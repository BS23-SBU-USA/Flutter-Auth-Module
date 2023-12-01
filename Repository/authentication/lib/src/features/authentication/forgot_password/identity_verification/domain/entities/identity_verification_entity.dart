class IdentityVerificationEntity {
  IdentityVerificationEntity({
    required this.message,
  });

  String message;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
