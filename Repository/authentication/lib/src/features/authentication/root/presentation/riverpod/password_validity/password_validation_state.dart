class PasswordValidationState {
  const PasswordValidationState({
    this.isLengthValid = false,
    this.hasUpper = false,
    this.hasLower = false,
    this.hasNumber = false,
    this.hasSpecialCharacter = false,
    this.isValid = false,
  });
  final bool isLengthValid;
  final bool hasUpper;
  final bool hasLower;
  final bool hasNumber;
  final bool hasSpecialCharacter;
  final bool isValid;

  PasswordValidationState copyWith({
    bool? isLengthValid,
    bool? hasUpper,
    bool? hasLower,
    bool? hasNumber,
    bool? hasSpecialCharacter,
    bool? isValid,
  }) {
    return PasswordValidationState(
      isLengthValid: isLengthValid ?? this.isLengthValid,
      hasUpper: hasUpper ?? this.hasUpper,
      hasLower: hasLower ?? this.hasLower,
      hasNumber: hasNumber ?? this.hasNumber,
      hasSpecialCharacter: hasSpecialCharacter ?? this.hasSpecialCharacter,
      isValid: isValid ?? this.isValid,
    );
  }
}
