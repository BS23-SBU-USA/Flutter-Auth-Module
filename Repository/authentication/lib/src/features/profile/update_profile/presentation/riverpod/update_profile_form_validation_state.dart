class UpdateProfileFormValidationState {
  const UpdateProfileFormValidationState({
    this.isValid = true,
  });
  final bool isValid;

  UpdateProfileFormValidationState copyWith({
    bool? isValid,
  }) {
    return UpdateProfileFormValidationState(
      isValid: isValid ?? this.isValid,
    );
  }
}
