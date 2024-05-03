class AccountSetup {
  String? firstName;
  String? lastName;
  String? experienceChoice;
  String? workAvailabilityChoice;

  AccountSetup({
    this.firstName,
    this.lastName,
    this.experienceChoice,
    this.workAvailabilityChoice,
  });

  factory AccountSetup.fromMap(Map<String, dynamic> map) {
    return AccountSetup(
      firstName: map['firstName'] ?? 'NO DATA',
      lastName: map['lastName'] ?? 'NO DATA',
      experienceChoice: map['experienceChoice'] ?? 'NO DATA',
      workAvailabilityChoice: map['workAvailabilityChoice'] ?? 'NO DATA',
    );
  }
}
