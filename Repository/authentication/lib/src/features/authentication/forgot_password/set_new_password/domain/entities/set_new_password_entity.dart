class SetNewPasswordEntity {
  SetNewPasswordEntity({
    required this.message,
  });

  String message;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
