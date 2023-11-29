class LogOutEntity {
  LogOutEntity({
    required this.message,
  });

  String message;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
