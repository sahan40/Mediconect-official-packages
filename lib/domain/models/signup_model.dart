class SignupModel {
  final String fullName;
  final DateTime? dateOfBirth;
  final String bloodType;
  final String knownAllergies;
  final String contactName;
  final String relationship;

  const SignupModel({
    this.fullName = '',
    this.dateOfBirth,
    this.bloodType = 'A+',
    this.knownAllergies = '',
    this.contactName = '',
    this.relationship = '',
  });

  SignupModel copyWith({
    String? fullName,
    DateTime? dateOfBirth,
    String? bloodType,
    String? knownAllergies,
    String? contactName,
    String? relationship,
  }) {
    return SignupModel(
      fullName:        fullName        ?? this.fullName,
      dateOfBirth:     dateOfBirth     ?? this.dateOfBirth,
      bloodType:       bloodType       ?? this.bloodType,
      knownAllergies:  knownAllergies  ?? this.knownAllergies,
      contactName:     contactName     ?? this.contactName,
      relationship:    relationship    ?? this.relationship,
    );
  }
}